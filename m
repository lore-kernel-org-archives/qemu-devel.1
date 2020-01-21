Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71D4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985DB21734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4nZdP1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985DB21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itojk-0001p7-LB
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 03:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itoik-00015v-B6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itoie-0008L5-9m
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:17:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43567
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itoid-0008Kt-SI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579594622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RX1NdiofVns1m/RGUlWU8JirtGlYxfdz1v121edX3KY=;
 b=P4nZdP1gjd5t2XErxFrQqmiMnPgrWleVxGiQM9WrMLLc7o4sz0lS/nF0xq2InDlQCuOsC9
 4TzFzDsbWgiJctFw4D5avr8jWt+rZC6SRd6KUf4436iegrcbpZ7Q+mcMIfFseo3kAn3C38
 cPouKrhmreHZI0uFcwzVsFqUpFuTg0U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-YOVfLOBIMZqdF_-k389Ysg-1; Tue, 21 Jan 2020 03:16:59 -0500
Received: by mail-wm1-f72.google.com with SMTP id 7so180094wmf.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 00:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0ONI3DX+wbnBxyyZWtshIjjq2Pe9PrcPf4FEH3DCsuQ=;
 b=MFXdr/SKzTbUTDBToWUrAYLuHByIfNfzscs6AmAmNK8LAxKihJI6/CfU5ZP5FtQjKr
 kOCqIDNLkG4BRFp3BqXsERyU31OKoCgFaxxjWsgE+dYUSnZ9m7Q2KVmcbHE1VbOdt1Mf
 eNPa43Vtrx1PRRc5icq5DY3Gc8FVUH7psja3VBIbgbsxyP426b74oaMufwf2o1kEc3qv
 aefdEX47Ai7G4Z9XC7qxZOY0e+ub1os7zRCX+aPA7o1EYVE8zVb7mBGqL6hjcTulZRrE
 9vmw3bchloupyE6mItazKqUuDkLt/7MTyNFTs1iB/uNdeFOozYJphimX9nCNrbnxCCbg
 2n3w==
X-Gm-Message-State: APjAAAWtXd0k47utHjqZ7Dbi4YP9AH0g5sbcLRX4R8NHeXFCVmN79WO8
 T3K4O0N9x62aWvqwPza97PUKmDcevOUU5/p0TtxgUslYQe/PXHMC4WSLPMmP2wZemC74tuvjApe
 67B3Zt4sPdL9FE7Q=
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr3771906wrn.384.1579594618208; 
 Tue, 21 Jan 2020 00:16:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJ4S7Z1uyZI3b8qTsKkk8IVlc89bCyKr3IpZ5L4O0PIwZ+rsizLQFvbSVwxcqw2/fhOJa+Qg==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr3771878wrn.384.1579594617828; 
 Tue, 21 Jan 2020 00:16:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9?
 ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
 by smtp.gmail.com with ESMTPSA id p17sm51204552wrx.20.2020.01.21.00.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 00:16:57 -0800 (PST)
Subject: Re: [RFC PATCH] qapi: Incorrect attempt to fix building with
 MC146818RTC=n
To: Markus Armbruster <armbru@redhat.com>
References: <20191231184916.10235-1-philmd@redhat.com>
 <875zhfzc9l.fsf@dusky.pond.sub.org>
 <a06fd97c-b149-2f24-1180-4e4efa8ff79d@redhat.com>
 <87wo9ll5on.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b0559940-7b97-901b-5729-587d8649eede@redhat.com>
Date: Tue, 21 Jan 2020 09:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87wo9ll5on.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: YOVfLOBIMZqdF_-k389Ysg-1
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/20 06:49, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 13/01/20 15:01, Markus Armbruster wrote:
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>
>>>> When configured with --without-default-devices and setting
>>>> MC146818RTC=3Dn, the build fails:
>>>>
>>>>     LINK    x86_64-softmmu/qemu-system-x86_64
>>>>   /usr/bin/ld: qapi/qapi-commands-misc-target.o: in function `qmp_mars=
hal_rtc_reset_reinjection':
>>>>   qapi/qapi-commands-misc-target.c:46: undefined reference to `qmp_rtc=
_reset_reinjection'
>>>>   /usr/bin/ld: qapi/qapi-commands-misc-target.c:46: undefined referenc=
e to `qmp_rtc_reset_reinjection'
>>>>   collect2: error: ld returned 1 exit status
>>>>   make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
>>>>   make: *** [Makefile:483: x86_64-softmmu/all] Error 2
>>>>
>>>> This patch tries to fix this, but this is incorrect because QAPI
>>>> scripts only provide TARGET definitions, so with MC146818RTC=3Dy we
>>>> get:
>>>>
>>>>   hw/rtc/mc146818rtc.c:113:6: error: no previous prototype for =E2=80=
=98qmp_rtc_reset_reinjection=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>>     113 | void qmp_rtc_reset_reinjection(Error **errp)
>>>>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>>   cc1: all warnings being treated as errors
>>>>   make[1]: *** [rules.mak:69: hw/rtc/mc146818rtc.o] Error 1
>>>>
>>>> Any idea? :)
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>  qapi/misc-target.json | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>> index a00fd821eb..8e49c113d1 100644
>>>> --- a/qapi/misc-target.json
>>>> +++ b/qapi/misc-target.json
>>>> @@ -41,7 +41,7 @@
>>>>  #
>>>>  ##
>>>>  { 'command': 'rtc-reset-reinjection',
>>>> -  'if': 'defined(TARGET_I386)' }
>>>> +  'if': 'defined(TARGET_I386) && defined(CONFIG_MC146818RTC)' }
>>>> =20
>>>> =20
>>>>  ##
>>>
>>> The generated qapi-commands-misc-target.h duly has
>>>
>>>     #if defined(TARGET_I386) && defined(CONFIG_MC146818RTC)
>>>     void qmp_rtc_reset_reinjection(Error **errp);
>>>     void qmp_marshal_rtc_reset_reinjection(QDict *args, QObject **ret, =
Error **errp);
>>>     #endif /* defined(TARGET_I386) && defined(CONFIG_MC146818RTC) */
>>>
>>> mc146818rtc.c includes it.  But since it doesn't include
>>> config-devices.h, CONFIG_MC146818RTC remains undefined, and the
>>> prototype gets suppressed.
>>>
>>> Crude fix: make mc146818rtc.c #include "config-devices.h".
>>
>> Can we modify the code generator to leave out the #if from the header,
>> and only include it in the .c file?  An extra prototype is harmless.
>=20
> Is *everything* we generate into headers just as harmless?

It should be, since it's just the C version of some JSON.  The only
problematic thing could be different definitions of the same command for
multiple targets, and I think we want to avoid that anyway.

To see it a different way, these are the "C bindings" to QMP, just that
the implementation is an in-process call rather than RPC.  If the QAPI
code generator was also able to generate Python bindings and the like,
they would have to be the same for all QEMU binaries, wouldn't they?

Paolo


