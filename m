Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D661DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A8624648
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDbJe8l4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A8624648
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icu0T-0007gt-R9
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ictyO-0006x6-Pz
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ictyL-0000z7-2Y
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:27:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ictyI-0000xg-3g
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575563236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBxzefjKSU6Pgmwe1/LXoDQv2DaUpenBZ7RuVt7JbWs=;
 b=iDbJe8l4Gze/SCWXcb17cZ1C6vzHgBVXT7fFIwdu0Yzwk8JXjj8WwCF8tNsTAcwU5uOBWT
 7+CiUHypaPdWAFLKIc8eo+xlg+67oFbeOCP5Mz0Q7T3GlO66uR26KvFP5niM5nwWLkIwdx
 RmpKfL99V8iHQTW3VDKCZuTKtXMkJGU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-V0AJj0xfNq-msMyHhYAQ6w-1; Thu, 05 Dec 2019 11:27:15 -0500
Received: by mail-wm1-f72.google.com with SMTP id i17so1185431wmd.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 08:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5o4CXLgRlmHvCIHSYQprPzPMx7zHX0jnlPhuQPHpF0Q=;
 b=gZ70LTlQmn/HnO4fs57DqpUBcwCkLJj7rc4YCAGj9YUFB8OB8k+1SP/5V8vkkcHnI4
 IYPD+oDm0j7cMwm3aK+y+YNDn5uQ7uWXPFlaN5jDpbE68HpoTZcUEo2MFoWGuHF7mJzg
 wlali+x0Jymsj8K0foUj37NcmAk/c+CcYXxXw6Kav0lhu6Eellb4pIifcXvTvIztqL8D
 uGiYDRWoZEuShoBU7OaBEZDP4d27QEvwJ3rfF1JgVOVBKC74vE+OY5k1GzdFlT946zHm
 jMS26audclhCbot8h8zkSh0nJVvYrqWmKNjqSAGBWVhLSvjLmY+5aRQY0HNQ1Nsc1GuT
 KYSw==
X-Gm-Message-State: APjAAAUE7rBf0DPC0vp44XFxGi5Wfw8OoDEPvZsdZFIjtucIt/Z//5yZ
 eyHJInHGjBqG92f9nu4P9UW+rugmsQ+4w1HP44CQNx2Yp8KWmyr6sq0VB4x8zGno7rJreDPA0QF
 BSsHtaVDUvrQmFEs=
X-Received: by 2002:adf:a746:: with SMTP id e6mr11605247wrd.329.1575563233808; 
 Thu, 05 Dec 2019 08:27:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdkceRpNcAFmkTLKGzsR6H3sQdT91ADlVZCvo9e1O1x7Fz2TXWe0h1V3j+pKfJlR3EeHzTMQ==
X-Received: by 2002:adf:a746:: with SMTP id e6mr11605213wrd.329.1575563233455; 
 Thu, 05 Dec 2019 08:27:13 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id e18sm12546361wrr.95.2019.12.05.08.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 08:27:12 -0800 (PST)
Subject: Re: [PATCH-for-5.0] roms/edk2-funcs.sh: Use available GCC for
 ARM/Aarch64 targets
To: Laszlo Ersek <lersek@redhat.com>
References: <20191204221229.30612-1-philmd@redhat.com>
 <ecbb6c69-1fc1-a730-db9f-656b0a82c3fd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <90b6b303-2cb7-aeea-8f10-8520de2511c6@redhat.com>
Date: Thu, 5 Dec 2019 17:27:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ecbb6c69-1fc1-a730-db9f-656b0a82c3fd@redhat.com>
Content-Language: en-US
X-MC-Unique: V0AJj0xfNq-msMyHhYAQ6w-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 5:13 PM, Laszlo Ersek wrote:
> Hi Phil,
>=20
> (+Ard)
>=20
> On 12/04/19 23:12, Philippe Mathieu-Daud=C3=A9 wrote:
>> Centos 7.7 only provides cross GCC 4.8.5, but the script forces
>> us to use GCC5. Since the same machinery is valid to check the
>> GCC version, remove the $emulation_target check.
>>
>>    $ cat /etc/redhat-release
>>    CentOS Linux release 7.7.1908 (Core)
>>
>>    $ aarch64-linux-gnu-gcc -v 2>&1 | tail -1
>>    gcc version 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC)
>=20
> this patch is not correct, in my opinion. ARM / AARCH64 support in edk2
> requires GCC5 as a minimum. It was never tested with an earlier
> toolchain, to my understanding. Not on my part, anyway.
>=20
> To be more precise: when I tested cross-gcc toolchains earlier than
> that, the ArmVirtQemu builds always failed. Minimally, those toolchains
> didn't recognize some of the AARCH64 system registers.
>=20
> If CentOS 7.7 does not provide a suitable (>=3DGCC5) toolchain, then we
> can't build ArmVirtQemu binaries on CentOS 7.7, in my opinion.
>=20
> Personally, on my RHEL7 laptop, over time I've used the following
> toolchains, to satisfy the GCC5 requirement of ArmVirtQemu (which
> requirement I took as experimental evidence):
>=20
> - Initially (last quarter of 2014), I used binary distributions --
>    tarballs -- of cross-binutils and cross-gcc, from Linaro.
>=20
> - Later (last quarter of 2016), I rebuilt some SRPMs that were at the
>    time Fedora-only for RHEL7. Namely:
>=20
>    - cross-binutils-2.27-3.fc24
>      https://koji.fedoraproject.org/koji/buildinfo?buildID=3D801348
>=20
>    - gcc-6.1.1-2.fc24
>      https://koji.fedoraproject.org/koji/buildinfo?buildID=3D761767
>=20
> - Most recently, I've been using cross-binutils updated from EPEL7:
>=20
>    - cross-binutils-2.27-9.el7.1
>      https://koji.fedoraproject.org/koji/buildinfo?buildID=3D918474
>=20
> To my knowledge, there is still no suitable cross-compiler available on
> RHEL7, from any trustworthy RPM repository. So, to this day, I use
> gcc-6.1.1-2 for cross-building ArmVirtQemu, on my RHEL7 laptop.
>=20
> Again: I believe it does not matter if the gcc-4.8.5-based
> cross-compiler in CentOS 7 "happens" to work. That's a compiler that I
> have never tested with, or vetted for, upstream ArmVirtQemu.
>=20
> Now, I realize that in edk2, we have stuff like
>=20
>    GCC48_AARCH64_CC_FLAGS
>=20
> in "BaseTools/Conf/tools_def.template" -- coming from commit
> 7a9dbf2c94d1 ("BaseTools/Conf/tools_def.template: drop ARM/AARCH support
> from GCC46/GCC47", 2019-01-08). That doesn't change the fact that I've
> never built or tested ArmVirtQemu with such a compiler. And so this
> patch makes me quite uncomfortable.
>=20
> If that rules out CentOS 7 as a QEMU project build / CI platform for the
> bundled ArmVirtQemu binaries, then we need a more recent platform
> (perhaps CentOS 8, not sure).

Unfortunately CentOS 8 is not available as a Docker image, which is a=20
convenient way to build EDK2 in a CI.

> I think it's also educational to check the origin of the code that your
> patch proposes to remove. Most recently it was moved around from a
> different place, in QEMU commit 65a109ab4b1a ('roms: lift
> "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"', 2019-04-17).
>=20
> In that commit, for some reason I didn't keep the original code comments
> (perhaps it would have been too difficult or messy to preserve the
> comments sanely with the restructured / factored-out code). But, they
> went like this (originally from commit 77db55fc8155,
> "tests/uefi-test-tools: add build scripts", 2019-02-21):
>=20
> # Expose cross_prefix (which is possibly empty) to the edk2 tools. While =
at it,
> # determine the suitable edk2 toolchain as well.
> # - For ARM and AARCH64, edk2 only offers the GCC5 toolchain tag, which c=
overs
> #   the gcc-5+ releases.
> # - For IA32 and X64, edk2 offers the GCC44 through GCC49 toolchain tags,=
 in
> #   addition to GCC5. Unfortunately, the mapping between the toolchain ta=
gs and
> #   the actual gcc releases isn't entirely trivial. Run "git-blame" on
> #   "OvmfPkg/build.sh" in edk2 for more information.
> # And, because the above is too simple, we have to assign cross_prefix to=
 an
> # edk2 build variable that is specific to both the toolchain tag and the =
target
> # architecture.
>=20
> So... unless Ard feels it is really totally safe to retro-actively rely
> on the gcc-4.8.5-based compiler in CentOS 7, I'd rather we picked a more
> recent build platform (OS) instead. For example, we build ArmVirtQemu on
> RHEL8 regularly, so that's a reality-based "plus" for CentOS 8.
>=20
>=20
> Independently of all of the above, the OVMF toolchain selection logic
> that this patch proposes to reuse with ArmVirtQemu, is *really*
> x86-specific. Please run "git blame" on "OvmfPkg/build.sh" in upstream
> edk2, to see where the various branches come from (as the comments in
> this shell script suggest as well). There had been mess like commit
> 656ac0c7d8ea ('Revert "OvmfPkg/build.sh: select the GCC49 toolchain
> settings for gcc-7.*"', 2017-08-25).

Thanks for all the pointers, very educative indeed :)

I'll see other setups I can use with GCC5+ available.

I still have to figure if there are free tier CI with less limitations=20
than Travis/Shippable/GitLab, so we can keep the full EDK2 build output log=
.

> Thanks,
> Laszlo
>=20
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Patch to review with --ignore-all-space
>> ---
>>   roms/edk2-funcs.sh | 48 +++++++++++++++++++---------------------------
>>   1 file changed, 20 insertions(+), 28 deletions(-)
>>
>> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
>> index 3f4485b201..a455611c0d 100644
>> --- a/roms/edk2-funcs.sh
>> +++ b/roms/edk2-funcs.sh
>> @@ -135,35 +135,27 @@ qemu_edk2_get_toolchain()
>>       return 1
>>     fi
>>
>> -  case "$emulation_target" in
>> -    (arm|aarch64)
>> -      printf 'GCC5\n'
>> +  if ! cross_prefix=3D$(qemu_edk2_get_cross_prefix "$emulation_target")=
; then
>> +    return 1
>> +  fi
>> +
>> +  gcc_version=3D$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{print =
$3}')
>> +  # Run "git-blame" on "OvmfPkg/build.sh" in edk2 for more information =
on
>> +  # the mapping below.
>> +  case "$gcc_version" in
>> +    ([1-3].*|4.[0-7].*)
>> +      printf '%s: unsupported gcc version "%s"\n' \
>> +        "$program_name" "$gcc_version" >&2
>> +      return 1
>>         ;;
>> -
>> -    (i386|x86_64)
>> -      if ! cross_prefix=3D$(qemu_edk2_get_cross_prefix "$emulation_targ=
et"); then
>> -        return 1
>> -      fi
>> -
>> -      gcc_version=3D$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{pr=
int $3}')
>> -      # Run "git-blame" on "OvmfPkg/build.sh" in edk2 for more informat=
ion on
>> -      # the mapping below.
>> -      case "$gcc_version" in
>> -        ([1-3].*|4.[0-7].*)
>> -          printf '%s: unsupported gcc version "%s"\n' \
>> -            "$program_name" "$gcc_version" >&2
>> -          return 1
>> -          ;;
>> -        (4.8.*)
>> -          printf 'GCC48\n'
>> -          ;;
>> -        (4.9.*|6.[0-2].*)
>> -          printf 'GCC49\n'
>> -          ;;
>> -        (*)
>> -          printf 'GCC5\n'
>> -          ;;
>> -      esac
>> +    (4.8.*)
>> +      printf 'GCC48\n'
>> +      ;;
>> +    (4.9.*|6.[0-2].*)
>> +      printf 'GCC49\n'
>> +      ;;
>> +    (*)
>> +      printf 'GCC5\n'
>>         ;;
>>     esac
>>   }
>>
>=20
>=20


