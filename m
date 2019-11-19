Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8494DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6DB21D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6DB21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWz47-000238-Hx
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 03:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iWz3F-0001Pc-Rq
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iWz3C-0003ve-9Q
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:39:57 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:51203)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iWz3B-0003u1-WD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:39:54 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MUGNZ-1iNOP7075H-00RFsZ; Tue, 19 Nov 2019 09:39:26 +0100
To: Taylor Simpson <tsimpson@quicinc.com>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
Message-ID: <20ff3dba-2ee8-8ef2-aa50-ecbd52092c4d@vivier.eu>
Date: Tue, 19 Nov 2019 09:39:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pVI2HmNwtic/IjbB/hTj/6gBHYiXxqeUvDs+n128W2mz+sPNz6R
 2H9Au+j9pzbmFEbIvKCc8qjrKF12v63w/f29mGLjoa5ArUva7BsGDj2mJkd947E98y8tSXo
 0laZT8O7EDIy9/osFtyD8g5H6Z08T952aRqKc0zpMWIGK1XD2bIZnSSSsyybn6/bhuiiWdf
 knqaj8eYhnjlJhkvoO3kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rkzhds3DqIc=:XzRCBcotaUpOPWWhwCO5Uy
 Uyj6/oezwitr2Sltmz9T7F1vfgHELVrkcri6JSS7qoLthpILhM/UGt6pLq/2qu6mPxuMwqF1W
 4w25zX20w8Ev1OVP8YkzS7Ckz1IytSzWFw8ycC5zgM/ZTljJCJypS1i4pnT6hihZp2P82Bv46
 25J5LtHUlKe8LXft6TzBFfr6KIFohkAkXfiZUqIGh9zD+GVwuYyv9X0ItXBV6uq4hWKM1nk/d
 CScyBHodh7jKh0ako77IqtTKZepkqwT99leDVXRNDvVpdTrEJI883rI2DH2kuqMvwo0Fhw4sg
 yYQJsU8NPBn3ei1mJY/7kzgHQzc7dIAlTyLT0oUx3m+EF2rooXIHW9eM3/uJUOzykL7737/j/
 6oacaW2yEkZzfEaG8DIygp88Sl53WecX6DUSHzyUK7MLKVHmmvDmkVJ4ew2z/hQB5z7O64yTH
 NWDTVOuSaihNaadv/UZbHx2W4K43rnYg13eybsO3bM2xC6SiTe6uYCk5IfS0+BWZ7PqalNTyD
 /HXK0x3JnizcqT76Gtpgf2Bsl7fSw09RraLDwTIrM7MXtxVCUbRFB7zH2jdLRRlGQidO0mYQw
 RIv3B12lSxDDiT7n55NS/NyPp6zYFT7lHrYJ3Xll57rbdnI5ZIxyqxaBB8O9S2fbyuhD7ZBvM
 EOIM5MW/SjHbkTNDQNXnolKS+d2XRyjiCmzfV0KAPCI1UVWuZPTimkFndTNqpg6HddLg5oAis
 iOr5H9OEZZCZFwwxkWYPOzPPttXT38O3cWU/KUXGxe7taw07gykTcydZ/NzvB4lT6ZiS9m1OM
 EJjUHqz4QAlEBt6bni2aIf5wnKSX4z+FI6sg3gbCgRJ+PNbvvt2jCYUekg4Qv/52mbIM2VWrn
 JfsbSfyt1mtwkeeXpfET4qd7k55++q7pMs0FeQWTo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

thank you for your contribution.

I think we need some little changes:

- fix the errors reported by patchew (you can check your patch with
scripts/checkpatch.pl)

- split the patch in two parts: one to add the target, one to add the
linux-user part,

- add the license header in files where it is missing.
  (you can use the SPDX tag)

- I think you can remove the "DEBUG_HEX" in cpu_loop() as most of the
information can be displayed by QEMU_STRACE env variable. The one in
hexagon_tr_translate_packet() can be done using QEMU_SINGLESTEP (if I
understand the purpose),

- The "[__SIGRTMAX - 1] = __SIGRTMIN + 1" part must be in a separate
patch. As I said at KVM Forum, I agree with this change if it doesn't
break anything else but it can be controversial.

Thanks,
Laurent

Le 19/11/2019 à 00:58, Taylor Simpson a écrit :
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  configure                                   |   9 +
>  default-configs/hexagon-linux-user.mak      |   1 +
>  include/elf.h                               |   2 +
>  linux-user/elfload.c                        |  16 ++
>  linux-user/hexagon/cpu_loop.c               | 103 +++++++++
>  linux-user/hexagon/signal.c                 | 276 +++++++++++++++++++++++
>  linux-user/hexagon/sockbits.h               |   3 +
>  linux-user/hexagon/syscall_nr.h             | 331 ++++++++++++++++++++++++++++
>  linux-user/hexagon/target_cpu.h             |  35 +++
>  linux-user/hexagon/target_elf.h             |  24 ++
>  linux-user/hexagon/target_fcntl.h           |   3 +
>  linux-user/hexagon/target_signal.h          |  19 ++
>  linux-user/hexagon/target_structs.h         |  31 +++
>  linux-user/hexagon/target_syscall.h         |  17 ++
>  linux-user/hexagon/termbits.h               | 231 +++++++++++++++++++
>  linux-user/signal.c                         |   8 +
>  linux-user/syscall.c                        |   2 +
>  linux-user/syscall_defs.h                   |  33 +++
>  target/hexagon/Makefile.objs                |   6 +
>  target/hexagon/cpu-param.h                  |  11 +
>  target/hexagon/cpu.c                        | 283 ++++++++++++++++++++++++
>  target/hexagon/cpu.h                        | 146 ++++++++++++
>  target/hexagon/cpu_bits.h                   |  15 ++
>  target/hexagon/helper.h                     |   3 +
>  target/hexagon/imported/global_types.h      |  25 +++
>  target/hexagon/imported/iss_ver_registers.h | 183 +++++++++++++++
>  target/hexagon/imported/max.h               |  78 +++++++
>  target/hexagon/imported/regs.h              |  19 ++
>  target/hexagon/op_helper.c                  |  29 +++
>  target/hexagon/translate.c                  | 220 ++++++++++++++++++
>  target/hexagon/translate.h                  |  22 ++
>  31 files changed, 2184 insertions(+)
>  create mode 100644 default-configs/hexagon-linux-user.mak
>  create mode 100644 linux-user/hexagon/cpu_loop.c
>  create mode 100644 linux-user/hexagon/signal.c
>  create mode 100644 linux-user/hexagon/sockbits.h
>  create mode 100644 linux-user/hexagon/syscall_nr.h
>  create mode 100644 linux-user/hexagon/target_cpu.h
>  create mode 100644 linux-user/hexagon/target_elf.h
>  create mode 100644 linux-user/hexagon/target_fcntl.h
>  create mode 100644 linux-user/hexagon/target_signal.h
>  create mode 100644 linux-user/hexagon/target_structs.h
>  create mode 100644 linux-user/hexagon/target_syscall.h
>  create mode 100644 linux-user/hexagon/termbits.h
>  create mode 100644 target/hexagon/Makefile.objs
>  create mode 100644 target/hexagon/cpu-param.h
>  create mode 100644 target/hexagon/cpu.c
>  create mode 100644 target/hexagon/cpu.h
>  create mode 100644 target/hexagon/cpu_bits.h
>  create mode 100644 target/hexagon/helper.h
>  create mode 100644 target/hexagon/imported/global_types.h
>  create mode 100644 target/hexagon/imported/iss_ver_registers.h
>  create mode 100644 target/hexagon/imported/max.h
>  create mode 100644 target/hexagon/imported/regs.h
>  create mode 100644 target/hexagon/op_helper.c
>  create mode 100644 target/hexagon/translate.c
>  create mode 100644 target/hexagon/translate.h
> 

