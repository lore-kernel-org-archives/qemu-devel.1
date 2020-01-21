Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7857C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEA822522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2Wlt6cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEA822522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itr7m-0007yh-D2
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itr6P-0006Vo-Cd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itr6O-0000uE-3K
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:49:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27367
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itr6N-0000tv-Vm
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579603783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSa46ZYyGmie/bVkHIG0X5JHtwyUvx9RKZ7BbDRX9ZM=;
 b=i2Wlt6cOqD0vEJgwsAkUf8YuRZMz/AJu201qi38dmcGhPHhLxhX9S3xbiTT6zuRNsVD1QY
 FYPmvdNL1FLcMXNixPN/ZXEhqd3y4ODyVhEtVVMiJ/bWd5M5oFUkPL+XCuEfb7beP4GLsf
 YxTaVkPcL2TXUYy40pNxaQ8mM139+xg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-fsE5l_Q0NCSJJ-ZPn9pzXQ-1; Tue, 21 Jan 2020 05:49:38 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so1126118wrm.16
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 02:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IDMnGMJ6Cs/whFH4XpRx3WeUmxqpk22bAwxooOpZMug=;
 b=PYi/89ZLw/gA/3YOPttoc3AtJUUt4hu6Faq3BXZAIHnfO9f1PzGTKoL/kCSigfdfOO
 1809lk8f+eMA4eaM1GdfO5b5YJQaWiaJaRoXruZ96S3KLCEh1ZGpfIlDkiddp+5UlTxs
 dAAOdasFjDCHJ4H/0+u4JJTU3rBAG2RtNs61Xp0K1zIYN6NXwd9dkN8L0Vn3sAjwxZ48
 LnKk4vaYsYelFcDOiXIMmpcXwmcUh4fxVXZ049R5tW6WpMeFXHE4FsBvMChQNiiI73yS
 W+IS4VVsjjAhXPD+GaXZcKapz9xAm6QzWyP39BMR9XUTtC4+MZgi83sUcmclVP4Uxr9q
 PQmQ==
X-Gm-Message-State: APjAAAUJ9eTvJo4P6odSinPGQoqJerWKN40pYwc1Byq3sIXqbDSC4+e6
 NAl9CW7rsJC8xBr9YJuNCYBjPvTqt0lNodvCe+HqflYu9jNGC3YYX1rascmNYdF+8fL/+RyBANe
 J4jNuEqJbtgiLPY4=
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr3830829wmj.39.1579603777204; 
 Tue, 21 Jan 2020 02:49:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGgPRbDGWXfiDpsQoV7Fde7/+KMQy7QRwbv8JZ8kZVmU295Mk9Ff6VypESFdv/IqR1lYIGdA==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr3830811wmj.39.1579603776906; 
 Tue, 21 Jan 2020 02:49:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a?
 ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
 by smtp.gmail.com with ESMTPSA id k7sm3243589wmi.19.2020.01.21.02.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 02:49:36 -0800 (PST)
Subject: Re: [PATCH 0/6] Fix more GCC9 -O3 warnings
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
References: <20191217173252.4672-1-philmd@redhat.com>
 <84fthiaahd.wl-Peter.Chubb@data61.csiro.au>
 <87a77q9njk.fsf@dusky.pond.sub.org>
 <97c34bbd-79d2-070e-a35e-4fdf68b2e291@redhat.com>
 <db49a831-df35-c209-5db5-0631a5ef2497@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12b8431d-3d29-cdbe-b952-eac23c35be0a@redhat.com>
Date: Tue, 21 Jan 2020 11:49:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <db49a831-df35-c209-5db5-0631a5ef2497@redhat.com>
Content-Language: en-US
X-MC-Unique: fsE5l_Q0NCSJJ-ZPn9pzXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Hannes Reinecke <hare@suse.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/01/20 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Paolo,
>=20
> On 1/18/20 8:24 PM, Paolo Bonzini wrote:
>> On 18/12/19 07:05, Markus Armbruster wrote:
>>> "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
>>> writes:
>>>
>>>>>>>>> "Philippe" =3D=3D Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>=
 writes:
>>>>
>>>> Philippe> Fix some trivial warnings when building with -O3.
>>>>
>>>> For compatibility with lint and other older checkers, it'd be good
>>>> to keep
>>>> this as /* FALLTHROUGH */ (which gcc should accept according to its
>>>> manual).
>>>
>>> We have hundreds of /* fall through */ comments already.
>>>
>>>> Fixing the comments' placement is a different matter, and should be
>>>> done.=C2=A0 Seems to me that until gcc started warning for this, noone=
 had
>>>> actually run a checker, and the comments were just for human info.
>>>>
>>>> Peter C
>>>
>>
>> Queued, thanks.
>=20
> Thanks, but I sent a v2 (20191218192526.13845-1-philmd@redhat.com) with:
>=20
> - addressed Thomas and Aleksandar comments
> - dropped 'hw/scsi/megasas: Silent GCC9 duplicated-cond warning'
> - dropped 'qemu-io-cmds: Silent GCC9 format-overflow warning'
>=20
> See:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg666280.html
>=20
> Can you queue it instead?

Yes, I replaced it.

Paolo


