Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51070C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1424F21823
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZpVO4lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1424F21823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id5rP-0002Ei-A1
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 00:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1id5qa-0001oq-OC
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1id5qY-0001j1-Od
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:08:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1id5qY-0001h1-Iv
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575608886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ajQDgr4ZByU+ySvgdIBQS2jxTeEVEqmQNKb74Aj9OU=;
 b=TZpVO4lDTrcTro7RaYHv54H1TRbLBC1VsbqRLnPAgK6t4LYsby/itox+Rr09nYRgH6og4E
 99TT2JR4uNyDDGJuR0DrTCDExQacb+L2kkLt8k+BrUyvOykv+F0RZv/eU9Xm8rgbEDOmil
 1Cgw4ZlAxKxWFd+ap9o0G4SRAfeNsz0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-sOsi7VJ1NIqJvG10pGxC-g-1; Fri, 06 Dec 2019 00:08:02 -0500
Received: by mail-wr1-f70.google.com with SMTP id l20so2618192wrc.13
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 21:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qs0kVleGwcZ66sDVoc8XZ1sgectptySpRl0KBanmGos=;
 b=sPHl86buXVGur2dY1/0dugD+oclYMNDqeDTqS/XaQb94aUXX82eJ812PaaH1dJOF3F
 ngJAqzgkYV50xYkDoWXc9GkEePi97CG0E92zkHE7Dcw+nRGa14ETJ44cnINRBcpKLwmZ
 uZOfKEirN6ZabbGYgBDg4ZTN+2X3Zp5Z6dG0/NELeDguiX74oJJ2FarZXjWA3dyzIIfC
 0mv/a/pRrF8ifkBcUC72eanavUP+1lrnMqz0fMmCtnvtFVLfIEkDWJITOpoRvkfuulLq
 iso5rVkG3dvvO2CoVgdA89XfiQwYeVQlQ4KteJIQTNfAp5e/NEgCqMWUVBXEqxrBxqDY
 +wFw==
X-Gm-Message-State: APjAAAWISWfYqLdnx871wyZsS5K0svHHOyaqJ10NycgWPu/xXGUfp63S
 nJ1vIQ3bkRQoFIVBnnniZXYSNaC53evqxRVy7vJLVWMl7S8DYiPxGHUUUDQdoNjorXk3I9i8dXq
 ydMXnEr+pHbmpMjs=
X-Received: by 2002:a1c:6755:: with SMTP id b82mr7197467wmc.126.1575608881346; 
 Thu, 05 Dec 2019 21:08:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoRcxxyjT7CqFvTt23E3khxbCY+zsn/4zo7ePZw3anHOjZJg1avp2zgg/XEC68ReAqhS0rHA==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr7197444wmc.126.1575608880986; 
 Thu, 05 Dec 2019 21:08:00 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id h17sm15416762wrs.18.2019.12.05.21.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 21:08:00 -0800 (PST)
Subject: Re: [PATCH-for-5.0] roms/edk2-funcs.sh: Use available GCC for
 ARM/Aarch64 targets
To: Laszlo Ersek <lersek@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20191204221229.30612-1-philmd@redhat.com>
 <ecbb6c69-1fc1-a730-db9f-656b0a82c3fd@redhat.com>
 <90b6b303-2cb7-aeea-8f10-8520de2511c6@redhat.com>
 <CAKv+Gu8jiAqWWZkUegC40X=967sCpqiKooyaWFGnX5=saf+Duw@mail.gmail.com>
 <83c551c4-bec0-1a42-4605-d32f6430697e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <92dfa7c7-1001-09bf-18fc-f449136be248@redhat.com>
Date: Fri, 6 Dec 2019 06:07:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <83c551c4-bec0-1a42-4605-d32f6430697e@redhat.com>
Content-Language: en-US
X-MC-Unique: sOsi7VJ1NIqJvG10pGxC-g-1
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
Cc: Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 Serge Hallyn <serge.hallyn@ubuntu.com>, dann frazier <dannf@debian.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Steve Langasek <vorlon@debian.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 8:35 PM, Laszlo Ersek wrote:
> On 12/05/19 17:50, Ard Biesheuvel wrote:
>> On Thu, 5 Dec 2019 at 16:27, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>>
>>> On 12/5/19 5:13 PM, Laszlo Ersek wrote:
>>>> Hi Phil,
>>>>
>>>> (+Ard)
>>>>
>>>> On 12/04/19 23:12, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> Centos 7.7 only provides cross GCC 4.8.5, but the script forces
>>>>> us to use GCC5. Since the same machinery is valid to check the
>>>>> GCC version, remove the $emulation_target check.
>>>>>
>>>>>     $ cat /etc/redhat-release
>>>>>     CentOS Linux release 7.7.1908 (Core)
>>>>>
>>>>>     $ aarch64-linux-gnu-gcc -v 2>&1 | tail -1
>>>>>     gcc version 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC)
>>>>
>>>> this patch is not correct, in my opinion. ARM / AARCH64 support in edk=
2
>>>> requires GCC5 as a minimum. It was never tested with an earlier
>>>> toolchain, to my understanding. Not on my part, anyway.
>>>>
>>>> To be more precise: when I tested cross-gcc toolchains earlier than
>>>> that, the ArmVirtQemu builds always failed. Minimally, those toolchain=
s
>>>> didn't recognize some of the AARCH64 system registers.
>>>>
>>>> If CentOS 7.7 does not provide a suitable (>=3DGCC5) toolchain, then w=
e
>>>> can't build ArmVirtQemu binaries on CentOS 7.7, in my opinion.
>>>>
>>>> Personally, on my RHEL7 laptop, over time I've used the following
>>>> toolchains, to satisfy the GCC5 requirement of ArmVirtQemu (which
>>>> requirement I took as experimental evidence):
>>>>
>>>> - Initially (last quarter of 2014), I used binary distributions --
>>>>     tarballs -- of cross-binutils and cross-gcc, from Linaro.
>>>>
>>>> - Later (last quarter of 2016), I rebuilt some SRPMs that were at the
>>>>     time Fedora-only for RHEL7. Namely:
>>>>
>>>>     - cross-binutils-2.27-3.fc24
>>>>       https://koji.fedoraproject.org/koji/buildinfo?buildID=3D801348
>>>>
>>>>     - gcc-6.1.1-2.fc24
>>>>       https://koji.fedoraproject.org/koji/buildinfo?buildID=3D761767
>>>>
>>>> - Most recently, I've been using cross-binutils updated from EPEL7:
>>>>
>>>>     - cross-binutils-2.27-9.el7.1
>>>>       https://koji.fedoraproject.org/koji/buildinfo?buildID=3D918474
>>>>
>>>> To my knowledge, there is still no suitable cross-compiler available o=
n
>>>> RHEL7, from any trustworthy RPM repository. So, to this day, I use
>>>> gcc-6.1.1-2 for cross-building ArmVirtQemu, on my RHEL7 laptop.
>>>>
>>>> Again: I believe it does not matter if the gcc-4.8.5-based
>>>> cross-compiler in CentOS 7 "happens" to work. That's a compiler that I
>>>> have never tested with, or vetted for, upstream ArmVirtQemu.
>>>>
>>>> Now, I realize that in edk2, we have stuff like
>>>>
>>>>     GCC48_AARCH64_CC_FLAGS
>>>>
>>>> in "BaseTools/Conf/tools_def.template" -- coming from commit
>>>> 7a9dbf2c94d1 ("BaseTools/Conf/tools_def.template: drop ARM/AARCH suppo=
rt
>>>> from GCC46/GCC47", 2019-01-08). That doesn't change the fact that I've
>>>> never built or tested ArmVirtQemu with such a compiler. And so this
>>>> patch makes me quite uncomfortable.
>>>>
>>>> If that rules out CentOS 7 as a QEMU project build / CI platform for t=
he
>>>> bundled ArmVirtQemu binaries, then we need a more recent platform
>>>> (perhaps CentOS 8, not sure).
>>>
>>> Unfortunately CentOS 8 is not available as a Docker image, which is a
>>> convenient way to build EDK2 in a CI.
>>>
>>>> I think it's also educational to check the origin of the code that you=
r
>>>> patch proposes to remove. Most recently it was moved around from a
>>>> different place, in QEMU commit 65a109ab4b1a ('roms: lift
>>>> "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"', 2019-04-17).
>>>>
>>>> In that commit, for some reason I didn't keep the original code commen=
ts
>>>> (perhaps it would have been too difficult or messy to preserve the
>>>> comments sanely with the restructured / factored-out code). But, they
>>>> went like this (originally from commit 77db55fc8155,
>>>> "tests/uefi-test-tools: add build scripts", 2019-02-21):
>>>>
>>>> # Expose cross_prefix (which is possibly empty) to the edk2 tools. Whi=
le at it,
>>>> # determine the suitable edk2 toolchain as well.
>>>> # - For ARM and AARCH64, edk2 only offers the GCC5 toolchain tag, whic=
h covers
>>>> #   the gcc-5+ releases.
>>>> # - For IA32 and X64, edk2 offers the GCC44 through GCC49 toolchain ta=
gs, in
>>>> #   addition to GCC5. Unfortunately, the mapping between the toolchain=
 tags and
>>>> #   the actual gcc releases isn't entirely trivial. Run "git-blame" on
>>>> #   "OvmfPkg/build.sh" in edk2 for more information.
>>>> # And, because the above is too simple, we have to assign cross_prefix=
 to an
>>>> # edk2 build variable that is specific to both the toolchain tag and t=
he target
>>>> # architecture.
>>>>
>>>> So... unless Ard feels it is really totally safe to retro-actively rel=
y
>>>> on the gcc-4.8.5-based compiler in CentOS 7, I'd rather we picked a mo=
re
>>>> recent build platform (OS) instead. For example, we build ArmVirtQemu =
on
>>>> RHEL8 regularly, so that's a reality-based "plus" for CentOS 8.
>>>>
>>>>
>>>> Independently of all of the above, the OVMF toolchain selection logic
>>>> that this patch proposes to reuse with ArmVirtQemu, is *really*
>>>> x86-specific. Please run "git blame" on "OvmfPkg/build.sh" in upstream
>>>> edk2, to see where the various branches come from (as the comments in
>>>> this shell script suggest as well). There had been mess like commit
>>>> 656ac0c7d8ea ('Revert "OvmfPkg/build.sh: select the GCC49 toolchain
>>>> settings for gcc-7.*"', 2017-08-25).
>>>
>>> Thanks for all the pointers, very educative indeed :)
>>>
>>> I'll see other setups I can use with GCC5+ available.
>>>
>>> I still have to figure if there are free tier CI with less limitations
>>> than Travis/Shippable/GitLab, so we can keep the full EDK2 build output=
 log.
>>>
>>
>> My CI job for ArmVirtQemu/EDK2 build tested GCC48 and GCC49 until very
>> recently, and I never experienced any issues when running those
>> images, although it's been much longer that I actually tried that. So
>> I wouldn't recommend against it, and if we do identify any issues, we
>> should either deprecate GCC48 (for ArmVirtQemu or for AArch64
>> altogether) or fix them.

FYI Debian/Ubuntu apparently force to GCC49:
https://salsa.debian.org/qemu-team/edk2/blob/debian/debian/rules#L9

>=20
> OK, thank you, I'm fully satisfied with this addition. :)
>=20
> Phil, in this case I think we can indeed replace the hard-coded "GCC5"
> with a bit of dynamic detection. Two remarks:
>=20
> - Please CC Ard on v2, so he can ACK. I'd like that. :)
>=20
> - Again, we shouldn't blindly reapply the x86 (OVMF) quirk(s). I mean
> mainly the special casing of "6.[0-2].*" to GCC49, which comes from
> upstream edk2 commit 432f1d83f77a ("OvmfPkg/build.sh: Use GCC49
> toolchains with GCC 6.[0-2]", 2016-12-06).
>=20
> ... or is that GCC bug target-independent in fact? I can't really tell;
> the upstream GCC bug
> <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D70955> is ISA-specific
> (x86-64), and so are function calling conventions.
>=20
> I'd suggest *not* applying the quirk for ArmVirtQemu, initially.
>=20
> Thanks
> Laszlo
>=20


