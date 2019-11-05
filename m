Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC921C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CD3206BA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8GAx7Ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CD3206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS7ls-0006Zq-Ud
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 17:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iS7l2-0005yw-FY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iS7l0-0007tz-3W
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:57:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iS7kz-0007sd-T6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 17:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572994621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCpsKXpdlbusGip1jtPLh2GvCAr16ELyEirozl0FGcQ=;
 b=d8GAx7AisxUvBwozHLo9AD74hB3e5wfTQE6HZ/amHmvtFqudNw9lumrLq0uaGWBAgIoKl6
 0+oKD3Bc4ZHKtC+g2hPZE9a3mKLFmCUn8kvN73vBb71gx3OHFZ7Fkit5c63m7PyeSeA0gi
 9i+VjVZK2GWKAcvIG+Dtq7+Cnii/YNo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-JzOYas72NSSHwieMEpYopA-1; Tue, 05 Nov 2019 17:56:59 -0500
Received: by mail-wr1-f70.google.com with SMTP id e25so13115459wra.9
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 14:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0hoFqT+Kcma0kbVoVEafMYug+CytlOPJhdHCBXMeitM=;
 b=t9/Qqu8z0clmofRJuwZy7dNnmsmd/j1MBGuwgj4ebB09++P/jpit8TCWhWFrby4WsN
 gZXoDkSyQS3od7Sjy2TIxCiyyEl/3TFn2mfXJ1YBTk7eeMqNbDyV0xKnvsu87Mez3uL3
 kN6Kqa9xXJVQ4D5Qg/ev9W8QO7q696KB1UpRhNW6cZ5aJto7uEriTfHxxXKUCTFu3K0x
 zbXTpoj5TOItO5YF6f088WEus8ANxrhDo8FlsQxDasQiLePuJd+bNTGbr4fNL+8aei3j
 2ET0eb3qRw6ASA1CQUWRhVJq0qxV/4SUehKYKCyhQjNbcbDYVagOCGC+3/38Rkl2a8K4
 z0LQ==
X-Gm-Message-State: APjAAAXi4xzJeRro4bpEkxKh/2yMnd8wr2OxSkIvy4nNWAq2FM/hoR4A
 MVK0q5ihdgmI3XnYdpDbY4W10eekkUazqHvMbkS6qOJkvAVuNZUG0Q09SWVOF94IFVXew6dhuB1
 l5oveBnD4BGh6dOo=
X-Received: by 2002:a1c:994f:: with SMTP id b76mr1150294wme.84.1572994617796; 
 Tue, 05 Nov 2019 14:56:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwC15r7a6yIX72mNOtAXcRaz1Xs8TcVqzLDTGjY8pLd720t/WTC9Gn4y7I3CZEcxPkk/nejFg==
X-Received: by 2002:a1c:994f:: with SMTP id b76mr1150279wme.84.1572994617497; 
 Tue, 05 Nov 2019 14:56:57 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id w12sm749569wmi.17.2019.11.05.14.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2019 14:56:56 -0800 (PST)
Subject: Re: [PULL 00/13] Linux user for 4.2 patches
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <157299160056.27285.4050632174467978305@37313f22b938>
 <bb76453c-684f-eb7f-f774-f8a8029a58a1@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad9ff245-2c5a-43c8-83d8-d39f4991d210@redhat.com>
Date: Tue, 5 Nov 2019 23:56:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bb76453c-684f-eb7f-f774-f8a8029a58a1@vivier.eu>
Content-Language: en-US
X-MC-Unique: JzOYas72NSSHwieMEpYopA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: alex.bennee@linaro.org, riku.voipio@iki.fi, mark.cave-ayland@ilande.co.uk,
 atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/19 11:14 PM, Laurent Vivier wrote:
> Richard,
>=20
> could you update your series?
>=20
> If you prefer to wait next release I can drop your series from the pull
> request.
>=20
> Thanks,
> Laurent
>=20
> Le 05/11/2019 =C3=A0 23:06, no-reply@patchew.org a =C3=A9crit=C2=A0:
>> Patchew URL: https://patchew.org/QEMU/20191105181119.26779-1-laurent@viv=
ier.eu/
>>
>>
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below f=
or
>> more information:
>>
>> Subject: [PULL 00/13] Linux user for 4.2 patches
>> Type: series
>> Message-id: 20191105181119.26779-1-laurent@vivier.eu
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> git rev-parse base > /dev/null || exit 0
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>> git config --local diff.algorithm histogram
>> ./scripts/checkpatch.pl --mailback base..
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>>  From https://github.com/patchew-project/qemu
>>     36609b4..412fbef  master     -> master
>> Switched to a new branch 'test'
>> 965f842 linux-user/alpha: Set r20 secondary return value
>> a59ca3b linux-user/sparc: Fix cpu_clone_regs_*
>> 046ba0d linux-user: Introduce cpu_clone_regs_parent
>> 1afe1bc linux-user: Rename cpu_clone_regs to cpu_clone_regs_child
>> 748db1e linux-user/sparc64: Fix target_signal_frame
>> 2e90cc8 linux-user/sparc: Fix WREG usage in setup_frame
>> 608f997 linux-user/sparc: Use WREG_SP constant in sparc/signal.c
>> 279530b linux-user/sparc: Begin using WREG constants in sparc/signal.c
>> 3d27837 linux-user/sparc: Use WREG constants in sparc/target_cpu.h
>> b30437c target/sparc: Define an enumeration for accessing env->regwptr
>> 128b52d tests/tcg/multiarch/linux-test: Fix error check for shmat
>> e78b5ec scripts/qemu-binfmt-conf: Update for sparc64
>> 5a6b0f4 linux-user: Support for NETLINK socket options
>>
>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>> 1/13 Checking commit 5a6b0f46c670 (linux-user: Support for NETLINK socke=
t options)
>> 2/13 Checking commit e78b5ec2867e (scripts/qemu-binfmt-conf: Update for =
sparc64)
>> WARNING: line over 80 characters
>> #36: FILE: scripts/qemu-binfmt-conf.sh:41:
>> +sparc64_magic=3D'\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00\x02\x00\x2b'

False positive. Shouldn't we take this file out of checkpatch default list?

>>
>> ERROR: line over 90 characters
>> #37: FILE: scripts/qemu-binfmt-conf.sh:42:
>> +sparc64_mask=3D'\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xf=
f\xff\xff\xff\xfe\xff\xff'

Ditto.

>>
>> total: 1 errors, 1 warnings, 20 lines checked
>>
>> Patch 2/13 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> 3/13 Checking commit 128b52d81645 (tests/tcg/multiarch/linux-test: Fix e=
rror check for shmat)
>> 4/13 Checking commit b30437c1b51f (target/sparc: Define an enumeration f=
or accessing env->regwptr)
>> 5/13 Checking commit 3d27837139f0 (linux-user/sparc: Use WREG constants =
in sparc/target_cpu.h)
>> 6/13 Checking commit 279530b9caeb (linux-user/sparc: Begin using WREG co=
nstants in sparc/signal.c)
>> ERROR: spaces required around that '+' (ctx:VxV)
>> #52: FILE: linux-user/sparc/signal.c:151:
>> +        __put_user(env->regwptr[WREG_O0 + i], &si->si_regs.u_regs[i+8])=
;
>>                                                                      ^

True positive :/

>>
>> ERROR: spaces required around that '+' (ctx:VxV)
>> #124: FILE: linux-user/sparc/signal.c:290:
>> +        __get_user(env->regwptr[i + WREG_O0], &sf->info.si_regs.u_regs[=
i+8]);
>>                                                                         =
  ^

Again.

>>
>> ERROR: spaces required around that '+' (ctx:VxV)
>> #171: FILE: linux-user/sparc/signal.c:460:
>> +    w_addr =3D TARGET_STACK_BIAS+env->regwptr[WREG_O6];
>>                                 ^

Again.

>>
>> ERROR: spaces required around that '+' (ctx:VxV)
>> #206: FILE: linux-user/sparc/signal.c:563:
>> +    w_addr =3D TARGET_STACK_BIAS+env->regwptr[WREG_O6];
>>                                 ^

Again.

>>
>> total: 4 errors, 0 warnings, 175 lines checked
>>
>> Patch 6/13 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> 7/13 Checking commit 608f99725ea6 (linux-user/sparc: Use WREG_SP constan=
t in sparc/signal.c)
>> 8/13 Checking commit 2e90cc889f5a (linux-user/sparc: Fix WREG usage in s=
etup_frame)
>> 9/13 Checking commit 748db1e8856b (linux-user/sparc64: Fix target_signal=
_frame)
>> ERROR: space prohibited between function name and open parenthesis '('
>> #24: FILE: linux-user/sparc/signal.c:90:
>> +    uint32_t            insns[2] __attribute__ ((aligned (8)));

False positive likely?

>>
>> total: 1 errors, 0 warnings, 16 lines checked
>>
>> Patch 9/13 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> 10/13 Checking commit 1afe1bce0919 (linux-user: Rename cpu_clone_regs to=
 cpu_clone_regs_child)
>> 11/13 Checking commit 046ba0d62866 (linux-user: Introduce cpu_clone_regs=
_parent)
>> 12/13 Checking commit a59ca3b85381 (linux-user/sparc: Fix cpu_clone_regs=
_*)
>> 13/13 Checking commit 965f842f57f6 (linux-user/alpha: Set r20 secondary =
return value)
>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>
>> Test command exited with code: 1
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20191105181119.26779-1-laurent@vivier.eu/testing=
.checkpatch/?type=3Dmessage.
>> ---
>> Email generated automatically by Patchew [https://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com
>>


