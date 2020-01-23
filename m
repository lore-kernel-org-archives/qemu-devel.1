Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC42C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265AB21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhJ25hD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265AB21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuj6z-0002TK-90
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuhWq-00052D-UN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuhWn-0003Jg-RJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:48:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57059
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuhWn-0003Ja-O9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579805309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmacIV8cWQXcXOgkO9yiGB4dHnGn1yEeINWNajQRXUA=;
 b=GhJ25hD+RUUEuB3oJLGbQ1JFZRQw8BMrt81TfaAtwRRVPmN61qrJCvTLqfMMP+19tysI+t
 lncMthJYJssIN71xWHmq1SdCP0IeIG3nBwHh1vROqLDDyTJMIM/PuOWMLTC1hNIcb+e0/L
 LsaZ7xYqLCGcFT+eIFmrIFONWm6J3P0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-B9HbO9ikO1yvmUQS-6_y0g-1; Thu, 23 Jan 2020 13:48:24 -0500
Received: by mail-wr1-f72.google.com with SMTP id f17so2341188wrt.19
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 10:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3x/8NNjdVDDhizKbdYFldCySL8YJ0uWvbImRLGGjuGI=;
 b=SK+qr+0jkebs+CMP1P3isx1P7NtUkr+sUWNwsO2bVrTzCHAs2YThApRi5DROUAnzQ5
 F9LI5qbNuOWaaSHdW47duhK0bZ4TftE9eNiVMfM1nXl8VQ1NCR06o37RFhldhp0qndSk
 jRHc4F8ewIzIvCR4EhscjDdMEc4kvxlBnKFqYUOec63P74oojhUfdyfv+0zSEVumKMQr
 kXLAD0xvWAlAUOOtyd+5DgkUi19MztIpyw/9emKsJM3/9v+8EQyHtI6wst3+pTO3HD9u
 jaUr0BjAsrN2siI1+GxYle+HAJe0BYNiZZdaq5cdgDYZNIA4XvN/7JwVVtsBit5bJCla
 Crcw==
X-Gm-Message-State: APjAAAUzhl7QDoUKR5nw4WDxHnyd5CyvDI+RT8Uuck9+r8DmD9qPwc1l
 YNWQtvRFQUzYg7I1U0owwNRGDyX66E8fM3PQuiHmu1xQP8P1tj2O4+jPjr/m1WEiw21RZpk57wx
 kvab+GAH/YeNc0GA=
X-Received: by 2002:adf:f604:: with SMTP id t4mr17681877wrp.33.1579805302972; 
 Thu, 23 Jan 2020 10:48:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcp6ZmdrBDSrt6gt0Lv/QXcnUupR5kKMiKdiRhwhVhvL1iswS2FMkvlsJdA40rOY4VCR2Pmg==
X-Received: by 2002:adf:f604:: with SMTP id t4mr17681856wrp.33.1579805302722; 
 Thu, 23 Jan 2020 10:48:22 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id l17sm4139128wro.77.2020.01.23.10.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 10:48:22 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v5 1/6] machine: Convert the valid cpu types
 to use cpu_model
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20180205224205.GA3291@localhost.localdomain>
 <20180206154320.288acdc2@redhat.com>
 <62d7649e-e85d-43a2-2df8-85e2a0953e89@redhat.com>
 <20190617170106.48d776ca@redhat.com>
 <0a31228d-4d32-2c54-649b-6aef9953fffc@redhat.com>
 <20190617173343.68e3c9ec@redhat.com> <20190617162700.GC19178@habkost.net>
 <20190618133410.18b93bcd@redhat.com> <20190618135516.GH19178@habkost.net>
 <20190620110239.6c4c092d@redhat.com> <20190620144328.GA1862@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <87908f05-f14a-c502-db0b-96f849d018d1@redhat.com>
Date: Thu, 23 Jan 2020 19:48:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20190620144328.GA1862@habkost.net>
Content-Language: en-US
X-MC-Unique: B9HbO9ikO1yvmUQS-6_y0g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: marcel@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 4:43 PM, Eduardo Habkost wrote:
> On Thu, Jun 20, 2019 at 11:02:39AM +0200, Igor Mammedov wrote:
>> On Tue, 18 Jun 2019 10:55:16 -0300
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>>> On Tue, Jun 18, 2019 at 01:34:10PM +0200, Igor Mammedov wrote:
>>>> On Mon, 17 Jun 2019 13:27:00 -0300
>>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>   =20
>>>>> On Mon, Jun 17, 2019 at 05:33:43PM +0200, Igor Mammedov wrote:
>>>>>> On Mon, 17 Jun 2019 17:15:21 +0200
>>>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>>> [...]
>>>>>>> Yes. Eduardo and you should write some lines to explain this, and t=
hen
>>>>>>> we will follow :)
>>>>>> Unfortunately I don't recall details anymore. One could check out al=
l
>>>>>> implementations of class_by_name callbacks to find out current state=
.
>>>>>
>>>>> See this message for a summary of existing class_by_name quirks:
>>>>>
>>>>>    https://www.mail-archive.com/qemu-devel@nongnu.org/msg615503.html
>>>>>    Date: Wed, 08 May 2019 10:34:44 +0200
>>>>>    Message-ID: <877eb173a3.fsf@dusky.pond.sub.org>
>>>>>    Subject: Re: [Qemu-devel] [PATCH 0/7] Delete 16 *_cpu_class_by_nam=
e() functions
>>>>>
>>>>> I'm unsure about Igor's suggestion to get rid of CPU model names
>>>>> and use only QOM type names in external interfaces.  In either
>>>>> case, we can still simplify the rules rules and reduce the amount
>>>>> of arch-specific code.
>>>> as far as we have cpu_class_by_name, we have to watch over that
>>>> new patches/targets won't add some custom handling/fallbac/whatnot.
>>>
>>> We can get rid of CPUClass::cpu_class_by_name() without changing
>>> the external interfaces provided by QEMU.
>> if you mean QMP, than it is possible to keep model there where
>> it already exists. Based on experiment [1](x86) I did, it's local to
>> affected target and doesn't pollute other code.
>=20
> I mean both command line and QMP.
>=20
>>
>>> I don't have a strong opinion about using only QOM types at -cpu,
>>> yet.  But first we need to get rid of the arch-specific CPU model
>>> name exceptions enumerated at the URL above (which would be very
>>> welcome).
>> One way to get rid of them is to deprecate them in favor of strict
>> match (no fallback/substitutions/aliases) to typename and when we
>> drop it make switch type based naming only.
>=20
> This is true, but is it desirable?  Aren't we just moving
> complexity elsewhere?  Management software would still need to
> translate CPU models from existing VM configurations to QOM type
> names.
>=20
>>
>> 1) I've just took a quick look at how much of duplicated/confusing
>> code we could get rid off if we drop cpu_class_by_name/*_cpu_list.
>> It amounts to >800LOC of trivial removal (not counting ppc/s390
>> that depend on model naming heavily and in need of some non
>> trivial refactoring)
>=20
> Removing the code might be trivial.  Coordinating with the
> maintainers of all architectures to confirm this is really
> something everybody wants is the difficult part.
>=20
> If you really want to do it, please make sure all the
> architecture maintainers (and libvirt developers) are involved in
> the discussion.

 From the previous link (summary of existing class_by_name quirks):
https://www.mail-archive.com/qemu-devel@nongnu.org/msg615737.html

   "Deprecating unwanted stuff now is likely to make a
    later cleanup so much easier."

This was 8 months ago :/

IIUC we need to restart this topic addressing the libvirt community=20
first, then see with the QEMU one?

>=20
>>
>>>
>>>>
>>>> On contrary -device works just with type names for all devices,
>>>> applying the same to -cpu which is basically translator
>>>>     model->type[,-global type.foo,...]
>>>> would be consistent with -device and less confusing for everyone
>>>> (not counting significant code reduction).
>>>> It would certainly simplify contributing new targets as contributor
>>>> won't have to care about cpu model naming and do something about it.
>>>>
>>>> This option wasn't considered before because we didn't have deprecatio=
n
>>>> back then, but now it opens possibility to simplify qemu and consolida=
te
>>>> naming. (we probably would be able to fold '-cpu help' into '-device h=
elp'
>>>> as well).
>>>>   =20
>>>
>>
>=20


