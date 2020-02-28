Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBF9C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC0C246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0Im7OD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC0C246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cP8-00050F-QF
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7cOV-0004Sn-89
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7cOS-0004U0-Pt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:57:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7cOS-0004Tq-LM
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582883836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=da4y9y4yA62tHt4SjYkKbPbqwef8WeKvS0mmTOwn/OU=;
 b=L0Im7OD+akE3VKjejlXIzcCk2wNqRCn4IUuOvrw9DsptlW+kEhixOPQ7+MJ3nO7HkDxKnC
 nGIBOb7N2Llc8xlhhV6ygu6hKtejjQ5S4Fq3FKwtjjn0ry0MYFDxM9tNrbyAcvV0LhP/9o
 eTKjycIXyQkLr9nWcBpjilHFyOZsLks=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-UxIrZ-nfNR2OXdYKKsNouA-1; Fri, 28 Feb 2020 04:57:14 -0500
X-MC-Unique: UxIrZ-nfNR2OXdYKKsNouA-1
Received: by mail-wr1-f70.google.com with SMTP id r1so1105221wrc.15
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 01:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QuoNpRlqYFDqyXV6/enEurJh9dc9Z2rHXZEADTIRwU0=;
 b=d/ALdkWWQ7lsybLrzrXD53tDWFJRYdflXU0ir7ESmoliJk9qh/5UBSbQ9yllJQAiO4
 K9q4HHzyuzW8peCh7GVZ75hJJZclXev4uuRIrQyb2lYvahJfrxfxgK3/j/M3kLYv/Loc
 WJI4YF/04v0gjOaH/2BO7NJffwrNrmc77Ll8E34TqaQ9cx2VsixmsoJFz+xwbV3i9XGQ
 SMROECMbUTAWEKubVlYOJ6WFoxDj3SuUkJGeBTcUKCt2yklmre5aiCJGglknL28MA5bP
 1T6idwuSqrP87eed9skRyVMha0awZ8GephxraKi7xeWGwNLbZ95AIO7w25A3tRezDruZ
 r3Dw==
X-Gm-Message-State: APjAAAUyFgHLqabNBA5FB2d+Er+Dogle8CMAbq6UNsm/Ft3N9+5+oCA2
 JX9cNYmRX7gojpPwRDh+xnDWnunX0OCkVGFp0EKRBwiRlPMKp/Csx1NX9HhD6Ew/GigiFcqXtTr
 WySlvEs89nIzqnPE=
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr4382675wrn.347.1582883832804; 
 Fri, 28 Feb 2020 01:57:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqztaaKO7m/jDshpqkmw4lDCDaJE+OHQkP+oJ2dyAdyLVyxeuEKrzIE7SY33KQpRTVjvJx/+DA==
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr4382628wrn.347.1582883832338; 
 Fri, 28 Feb 2020 01:57:12 -0800 (PST)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id m68sm1417987wme.48.2020.02.28.01.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 01:57:11 -0800 (PST)
Subject: Re: [PATCH v2 2/6] util: Replace fprintf(stderr, "*\n" with
 error_report()
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20200227163101.414-1-philmd@redhat.com>
 <20200227163101.414-3-philmd@redhat.com> <87ftevma26.fsf@dusky.pond.sub.org>
 <12c7c23b-2a6f-6a54-5974-13492d6fcd4f@redhat.com>
Message-ID: <b6b4f7fb-65bf-9b2d-fc0c-63456e70af6f@redhat.com>
Date: Fri, 28 Feb 2020 10:57:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <12c7c23b-2a6f-6a54-5974-13492d6fcd4f@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/28/20 10:50 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/28/20 8:43 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>>> From: Alistair Francis <alistair.francis@xilinx.com>
>>>
>>> Replace a large number of the fprintf(stderr, "*\n" calls with
>>> error_report(). The functions were renamed with these commands and then
>>> compiler issues where manually fixed.
>>>
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,=
=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N;N;N;N;N;N;N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N;N;N;N;N;N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N;N;N;N;N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N;N;N;N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N;N;N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N;N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N;N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>> find ./* -type f -exec sed -i \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 'N; {s|fprintf(stderr,=20
>>> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 {} +
>>>
>>> The error in aio_poll() was removed manually.
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> Message-Id:=20
>>> <f71203227749e2afb8564b3388b2b34f6652b009.1510181732.git.alistair.franc=
is@xilinx.com>=20
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> [PMD: Rebased]
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> Cc: Alistair Francis <Alistair.Francis@wdc.com>
>>> Cc: Alistair Francis <alistair@alistair23.me>
>>> ---
>>> =C2=A0 util/coroutine-sigaltstack.c |=C2=A0 3 ++-
>>> =C2=A0 util/mmap-alloc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++-----
>>> =C2=A0 util/module.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++-------
>>> =C2=A0 util/osdep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>>> =C2=A0 util/oslib-posix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>> =C2=A0 util/oslib-win32.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>> =C2=A0 util/qemu-coroutine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 10 +++++-----
>>> =C2=A0 util/qemu-thread-posix.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
>>> =C2=A0 util/qemu-thread-win32.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
>>> =C2=A0 util/qemu-timer-common.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>> =C2=A0 10 files changed, 33 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.=
c
>>> index f6fc49a0e5..63decd4d1d 100644
>>> --- a/util/coroutine-sigaltstack.c
>>> +++ b/util/coroutine-sigaltstack.c
>>> @@ -29,6 +29,7 @@
>>> =C2=A0 #include <pthread.h>
>>> =C2=A0 #include "qemu-common.h"
>>> =C2=A0 #include "qemu/coroutine_int.h"
>>> +#include "qemu/error-report.h"
>>> =C2=A0 typedef struct {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Coroutine base;
>>> @@ -80,7 +81,7 @@ static void __attribute__((constructor))=20
>>> coroutine_init(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pthread_key_create(&thread_state=
_key,=20
>>> qemu_coroutine_thread_cleanup);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "unable to =
create leader key: %s\n",=20
>>> strerror(errno));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("unable to cre=
ate leader key: %s",=20
>>> strerror(errno));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
>>> index 27dcccd8ec..3ac6e10404 100644
>>> --- a/util/mmap-alloc.c
>>> +++ b/util/mmap-alloc.c
>>> @@ -18,6 +18,7 @@
>>> =C2=A0 #endif /* CONFIG_LINUX */
>>> =C2=A0 #include "qemu/osdep.h"
>>> +#include "qemu/error-report.h"
>>> =C2=A0 #include "qemu/mmap-alloc.h"
>>> =C2=A0 #include "qemu/host-utils.h"
>>> @@ -63,7 +64,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (ret !=
=3D 0 && errno =3D=3D EINTR);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0) =
{
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpr=
intf(stderr, "Couldn't statfs() memory path: %s\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or_report("Couldn't statfs() memory path: %s",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strerror(errno));
>>
>> Indentation is off.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 exit(1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -160,10 +161,10 @@ void *qemu_ram_mmap(int fd,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 file_name[len] =3D '\0';
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpr=
intf(stderr, "Warning: requesting persistence across=20
>>> crashes "
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "for backend file %s failed. =
Proceeding without "
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "persistence, data might beco=
me corrupted in=20
>>> case of host "
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "crash.\n", file_name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or_report("Warning: requesting persistence across=20
>>> crashes "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "for backend file %s failed. Proceeding=20
>>> without "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "persistence, data might become corrupted=20
>>> in case "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "of host crash.", file_name);
>>
>> This should be something like
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 warn_report("requesting persistence across crashes"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 " for backend file %s failed",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 file_name);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 error_printf("Proceeding without persistence, data might=
"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 " become corrupted in case of host=20
>> crash.\n");
>>
>> Precedence: commit db0754df88 "file-posix: Use error API properly".
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 g_free(proc_link);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 g_free(file_name);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git a/util/module.c b/util/module.c
>>> index 236a7bb52a..28efa1f891 100644
>>> --- a/util/module.c
>>> +++ b/util/module.c
>>> @@ -19,6 +19,7 @@
>>> =C2=A0 #endif
>>> =C2=A0 #include "qemu/queue.h"
>>> =C2=A0 #include "qemu/module.h"
>>> +#include "qemu/error-report.h"
>>> =C2=A0 typedef struct ModuleEntry
>>> =C2=A0 {
>>> @@ -130,19 +131,17 @@ static int module_load_file(const char *fname)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_module =3D g_module_open(fname, G_MODU=
LE_BIND_LAZY |=20
>>> G_MODULE_BIND_LOCAL);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_module) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Failed to =
open module: %s\n",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 g_module_error());
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Failed to ope=
n module: %s", g_module_error());
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_module_symbol(g_module, DSO_STAMP=
_FUN_STR, (gpointer=20
>>> *)&sym)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Failed to =
initialize module: %s\n",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fname);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Failed to ini=
tialize module: %s", fname);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Print some in=
fo if this is a QEMU module (but from=20
>>> different build),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this wil=
l make debugging user problems easier. */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_module_sym=
bol(g_module, "qemu_module_dummy",=20
>>> (gpointer *)&sym)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpr=
intf(stderr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Note: only modules from the =
same build can be=20
>>> loaded.\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or_report("Note: "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "only modules from the same build can be=20
>>> loaded.");
>>
>> Use error_printf() to print the additional note.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_module_close(g=
_module);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>> @@ -178,7 +177,7 @@ bool module_load_one(const char *prefix, const=20
>>> char *lib_name)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static GHashTable *loaded_modules;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_module_supported()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Module is =
not supported by system.\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Module is not=
 supported by system.");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git a/util/osdep.c b/util/osdep.c
>>> index f7d06050f7..ef40ae512a 100644
>>> --- a/util/osdep.c
>>> +++ b/util/osdep.c
>>> @@ -484,7 +484,7 @@ void fips_set_state(bool requested)
>>> =C2=A0 #endif /* __linux__ */
>>> =C2=A0 #ifdef _FIPS_DEBUG
>>> -=C2=A0=C2=A0=C2=A0 fprintf(stderr, "FIPS mode %s (requested %s)\n",
>>> +=C2=A0=C2=A0=C2=A0 error_report("FIPS mode %s (requested %s)",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (fips_enabled ? "enabled" : "disabled"),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (requested ? "enabled" : "disabled"));
>>> =C2=A0 #endif
>>> @@ -511,7 +511,7 @@ int socket_init(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D WSAStartup(MAKEWORD(2, 2), &Data=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D WSAGetLa=
stError();
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "WSAStartup=
: %d\n", err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("WSAStartup: %=
d", err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atexit(socket_cleanup);
>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>> index 897e8f3ba6..4977594a43 100644
>>> --- a/util/oslib-posix.c
>>> +++ b/util/oslib-posix.c
>>> @@ -35,6 +35,7 @@
>>> =C2=A0 #include "sysemu/sysemu.h"
>>> =C2=A0 #include "trace.h"
>>> =C2=A0 #include "qapi/error.h"
>>> +#include "qemu/error-report.h"
>>> =C2=A0 #include "qemu/sockets.h"
>>> =C2=A0 #include "qemu/thread.h"
>>> =C2=A0 #include <libgen.h>
>>> @@ -170,7 +171,7 @@ fail_close:
>>> =C2=A0 void *qemu_oom_check(void *ptr)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ptr =3D=3D NULL) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Failed to =
allocate memory: %s\n",=20
>>> strerror(errno));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Failed to all=
ocate memory: %s", strerror(errno));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ptr;
>>> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>>> index e9b14ab178..84b937865a 100644
>>> --- a/util/oslib-win32.c
>>> +++ b/util/oslib-win32.c
>>> @@ -39,6 +39,7 @@
>>> =C2=A0 #include "trace.h"
>>> =C2=A0 #include "qemu/sockets.h"
>>> =C2=A0 #include "qemu/cutils.h"
>>> +#include "qemu/error-report.h"
>>> =C2=A0 /* this must come after including "trace.h" */
>>> =C2=A0 #include <shlobj.h>
>>> @@ -46,7 +47,7 @@
>>> =C2=A0 void *qemu_oom_check(void *ptr)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ptr =3D=3D NULL) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Failed to =
allocate memory: %lu\n",=20
>>> GetLastError());
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Failed to all=
ocate memory: %lu", GetLastError());
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ptr;
>>> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
>>> index c3caa6c770..62d1dd09df 100644
>>> --- a/util/qemu-coroutine.c
>>> +++ b/util/qemu-coroutine.c
>>> @@ -14,6 +14,7 @@
>>> =C2=A0 #include "qemu/osdep.h"
>>> =C2=A0 #include "trace.h"
>>> +#include "qemu/error-report.h"
>>> =C2=A0 #include "qemu/thread.h"
>>> =C2=A0 #include "qemu/atomic.h"
>>> =C2=A0 #include "qemu/coroutine.h"
>>> @@ -125,14 +126,13 @@ void qemu_aio_coroutine_enter(AioContext *ctx,=20
>>> Coroutine *co)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cause us=
 to enter it twice, potentially even after the=20
>>> coroutine has
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * been del=
eted */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scheduled) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpr=
intf(stderr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: Co-routine was already s=
cheduled in '%s'\n",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, scheduled);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or_report("%s: Co-routine was already scheduled in=20
>>> '%s'",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 __func__, scheduled);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 abort();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (to->caller) =
{
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fpr=
intf(stderr, "Co-routine re-entered recursively\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or_report("Co-routine re-entered recursively");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 abort();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -185,7 +185,7 @@ void coroutine_fn qemu_coroutine_yield(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_qemu_coroutine_yield(self, to);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!to) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Co-routine=
 is yielding to no one\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Co-routine is=
 yielding to no one");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>>> index 838980aaa5..b4d8de376c 100644
>>> --- a/util/qemu-thread-posix.c
>>> +++ b/util/qemu-thread-posix.c
>>> @@ -14,6 +14,7 @@
>>> =C2=A0 #include "qemu/thread.h"
>>> =C2=A0 #include "qemu/atomic.h"
>>> =C2=A0 #include "qemu/notify.h"
>>> +#include "qemu/error-report.h"
>>> =C2=A0 #include "qemu-thread-common.h"
>>> =C2=A0 static bool name_threads;
>>> @@ -25,14 +26,14 @@ void qemu_thread_naming(bool enable)
>>> =C2=A0 #ifndef CONFIG_THREAD_SETNAME_BYTHREAD
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* This is a debugging option, not fatal=
 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (enable) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "qemu: thre=
ad naming not supported on this=20
>>> host\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("qemu: thread =
naming not supported on this host");
>>
>> This isn't an error.=C2=A0 It's in response to -name debug-threads=3Don,=
 and
>> tells the user debug-threads=3Don is being ignored.=C2=A0 Let's use
>> warn_report().
>>
>> Drop the "qemu: ", please; error_report() & friends take care of that.
>> More of the same below.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 #endif
>>> =C2=A0 }
>>> =C2=A0 static void error_exit(int err, const char *msg)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err=
));
>>> +=C2=A0=C2=A0=C2=A0 error_report("qemu: %s: %s", msg, strerror(err));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> =C2=A0 }
>>> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
>>> index 56a83333da..9bed338d7e 100644
>>> --- a/util/qemu-thread-win32.c
>>> +++ b/util/qemu-thread-win32.c
>>> @@ -15,6 +15,7 @@
>>> =C2=A0 #include "qemu-common.h"
>>> =C2=A0 #include "qemu/thread.h"
>>> =C2=A0 #include "qemu/notify.h"
>>> +#include "qemu/error-report.h"
>>> =C2=A0 #include "qemu-thread-common.h"
>>> =C2=A0 #include <process.h>
>>> @@ -25,7 +26,7 @@ void qemu_thread_naming(bool enable)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* But note we don't actually name them =
on Windows yet */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name_threads =3D enable;
>>> -=C2=A0=C2=A0=C2=A0 fprintf(stderr, "qemu: thread naming not supported =
on this=20
>>> host\n");
>>> +=C2=A0=C2=A0=C2=A0 error_report("qemu: thread naming not supported on =
this host");
>>
>> Likewise.
>=20
> Thanks for your review. I'll drop the changes in util/oslib-win32.c for=
=20
> for now, and add a note in my TODO for after the 5.0 release.

Well if I follow this line, I'v to drop the changes in util/osdep.c too.
Maybe we can keep fprintf() for now and improve the error message, and=20
do the fprintf -> error_report cleanup later?

>=20
>>
>>> =C2=A0 }
>>> =C2=A0 static void error_exit(int err, const char *msg)
>>> @@ -34,7 +35,7 @@ static void error_exit(int err, const char *msg)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM=
 |=20
>>> FORMAT_MESSAGE_ALLOCATE_BUFFER,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, err, 0, (LPTSTR)&pstr, =
2, NULL);
>>> -=C2=A0=C2=A0=C2=A0 fprintf(stderr, "qemu: %s: %s\n", msg, pstr);
>>> +=C2=A0=C2=A0=C2=A0 error_report("qemu: %s: %s", msg, pstr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LocalFree(pstr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> =C2=A0 }
>>> diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
>>> index baf3317f74..527944da1c 100644
>>> --- a/util/qemu-timer-common.c
>>> +++ b/util/qemu-timer-common.c
>>> @@ -23,6 +23,7 @@
>>> =C2=A0=C2=A0 */
>>> =C2=A0 #include "qemu/osdep.h"
>>> =C2=A0 #include "qemu/timer.h"
>>> +#include "qemu/error-report.h"
>>> =C2=A0 /***********************************************************/
>>> =C2=A0 /* real time host monotonic timer */
>>> @@ -37,7 +38,7 @@ static void __attribute__((constructor))=20
>>> init_get_clock(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D QueryPerformanceFrequency(&freq)=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "Could not =
calibrate ticks\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Could not cal=
ibrate ticks");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock_freq =3D freq.QuadPart;
>>


