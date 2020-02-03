Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F42C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C22F20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C22F20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybzi-0003x2-L8
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iyby3-0001eN-Kk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iyby2-0007kx-8W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:40:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:36568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iyby2-0007jV-2v
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:40:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iyby0-00005h-77
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 13:40:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 160632E80C7
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 13:40:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Feb 2020 13:32:06 -0000
From: Teodori Serge <teodori.serge@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: risc-v
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alistair2323 teodori-serge
X-Launchpad-Bug-Reporter: Teodori Serge (teodori-serge)
X-Launchpad-Bug-Modifier: Teodori Serge (teodori-serge)
References: <157875755996.2711.225801499083245592.malonedeb@soybean.canonical.com>
Message-Id: <158073672622.18906.14219281705734898954.malone@gac.canonical.com>
Subject: [Bug 1859291] Re: RISC-V incorrect exception generated
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 21ce795026fade3ebe1d153ff7bb53e62b409234
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
Reply-To: Bug 1859291 <1859291@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

code from machine mode:
<pre>
	/* TEST jump to supervisor mode */
	if(mhartid =3D=3D 3){
		asm volatile ("csrw sepc, %[reg]; sret" : : [reg] "r" (&main_supervisor));
		log("main: jump to supervisor mode failed!\r\n");
	}
</pre>

here is supervisor mode function:
<pre>
void main_supervisor(){
	log("main: we are in supervisor mode, now calling to machine mode\r\n");
	asm volatile ("ecall");
	log("main: we returned to supervisor mode\r\n");
	for(;;){} // TODO supervisor mode not implemented, spin forever
}
</pre>

here is the machine mode interrupt handler:
<pre>
void main_mtrap(){
	uint64_t mhartid, mcause, mip;

	asm volatile ("csrr %[reg], mhartid" : [reg] "=3Dr" (mhartid));
	asm volatile ("csrr %[reg], mcause" : [reg] "=3Dr" (mcause));

	/* if most significant bit is set, =

	 * then an interrupt is pending
	 * else an exception occurred */
	switch(mcause){
	case 0x0:
		log("main: exception (Instruction address misaligned) on hart %x\r\n", mh=
artid);
		break;
	case 0x1:
		log("main: exception (Instruction access fault) on hart %x\r\n", mhartid);
		break;
	case 0x2:
		log("main: exception (Illegal instruction) on hart %x\r\n", mhartid);
		break;
	case 0x3:
		log("main: exception (Breakpoint) on hart %x\r\n", mhartid);
		break;
	case 0x4:
		log("main: exception (Load address misaligned) on hart %x\r\n", mhartid);
		break;
	case 0x5:
		log("main: exception (Load access fault) on hart %x\r\n", mhartid);
		break;
	case 0x6:
		log("main: exception (Store/AMO address misaligned) on hart %x\r\n", mhar=
tid);
		break;
	case 0x7:
		log("main: exception (Store/AMO access fault) on hart %x\r\n", mhartid);
		break;
	case 0x8:
		log("main: exception (Environment call from U-mode) on hart %x\r\n", mhar=
tid);
		break;
	case 0x9:
		log("main: exception (Environment call from S-mode) on hart %x\r\n", mhar=
tid);
		break;
	case 0xa:
		log("main: exception (Reserved) on hart %x\r\n", mhartid);
		break;
	case 0xb:
		log("main: exception (Environment call from M-mode) on hart %x\r\n", mhar=
tid);
		break;
	case 0xc:
		log("main: exception (Instruction page fault) on hart %x\r\n", mhartid);
		break;
	case 0xd:
		log("main: exception (Load page fault) on hart %x\r\n", mhartid);
		break;
	case 0xe:
		log("main: exception (Reserved) on hart %x\r\n", mhartid);
		break;
	case 0xf:
		log("main: exception (Store/AMO page fault) on hart %x\r\n", mhartid);
		break;
	case 0x8000000000000000:
		log("main: interrupt (User software interrupt) on hart %x\r\n", mhartid);
		break;
	case 0x8000000000000001:
		log("main: interrupt (Supervisor software interrupt) on hart %x\r\n", mha=
rtid);
		break;
	case 0x8000000000000002:
		log("main: interrupt (Reserved) on hart %x\r\n", mhartid);
		break;
	case 0x8000000000000003:
		log("main: interrupt (Machine software interrupt) on hart %x\r\n", mharti=
d);
		clint_lower(&clint, mhartid);
		break;
	case 0x8000000000000004:
		log("main: interrupt (User timer interrupt) on hart %x\r\n", mhartid);
		break;
	case 0x8000000000000005:
		log("main: interrupt (Supervisor timer interrupt) on hart %x\r\n", mharti=
d);
		break;
	case 0x8000000000000006:
		log("main: interrupt (Reserved) on hart %x\r\n", mhartid);
		break;
	case 0x8000000000000007:
		log("main: interrupt (Machine timer interrupt) on hart %x\r\n", mhartid);
		clint_timer(&clint, mhartid, 0x1000000);
		break;
	case 0x8000000000000008:
		log("main: interrupt (User external interrupt) on hart %x\r\n", mhartid);
		break;
	case 0x8000000000000009:
		log("main: interrupt (Supervisor external interrupt) on hart %x\r\n", mha=
rtid);
		break;
	case 0x800000000000000a:
		log("main: interrupt (Reserved) on hart %x\r\n", mhartid);
		break;
	case 0x800000000000000b:
		log("main: interrupt (Machine external interrupt) on hart %x\r\n", mharti=
d);
		main_plic_wake_up(mhartid);
		break;
	default:
		if(mcause < 0x8000000000000000) log("main: unknown exception (%x) on hart=
 %x\r\n", mcause, mhartid);
		else log("main: unknown interrupt (%x) on hart %x\r\n", mcause & 0x7fffff=
ffffffffff, mhartid);
		break;
	}

	while(mcause < 0x8000000000000000){} // TODO exception or interrupt not im=
plemented, spin forever
}
</pre>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859291

Title:
  RISC-V incorrect exception generated

Status in QEMU:
  New

Bug description:
  When using 'ecall' from supervisor mode, user exception is raised
  instead of supervisor exception. The problem is located under
  'target/riscv/insn_trans/trans_priviledged.inc.c' in function 'static
  bool trans_ecall(DisasContext *ctx, arg_ecall *a)'. Best regards,
  Serge Teodori

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859291/+subscriptions

