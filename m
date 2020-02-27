Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0E2C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813F9246A2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSgK9/XZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813F9246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7N4H-0004bH-My
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7N3M-00049n-Fn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7N3J-0005fv-9I
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:34:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47080
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7N3J-0005fO-00
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582824863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bea554m7+KZSmtH3mbtPAmLrA4Nlm7LRSi4+3x4+92E=;
 b=QSgK9/XZyzSP7qk9qjW14J/3Su3bcstvzbzpNrpbJW6s3N+iWJCQySvqHCrqtKDaX4hhC0
 Umj15h8Hmi21pvfTaG0n4BYbwKpqLJ6nLO3u9ao47cTAaVc7Hyc6Ve7ZGKJGjnn1UtToAH
 5k3FleZuh/1oLiACJrQ+DvNbxI3pCPI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-FyLRzzBdNJ2qOPhmU4iSzQ-1; Thu, 27 Feb 2020 12:34:21 -0500
X-MC-Unique: FyLRzzBdNJ2qOPhmU4iSzQ-1
Received: by mail-wm1-f71.google.com with SMTP id 7so21592wmf.9
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 09:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T6wSGFVEgA0x3WWSiunWzGjRyV1w9bxG8ztvsYY7tcM=;
 b=Lcsehv0vLM2gRLM1DHsEd9gJHGKhdQgWEKWaGqAQskhOE4Q9HYv3tzxtRctji1FT3v
 fKe3RR41qkjTJz2ZPfbNCvIYHb5dxd76GUBsibdOCvwk1JmmrEFm8+5fPvWqG3XlbpT4
 wwCMcfWQPkSxhCkMl0ExI485iarwySmz/QjlSJ3+gzceQzq38+bhKh3Vwr+V1GwraQQ6
 fdyR0+43kKjP+FIcVvZqliDbAb1nfSboZJWSNDyyoZTicUaTPAho1geiXZo49G4RUb9n
 ZRzugdsTubKL7QjMiIHLP225fRMzVjgkmXwMJIuYRf37yBUTEbEIMAxxUcA4Ue1GBQOo
 z9rQ==
X-Gm-Message-State: APjAAAXfINsmQ6F4vaL6k0u0qCOzCnj33JjaQUzB89DbIURH/GIbDjPH
 PyoiC1jEAeu/mqcb+crTNlYkNB2x346cizCU8ed0icKsU5c+026J/kwfsvBEwqFO2+Vs9cL0XXS
 vegcKDIMQ/jGDioE=
X-Received: by 2002:a5d:674c:: with SMTP id l12mr6024449wrw.351.1582824860078; 
 Thu, 27 Feb 2020 09:34:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpQdAgSQJ7os3qoE2YSTb1Rt3W81L+mb4UVMly6B0Z3HgWAuj2rBuoNOG28uYPd0Kj12wG4Q==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr6024422wrw.351.1582824859859; 
 Thu, 27 Feb 2020 09:34:19 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id n3sm7162685wmc.42.2020.02.27.09.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 09:34:19 -0800 (PST)
Subject: Re: [PATCH v2 6/6] qga: Improve error report by calling
 error_setg_win32()
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20200227163101.414-1-philmd@redhat.com>
 <20200227163101.414-7-philmd@redhat.com>
 <CAMxuvaxi=aYxapo1K4XtO_Xoc==+b+j9w0PeotkN=neqcqdYzg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fbfdcee9-2a9c-2685-6b7b-1dcdad7080ae@redhat.com>
Date: Thu, 27 Feb 2020 18:34:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxi=aYxapo1K4XtO_Xoc==+b+j9w0PeotkN=neqcqdYzg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 6:20 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Feb 27, 2020 at 5:32 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Use error_setg_win32() which adds a hint similar to strerror(errno)).
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   qga/channel-win32.c  | 3 ++-
>>   qga/commands-win32.c | 6 +++---
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/qga/channel-win32.c b/qga/channel-win32.c
>> index 774205e017..4f04868a76 100644
>> --- a/qga/channel-win32.c
>> +++ b/qga/channel-win32.c
>> @@ -308,7 +308,8 @@ static gboolean ga_channel_open(GAChannel *c, GAChan=
nelMethod method,
>>       }
>>
>>       if (method =3D=3D GA_CHANNEL_ISA_SERIAL && !SetCommTimeouts(c->han=
dle,&comTimeOut)) {
>> -        g_critical("error setting timeout for com port: %lu",GetLastErr=
or());
>> +        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError()=
);
>> +        g_critical("error setting timeout for com port: %s", emsg);
>>           CloseHandle(c->handle);
>>           return false;
>>       }
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index 2461fd19bf..8e1f32ea23 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -315,8 +315,7 @@ void qmp_guest_shutdown(bool has_mode, const char *m=
ode, Error **errp)
>>       }
>>
>>       if (!ExitWindowsEx(shutdown_flag, SHTDN_REASON_FLAG_PLANNED)) {
>> -        slog("guest-shutdown failed: %lu", GetLastError());
>> -        error_setg(errp, QERR_UNDEFINED_ERROR);
>> +        error_setg_win32(errp, GetLastError(), "guest-shutdown failed")=
;
>=20
> did you drop the slog() intentionally?

Oops no :(

>=20
>>       }
>>   }
>>
>> @@ -1319,7 +1318,8 @@ static DWORD WINAPI do_suspend(LPVOID opaque)
>>       DWORD ret =3D 0;
>>
>>       if (!SetSuspendState(*mode =3D=3D GUEST_SUSPEND_MODE_DISK, TRUE, T=
RUE)) {
>> -        slog("failed to suspend guest, %lu", GetLastError());
>> +        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError()=
);
>> +        slog("failed to suspend guest: %s", emsg);
>>           ret =3D -1;
>>       }
>>       g_free(mode);
>> --
>> 2.21.1
>>
>=20


