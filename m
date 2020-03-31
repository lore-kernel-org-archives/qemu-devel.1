Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028822080C
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1koVPd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028822080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJN2G-0005Wu-6P
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 15:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJN1B-000578-NP
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJN1A-0007O6-C2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:57:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJN1A-0007Lu-7j
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585684666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iodLOoIbjBykbWxsHrbGHZY4Or59f+vh/5SumfQfc+s=;
 b=D1koVPd/MMxHkl5J9XC0EwTxhAA6dnRksRtVMkzk9esmjOlzZ5sivyTozfaEWrbo9WinIm
 u1Ylf7o4uClfhusXfEkogGQ0blSdtanciduFGvH62IHE3ZC7vq5sONkyP5Kx2CKw8d6jmS
 PGiOvdJNHDqvKq5a7gxOXFCFdPS04NA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-NLIrxXLXNS6I2HRzVvU7jA-1; Tue, 31 Mar 2020 15:57:44 -0400
X-MC-Unique: NLIrxXLXNS6I2HRzVvU7jA-1
Received: by mail-ed1-f72.google.com with SMTP id f19so19620361edt.5
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 12:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pVx57C5Mld/SZP5O5HZmhm41m4j/ht+LpAHw6yDcWow=;
 b=Mj7GODUaF6XEDkMrl3XF1W18ZRk90qq6KTExcratCkCOQmRsUxKu4Dpnmf5SrIWe9+
 Sx2Ive2tyfY2GYHq2c8gyt0PfC+8YqJRtiJjrypbKcpcXLKReiOIjYzKSSGo9jiIsv64
 u3oDvT983At3YMA0AfVECQe8R7ZeHO6BU0WVeFArrccN9iKlLEFqbPSqF7rG2zDud7wG
 u1VblhwDt1+gHpAh8hi1jjnmEm8oYgwOIQPLzvXiYeeywt1MkY5pAI74X92G/TLtfuAQ
 aYdTUfXqf0FR4j65JG5napHoEoOeSGn2Fp/bnCEul6VAsntJKYYHj+dI3KTnvSKYq19a
 7zyw==
X-Gm-Message-State: ANhLgQ324gTR7VhHvNl6PAj/HFHOj8iBZbFvXdpzwdrivn8//7k1an0l
 jAKgKC3rrU6l1GAJR1rYwXSVdof67ZNvEp8QXhtTROgcBQxScwM6CSSgEYBtB8EG6o7fIzjYkhb
 ZPhSBndlp9vtaaoE=
X-Received: by 2002:a05:6402:c0d:: with SMTP id
 co13mr17027333edb.266.1585684662578; 
 Tue, 31 Mar 2020 12:57:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsmnPO+z2CQtwUb5kezzq2xGoqDMmFy0GVl+SxucojNwFZpp7OgBpcu4AvC3A1FYT2wvrQuaA==
X-Received: by 2002:a05:6402:c0d:: with SMTP id
 co13mr17027313edb.266.1585684662402; 
 Tue, 31 Mar 2020 12:57:42 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id rp7sm2293216ejb.83.2020.03.31.12.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 12:57:41 -0700 (PDT)
Subject: Re: [PATCH v3] configure: warn if not using a separate build directory
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200331171606.386801-1-berrange@redhat.com>
 <32d8b69d-1641-f200-e86e-062de6c93caf@redhat.com>
 <875zeks7ix.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d9b10ec-c7a1-164b-a722-f155b118ba55@redhat.com>
Date: Tue, 31 Mar 2020 21:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <875zeks7ix.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 8:28 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 3/31/20 12:16 PM, Daniel P. Berrang=C3=A9 wrote:
>>> Running configure directly from the source directory is a build
>>> configuration that will go away in future. It is also not currently
>>> covered by any automated testing. Display a deprecation warning if
>>> the user attempts to use an in-srcdir build setup, so that they are
>>> aware that they're building QEMU in an undesirable manner.
>>>
>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> ---
>>>
>>
>>> +if test "$in_srcdir" =3D "yes"; then
>>> +    echo
>>> +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
>>> +    echo
>>> +    echo "Support for running the 'configure' script directly from the=
"
>>> +    echo "source directory is deprecated. In source dir builds are not=
"
>>> +    echo "covered by automated testing and thus may not correctly buil=
d"
>>> +    echo "QEMU. Users are recommended to use a separate build director=
y:"
>>
>> Our mails crossed. I still think this reads a bit awkwardly; maybe:
>>
>> s/IN SOURCE DIR BUILDS/BUILDING IN THE SOURCE DIR/
>> s/In source dir builds/In-tree builds/
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Preferably with Eric's tweaks:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


