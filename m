Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402ECC04AAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 01:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF3B2083D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 01:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cam.ac.uk header.i=@cam.ac.uk header.b="NWta9zdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF3B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSAjS-0001AX-8i
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 21:35:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hmka2@hermes.cam.ac.uk>) id 1hS8ZO-00061U-R0
	for qemu-devel@nongnu.org; Sat, 18 May 2019 19:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hmka2@hermes.cam.ac.uk>) id 1hS8ZN-000869-Pi
	for qemu-devel@nongnu.org; Sat, 18 May 2019 19:16:50 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:47978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hmka2@hermes.cam.ac.uk>)
	id 1hS8ZK-00082v-OQ; Sat, 18 May 2019 19:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk; 
	s=20180806.ppsw;
	h=Sender:Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cWnrGv1m5ltotqo5oEmGpXMpkSUfMTTDx3NcTHm9HSA=;
	b=NWta9zdJ/ieKoZ5H+dwK8rf1Pf
	7XnTcHrOaJq4TouPP6dZs6LX/1ZON3gJh6RwLWRAxpSZqMFgMxvx9BlvOz1E4WAV3bb5klva7DGF2
	Ziwd/ugl0ku2XIh3Lzm97gQXk/iKTLtMdi4yMBEnUmXywb8Ik+FEMN9l3VALy9c8Jv74=; 
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45480)
	by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
	with esmtpsa (PLAIN:hmka2) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	id 1hS8ZF-0008UW-3A (Exim 4.91)
	(return-path <hmka2@hermes.cam.ac.uk>); Sun, 19 May 2019 00:16:42 +0100
Received: by mail-lf1-f53.google.com with SMTP id n22so7694387lfe.12;
	Sat, 18 May 2019 16:16:41 -0700 (PDT)
X-Gm-Message-State: APjAAAXaB5y6/HPvLQwHZJkMIdaTo5IB0SQ6fRPiDJ6+p3qeHfnoHmHN
	Xayp2yi0xvzA5u6fSwVXs82T6iZjomi2JnkvNmQ=
X-Google-Smtp-Source: APXvYqwewSN2gmPglt0g5UbMM11SDwxoxWppbEEUSpVa64ojNUOGEFl4RtZP59vJrtOB3m5/Y6067Ekt1tyBcY95fJc=
X-Received: by 2002:a19:cd82:: with SMTP id d124mr20141189lfg.8.1558221401358; 
	Sat, 18 May 2019 16:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190518191323.4907-1-Hesham.Almatary@cl.cam.ac.uk>
	<CANnJOVHoc3fAx=_iuOxaKjtWoUg2_npXu+CzQ+CcppevBmddtA@mail.gmail.com>
In-Reply-To: <CANnJOVHoc3fAx=_iuOxaKjtWoUg2_npXu+CzQ+CcppevBmddtA@mail.gmail.com>
From: Hesham Almatary <hesham.almatary@cl.cam.ac.uk>
Date: Sun, 19 May 2019 00:16:05 +0100
X-Gmail-Original-Message-ID: <CA+wsVCAhH+2gxQwcaJY5_w4FSPjO9Vv7nN2En9t_56p_UuHfmw@mail.gmail.com>
Message-ID: <CA+wsVCAhH+2gxQwcaJY5_w4FSPjO9Vv7nN2En9t_56p_UuHfmw@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.111.8.132
X-Mailman-Approved-At: Sat, 18 May 2019 21:33:43 -0400
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH 1/2] RISC-V: Raise access
 fault exceptions on PMP violations
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jonathan,

Thanks for your feedback.

On Sat, 18 May 2019 at 22:51, Jonathan Behrens <fintelia@gmail.com> wrote:
>
> This patch assumes that translation failure should always raise a paging =
fault, but it should be possible for it to raise an access fault as well (s=
ince according to the spec "PMP  checks  are  also  applied  to  page-table=
  accesses  for  virtual-address translation, for which the effective privi=
lege mode is S."). I think the code to actually do the PMP checking during =
page table walks is currently unimplemented though...
>

The patch actually fixes (rather than assumes) one issue of the
current implementation which always raises a paging fault "when
translation succeeds and PMP fails". The second issue that you report
here which happens "when the PTW fails the PMP check" could be another
future separate fix.

I am happy to submit another patch to fix the second issue.

> Jonathan
>
> On Sat, May 18, 2019 at 3:14 PM Hesham Almatary <Hesham.Almatary@cl.cam.a=
c.uk> wrote:
>>
>> Section 3.6 in RISC-V v1.10 privilege specification states that PMP viol=
ations
>> report "access exceptions." The current PMP implementation has
>> a bug which wrongly reports "page exceptions" on PMP violations.
>>
>> This patch fixes this bug by reporting the correct PMP access exceptions
>> trap values.
>>
>> Signed-off-by: Hesham Almatary <hesham.almatary@cl.cam.ac.uk>
>> ---
>>  target/riscv/cpu_helper.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 41d6db41c3..b48de36114 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -318,12 +318,13 @@ restart:
>>  }
>>
>>  static void raise_mmu_exception(CPURISCVState *env, target_ulong addres=
s,
>> -                                MMUAccessType access_type)
>> +                                MMUAccessType access_type, bool pmp_vio=
lation)
>>  {
>>      CPUState *cs =3D CPU(riscv_env_get_cpu(env));
>>      int page_fault_exceptions =3D
>>          (env->priv_ver >=3D PRIV_VERSION_1_10_0) &&
>> -        get_field(env->satp, SATP_MODE) !=3D VM_1_10_MBARE;
>> +        get_field(env->satp, SATP_MODE) !=3D VM_1_10_MBARE &&
>> +        !pmp_violation;
>>      switch (access_type) {
>>      case MMU_INST_FETCH:
>>          cs->exception_index =3D page_fault_exceptions ?
>> @@ -389,6 +390,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,=
 int size,
>>      CPURISCVState *env =3D &cpu->env;
>>      hwaddr pa =3D 0;
>>      int prot;
>> +    bool pmp_violation =3D false;
>>      int ret =3D TRANSLATE_FAIL;
>>
>>      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\=
n",
>> @@ -402,6 +404,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,=
 int size,
>>
>>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>>          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type=
)) {
>> +        pmp_violation =3D true;
>>          ret =3D TRANSLATE_FAIL;
>>      }
>>      if (ret =3D=3D TRANSLATE_SUCCESS) {
>> @@ -411,7 +414,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,=
 int size,
>>      } else if (probe) {
>>          return false;
>>      } else {
>> -        raise_mmu_exception(env, address, access_type);
>> +        raise_mmu_exception(env, address, access_type, pmp_violation);
>>          riscv_raise_exception(env, cs->exception_index, retaddr);
>>      }
>>  #else
>> --
>> 2.17.1
>>
>>

