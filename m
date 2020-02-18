Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF30C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083E62176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083E62176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42Wk-0004vw-6x
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j42G1-0001IT-9Q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j42Fz-0002ix-CX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:45:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:54754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j42Fy-0002iW-R9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:45:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j42Fx-00074F-CJ
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 12:45:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5A43B2E804C
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 12:45:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Feb 2020 12:38:16 -0000
From: Stevie Lavern <1861404@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: tcg testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: amarkovic rth stvlvrn
X-Launchpad-Bug-Reporter: Stevie Lavern (stvlvrn)
X-Launchpad-Bug-Modifier: Stevie Lavern (stvlvrn)
References: <158038956597.5319.13308249814127344774.malonedeb@chaenomeles.canonical.com>
Message-Id: <158202949607.25031.15207030640150982831.malone@gac.canonical.com>
Subject: [Bug 1861404] Re: AVX instruction VMOVDQU implementation error for
 YMM registers
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 719a485083d82b2951d59512f9244344286f372d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1861404 <1861404@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I also noticed that the 4.2.0 release changelog mentions support for
some AVX512 instructions.

https://wiki.qemu.org/ChangeLog/4.2#x86
```
Support for AVX512 BFloat16 extensions.
```

Is this support in TCG or in another component?
If so, it would mean that TCG support some AVX512 instructions but not AVX. =


Also, allow me to ask again, where can I find the work of last year's
GSoC on AVX support for TCG?

> AVX support was coded for GSoC last year,
> https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg05369.html

Thanks.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861404

Title:
  AVX instruction VMOVDQU implementation error for YMM registers

Status in QEMU:
  New

Bug description:
  Hi,

  Tested with Qemu 4.2.0, and with git version
  bddff6f6787c916b0e9d63ef9e4d442114257739.

  The x86 AVX instruction VMOVDQU doesn't work properly with YMM registers =
(32 bytes).
  It works with XMM registers (16 bytes) though.

  See the attached test case `ymm.c`: when copying from memory-to-ymm0
  and then back from ymm0-to-memory using VMOVDQU, Qemu only copies the
  first 16 of the total 32 bytes.

  ```
  user@ubuntu ~/Qemu % gcc -o ymm ymm.c -Wall -Wextra -Werror

  user@ubuntu ~/Qemu % ./ymm
  00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17 1=
8 19 1A 1B 1C 1D 1E 1F

  user@ubuntu ~/Qemu % ./x86_64-linux-user/qemu-x86_64 -cpu max ymm
  00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00
  ```

  This seems to be because in `translate.c > gen_sse()`, the case
  handling the VMOVDQU instruction calls `gen_ldo_env_A0` which always
  performs a 16 bytes copy using two 8 bytes load and store operations
  (with `tcg_gen_qemu_ld_i64` and `tcg_gen_st_i64`).

  Instead, the `gen_ldo_env_A0` function should generate a copy with a
  size corresponding to the used register.

  =

  ```
  static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                      target_ulong pc_start, int rex_r)
  {
          [...]
          case 0x26f: /* movdqu xmm, ea */
              if (mod !=3D 3) {
                  gen_lea_modrm(env, s, modrm);
                  gen_ldo_env_A0(s, offsetof(CPUX86State, xmm_regs[reg]));
              } else { =

          [...]
  ```

  ```
  static inline void gen_ldo_env_A0(DisasContext *s, int offset)
  {
      int mem_index =3D s->mem_index;
      tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, mem_index, MO_LEQ);
      tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(=
0)));
      tcg_gen_addi_tl(s->tmp0, s->A0, 8);
      tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEQ);
      tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(=
1)));
  }
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861404/+subscriptions

