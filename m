Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F47C2D0EC
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 00:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA172054F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 00:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE4q8GAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA172054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLypu-00018Q-5D
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 20:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jLypG-0000iE-DG
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 20:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jLypE-00023K-Fh
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 20:44:18 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jLypE-00022P-AD
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 20:44:16 -0400
Received: by mail-ot1-x343.google.com with SMTP id a49so5128268otc.11
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 17:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=ikRx3RcdYTgTeCeCfUgMHF61w8IKtGxjYaA617TF+dI=;
 b=SE4q8GAceYiu02pwoa/HvrFRHl9zhLIVMiCa+Sla+znjQeAqHuvz0SSSk0J+Z+1yBE
 iAEMm+77yGGpndXKzQdRb1gP+gDhLEzYnGONGZFYHT5i8hH4zGWXAhLj4s/U3k0/KNXR
 oPAwDxUQ415akEQvT7pcNyXrDeU5KEufsOIvQfsGnFsMSK3B9LsM0GFSRqDGZL2nZaMl
 ELA8MZpQaAew5HcqmpfZPphNPI/usXWycnGvSND9ZCR7IRnRw+vcA4XTl9kmtXhqjHdR
 LkuxgaACdUPCs3ee0/uqpLT0nRELPCtUQA+8Hkfi6GbKWhjoUb+zA3oUR8tUwcuWQWZW
 iF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=ikRx3RcdYTgTeCeCfUgMHF61w8IKtGxjYaA617TF+dI=;
 b=USXdFEyC4LANYhswXk34cqd3tlbh6IgXRBwYmx/H0WtARQvmKx0g7nkGMffjaUUl4a
 ZY8DsLT7Lm6cuql4lanpWPlOixVfsE7+59iRFoeqWeY36r5Uam/k6bVsJ/i2Wqol2hQE
 6U93MIDDiPNhyWSsZqtQSpMn9rpEmQxfVEzPgYlmE17ePmOPNOK+/SNstHSZ1XYQeVPu
 agaGdgmXYCZIdoShCzc0SAomWeBMfySIf76XYhW4XgrbpovHbaitgmyKAt6ma3ukXwqY
 EvWE8obLQa5fyp6wGlxL0Z68WL6y/u+oEmA/yhM9ImRhiVPyvokqVCylyynZYai5aw/v
 fQKg==
X-Gm-Message-State: AGi0PuaOTR5pbHR0CFBq0QQqHKCPaCtzm+oxB0xVgeXqOasVPV+ozVkl
 tMpodZPhwUCveS9WQryLM0Q=
X-Google-Smtp-Source: APiQypLsa94Vj0NAcMsVq9BNNEjRJf6TtcUgyYWaZNvPjB56zsHM1JjvwsfDztbcn+nj6RLv7NXWOA==
X-Received: by 2002:a05:6830:1b64:: with SMTP id
 d4mr3699985ote.368.1586306654866; 
 Tue, 07 Apr 2020 17:44:14 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id r24sm597348otq.9.2020.04.07.17.44.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 07 Apr 2020 17:44:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <158630664575.20966.7092686868903628704@sif>
Subject: [ANNOUNCE] QEMU 5.0.0-rc2 is now available
Date: Tue, 07 Apr 2020 19:44:05 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
third release candidate for the QEMU 5.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-5.0.0-rc2.tar.xz
  http://download.qemu-project.org/qemu-5.0.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 5.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/5.0

Please add entries to the ChangeLog for the 5.0 release below:

  http://wiki.qemu.org/ChangeLog/5.0

Thank you to everyone involved!

Changes since rc1:

f3bac27cc1: Update version for v5.0.0-rc2 release (Peter Maydell)
cce743abbf: tcg/i386: Fix %r12 guest_base initialization (Richard Henderson)
eca7a8e6c0: configure: Add -Werror to PIE probe (Richard Henderson)
58d5e749d6: hw/core: properly terminate loading .hex on EOF record (Alex Be=
nn=C3=A9e)
bb55173cfb: linux-user: clean-up padding on /proc/self/maps (Alex Benn=C3=
=A9e)
01ef6b9e4e: linux-user: factor out reading of /proc/self/maps (Alex Benn=C3=
=A9e)
2f311075b7: softfloat: Fix BAD_SHIFT from normalizeFloatx80Subnormal (Richa=
rd Henderson)
076b2fadb5: gdbstub: fix compiler complaining (Denis Plotnikov)
1f089c6705: target/xtensa: add FIXME for translation memory leak (Alex Benn=
=C3=A9e)
b859040dc4: linux-user: more debug for init_guest_space (Alex Benn=C3=A9e)
af7fc47f2c: tests/tcg: remove extraneous pasting macros (Alex Benn=C3=A9e)
bbf5f2a1aa: linux-user: protect fcntl64 with an #ifdef (Alex Benn=C3=A9e)
040425f849: elf-ops: bail out if we have no function symbols (Alex Benn=C3=
=A9e)
20a4f14f6e: .github: Enable repo-lockdown bot to refuse GitHub pull request=
s (Philippe Mathieu-Daud=C3=A9)
758af9cfab: MAINTAINERS: Add xen-usb.c to Xen section (Anthony PERARD)
0cd40042c5: xen-block: Fix uninitialized variable (Anthony PERARD)
1aef27c93d: hw/usb/xen-usb.c: Pass struct usbback_req* to usbback_packet_co=
mplete() (Peter Maydell)
3f6de653b9: vpc: Don't round up already aligned BAT sizes (Kevin Wolf)
7f16476fab: block: Fix blk->in_flight during blk_wait_while_drained() (Kevi=
n Wolf)
fbb92b6798: block: Increase BB.in_flight for coroutine and sync interfaces =
(Kevin Wolf)
564806c529: block-backend: Reorder flush/pdiscard function definitions (Kev=
in Wolf)
eca0f3524a: backup: don't acquire aio_context in backup_clean (Stefan Reite=
r)
08558e3325: replication: assert we own context before job_cancel_sync (Stef=
an Reiter)
b660a84bbb: job: take each job's lock individually in job_txn_apply (Stefan=
 Reiter)
36d883ba0d: xen-block: Fix double qlist remove and request leak (Anthony PE=
RARD)
25fb2e9c39: iotests/common.pattern: Quote echos (Max Reitz)
fb43d2d46e: qcow2: Check request size in qcow2_co_pwritev_compressed_part()=
 (Alberto Garcia)
39f77cb662: qemu-img: Report convert errors by bytes, not sectors (Eric Bla=
ke)
80f5c01183: qcow2: Forbid discard in qcow2 v2 images with backing files (Al=
berto Garcia)
1394dc0690: json: Fix check for unbalanced right curly brace (Simran Singha=
l)
ac2071c379: ati-vga: Fix checks in ati_2d_blt() to avoid crash (BALATON Zol=
tan)
25f3170b06: ppc/pnv: Create BMC devices only when defaults are enabled (C=
=C3=A9dric Le Goater)
a872e4328b: pseries: Update SLOF firmware image (Alexey Kardashevskiy)
2025fc6766: hw/ppc/ppc440_uc.c: Remove incorrect iothread locking from dcr_=
write_pcie() (Peter Maydell)
7aab589976: spapr: Fix failure path for attempting to hot unplug PCI bridge=
s (David Gibson)
4f7a11f93f: ppc/spapr: Don't kill the guest if a recovered FWNMI machine ch=
eck delivery fails (Nicholas Piggin)
b90b9ecb12: ppc/spapr: Add FWNMI machine check delivery warnings (Nicholas =
Piggin)
6c3dd24c05: ppc/spapr: Improve FWNMI machine check delivery corner case com=
ments (Nicholas Piggin)
ec010c0066: ppc/spapr: KVM FWNMI should not be enabled until guest requests=
 it (Nicholas Piggin)
79178edd2a: vfio/spapr: Fix page size calculation (Alexey Kardashevskiy)
3b4f50bd7d: hw/ppc/e500.c: Handle qemu_find_file() failure (Peter Maydell)
a41f167547: .travis.yml: Cache acceptance-test assets (Philippe Mathieu-Dau=
d=C3=A9)
5baecf58ad: tests/acceptance/machine_sparc_leon3: Disable HelenOS test (Phi=
lippe Mathieu-Daud=C3=A9)
b131b49768: tests/acceptance/ppc_prep_40p: Use mirror for ftp.software.ibm.=
com (Philippe Mathieu-Daud=C3=A9)
5cf67ac04f: tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname (Phi=
lippe Mathieu-Daud=C3=A9)
002b24c0c7: Acceptance test: Fix to EXEC migration (Oksana Vohchana)
8d1439b692: dsoundaudio: dsound_get_buffer_in should honor *size (Volker R=
=C3=BCmelin)
174702986c: dsoundaudio: fix "Could not lock capture buffer" warning (Volke=
r R=C3=BCmelin)
4ba664cb0a: dsoundaudio: fix never-ending playback loop (Volker R=C3=BCmeli=
n)
8893790966: dma/xlnx-zdma: Reorg to fix CUR_DSCR (Edgar E. Iglesias)
4ec037f1dd: dma/xlnx-zdma: Advance the descriptor address when stopping (Ed=
gar E. Iglesias)
4fc4678c60: dma/xlnx-zdma: Clear DMA_DONE when halting (Edgar E. Iglesias)
28009852aa: dma/xlnx-zdma: Populate DBG0.CMN_BUF_FREE (Edgar E. Iglesias)
12ba36d910: dma/xlnx-zdma: Remove comment (Edgar E. Iglesias)
6a4a38530e: qga/commands-posix: fix use after free of local_err (Vladimir S=
ementsov-Ogievskiy)
b0e709503c: dump/win_dump: fix use after free of err (Vladimir Sementsov-Og=
ievskiy)
d1d3a99795: scripts/coccinelle: add error-use-after-free.cocci (Vladimir Se=
mentsov-Ogievskiy)
174d2d6856: dump: Fix writing of ELF section (Peter Maydell)
c88311f272: hw/gpio/aspeed_gpio.c: Don't directly include assert.h (Peter M=
aydell)
07d1be3b3a: target/arm: Remove obsolete TODO note from get_phys_addr_lpae()=
 (Peter Maydell)
f4e1dbc578: target/arm: PSTATE.PAN should not clear exec bits (Peter Maydel=
l)
8a2b76ffc9: hw/arm/collie: Put StrongARMState* into a CollieMachineState st=
ruct (Peter Maydell)
9231951aa5: target/arm: don't expose "ieee_half" via gdbstub (Alex Benn=C3=
=A9e)
ae60ab7eb2: aio-posix: fix test-aio /aio/event/wait with fdmon-io_uring (St=
efan Hajnoczi)
0dc0389fa5: xen: fixup RAM memory region initialization (Igor Mammedov)
7f5d9b206d: object-add: don't create return value if failed (Paolo Bonzini)
b3fbb32812: qmp: fix leak on callbacks that return both value and error (Ma=
rc-Andr=C3=A9 Lureau)
9cbc36497c: migration: fix cleanup_bh leak on resume (Marc-Andr=C3=A9 Lurea=
u)
4a910e1f6a: target/i386: do not set unsupported VMX secondary execution con=
trols (Vitaly Kuznetsov)
f602d047ac: serial: Fix double migration data (Dr. David Alan Gilbert)
ddd31732a7: i386: hvf: Reset IRQ inhibition after moving RIP (Roman Bolshak=
ov)
622e99c5cf: vl: fix broken IPA range for ARM -M virt with KVM enabled (Igor=
 Mammedov)
5c30ef937f: vl/s390x: fixup ram sizes for compat machines (Christian Borntr=
aeger)
edd075ae2b: s390x: kvm: Fix number of cpu reports for stsi 3.2.2 (Janosch F=
rank)
8f13a39dc0: util/bufferiszero: improve avx2 accelerator (Robert Hoo)
b87c99d073: util/bufferiszero: assign length_to_accel value for each accele=
rator case (Robert Hoo)
674fc21ff6: MAINTAINERS: Add an entry for the HVF accelerator (Roman Bolsha=
kov)
4951247d8b: softmmu: fix crash with invalid -M memory-backend=3D (Marc-Andr=
=C3=A9 Lureau)
3b703feaf8: virtio-iommu: depend on PCI (Paolo Bonzini)
b822dfaecd: hw/isa/superio: Correct the license text (Philippe Mathieu-Daud=
=C3=A9)
e7ebf057e6: hw/scsi/vmw_pvscsi: Remove assertion for kick after reset (Elaz=
ar Leibovich)
d965dc3559: target/i386: Add ARCH_CAPABILITIES related bits into Icelake-Se=
rver CPU model (Xiaoyao Li)
ddc2fc9e4e: target/i386: set the CPUID level to 0x14 on old machine-type (L=
uwei Kang)
7b225762c8: i386: Fix pkg_id offset for EPYC cpu models (Babu Moger)
247b18c593: target/i386: Enable new apic id encoding for EPYC based cpus mo=
dels (Babu Moger)
2e26f4ab3b: hw/i386: Move arch_id decode inside x86_cpus_init (Babu Moger)
0c1538cb1a: i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition (=
Babu Moger)
6121c7fbfd: hw/i386: Introduce apicid functions inside X86MachineState (Bab=
u Moger)
dd08ef0318: target/i386: Cleanup and use the EPYC mode topology functions (=
Babu Moger)
7568b20555: hw/386: Add EPYC mode topology decoding functions (Babu Moger)


