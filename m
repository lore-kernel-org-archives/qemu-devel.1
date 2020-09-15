Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 21:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1F120731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 21:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKaP9YI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1F120731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIIiO-0000Om-RE
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 17:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kIIhI-0007xv-A1; Tue, 15 Sep 2020 17:41:08 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:43211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kIIhF-0003vj-8e; Tue, 15 Sep 2020 17:41:08 -0400
Received: by mail-oi1-x22f.google.com with SMTP id i17so5604494oig.10;
 Tue, 15 Sep 2020 14:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=+bdkvxYDzwoyzelnsVlHhvpSQ7nsb7hYsPelyUlAoss=;
 b=RKaP9YI813G+9hQNd+4lYi1C5mH5RmGtq4L/nVnvkcpxVFTpRo54BqkDfv9v7hevKI
 gNRGop+nNdnu70Dem9p27LGaR/qu42/0rD0VTnE+Ah8c7zxWxmpMyY2tulmvf7hNxV4Y
 2o6gHlxcnv+4LeepThrN6reBNAYy9QrSFJY6ZeOdITjigIHPullLaIKx6nILd8QqSpEG
 Y/6apocZg5doUPvqBzoWSWM2LPjWhPzTU4btd792EaVc2+L9BvNc0rGbvPkEpNBoMe7F
 6eopLzOC0eF5cNbFY2waH5EROVs2crG846dhP49h3fEALfq/HbEOGNCXLuHCZTFCdxfN
 ufvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=+bdkvxYDzwoyzelnsVlHhvpSQ7nsb7hYsPelyUlAoss=;
 b=EHTvwM2Z9mTakDRnc44eP/EeCjGcOE79Rs508fFn4Dxroa13KNd+WrOGOCAMGRFLlr
 FOfB5B3f/NWQBlYtSh/fvXPy35gTo6XLebzMOFteubLjFmz2Ia2D/A8QLfs+V+tmWMvp
 TeK7LzhZZdloVPK46ko99J6Tri1QVXeIGJvD2onfruyVKw1fOQSdhfBTZHqaa1Sm9oyb
 Lg2nnBz9MkuO0NGKyTiTWJ/F1h7i9EtHUM0I5ReFn2OfBzgMOySqytfg70gyrjMPRMYt
 qwyHcCCWdGdTpNSMOfVKdCK8pIYoolTZICGz6CfAE3bRy3VLx1r5v2VHn4QIJ+69g9Gd
 yugQ==
X-Gm-Message-State: AOAM533NKhLUGsujFzRqRAudoqBXJtoxGZ6U3cyJ/KINL7xWlqDovj8D
 d8EYRhPW4hoZ7XTeuLXoMhZTVcSpZ34=
X-Google-Smtp-Source: ABdhPJxhv1lAqnFYV0/I/d5rf170KyWnyYfDUSLzCTh4Lb6xgu5R6QLocdeGrAvfJkwlUHcAv50Qqg==
X-Received: by 2002:aca:c313:: with SMTP id t19mr1032822oif.65.1600206062918; 
 Tue, 15 Sep 2020 14:41:02 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 81sm6710723otf.18.2020.09.15.14.41.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Sep 2020 14:41:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <160020603244.28947.395503641924216458@sif>
Subject: [ANNOUNCE] QEMU 5.0.1 Stable released
Date: Tue, 15 Sep 2020 16:40:32 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi everyone,

I am pleased to announce that the QEMU v5.0.1 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v5.0.1 is now tagged in the official qemu.git repository,
and the stable-5.0 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-5.0

This update contains general fixes for various architectures/subsystems,
including the following CVE fixes:

    ati-vga (CVE-2020-13800)
    MMIO (CVE-2020-13754)
    NBD server (CVE-2020-10761)
    sdcard (CVE-2020-13253)
    usb (CVE-2020-14364)
    virtiofsd (CVE-2020-10717)

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

386b2a5767: Update version for 5.0.1 release (Michael Roth)
5c49f7ee3b: riscv: sifive_test: Allow 16-bit writes to memory region (Natha=
n Chancellor)
b8fdfa9d63: virtio-ccw: fix virtio_set_ind_atomic (Halil Pasic)
ebf5b3946e: nvram: Exit QEMU if NVRAM cannot contain all -prom-env data (Gr=
eg Kurz)
f2fd6555c7: 9p: null terminate fs driver options list (Prasad J Pandit)
f243bb4b0d: usb: fix setup_len init (CVE-2020-14364) (Gerd Hoffmann)
a575af07b8: hw/arm/sbsa-ref: fix typo breaking PCIe IRQs (Graeme Gregory)
5e817ece11: virtio-net: align RSC fields with updated virtio-net header (Yu=
ri Benditovich)
b57df52546: nbd: Fix large trim/zero requests (Eric Blake)
921352867b: iotests/028: Add test for cross-base-EOF reads (Max Reitz)
dcf682dd13: block: Fix bdrv_aligned_p*v() for qiov_offset !=3D 0 (Max Reitz)
08550a9940: migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_st=
art (Vladimir Sementsov-Ogievskiy)
b52a91816e: Update OpenBIOS images to 7f28286f built from submodule. (Mark =
Cave-Ayland)
eca194d43c: libvhost-user: Report descriptor index on panic (Philippe Mathi=
eu-Daud=C3=A9)
d8f0b2bbf4: virtio-pci: Changed vdev to proxy for VirtIO PCI BAR callbacks.=
 (Andrew Melnychenko)
58c523563d: intel_iommu: Use correct shift for 256 bits qi descriptor (Liu =
Yi L)
7c4c30e764: virtio-balloon: Replace free page hinting references to 'report=
' with 'hint' (Alexander Duyck)
595c40575b: linux-headers: update against Linux 5.7-rc3 (Cornelia Huck)
6261aa4ff5: virtio-balloon: always indicate S_DONE when migration fails (Da=
vid Hildenbrand)
7eb63fccf4: virtio-balloon: Add locking to prevent possible race when start=
ing hinting (Alexander Duyck)
67808fda37: virtio-balloon: Prevent guest from starting a report when we di=
dn't request one (Alexander Duyck)
c16fd8a2bb: qdev: Fix device_add DRIVER,help to print to monitor (Markus Ar=
mbruster)
d2581f25ec: tests: tpm: Skip over pcrUpdateCounter byte in result compariso=
n (Stefan Berger)
42e9a42083: tpm: tpm_spapr: Exit on TPM backend failures (Stefan Berger)
2f783fb459: target/hppa: Free some temps in do_sub (Richard Henderson)
d7fab184e9: hw/sd/sdcard: Do not switch to ReceivingData if address is inva=
lid (Philippe Mathieu-Daud=C3=A9)
c8966bff5f: hw/sd/sdcard: Update coding style to make checkpatch.pl happy (=
Philippe Mathieu-Daud=C3=A9)
e569ca39fa: hw/sd/sdcard: Do not allow invalid SD card sizes (Philippe Math=
ieu-Daud=C3=A9)
6a34f7752f: hw/sd/sdcard: Simplify realize() a bit (Philippe Mathieu-Daud=
=C3=A9)
557980ba70: hw/sd/sdcard: Restrict Class 6 commands to SCSD cards (Philippe=
 Mathieu-Daud=C3=A9)
b6f4d5bf20: tests/acceptance/boot_linux: Expand SD card image to power of 2=
 (Philippe Mathieu-Daud=C3=A9)
bc67d011c3: tests/acceptance: refactor boot_linux_console test to allow cod=
e reuse (Pavel Dovgalyuk)
5bdcc0f3ed: tests/acceptance: refactor boot_linux to allow code reuse (Pave=
l Dovgalyuk)
f756254e0a: tests/acceptance: allow console interaction with specific VMs (=
Pavel Dovgalyuk)
7b41093d14: tests/acceptance/boot_linux: Tag tests using a SD card with 'de=
vice:sd' (Philippe Mathieu-Daud=C3=A9)
acb988e20c: docs/orangepi: Add instructions for resizing SD image to power =
of two (Niek Linnenbank)
3ddb01cd14: qga: Use qemu_get_host_name() instead of g_get_host_name() (Mic=
hal Privoznik)
ad1169e23c: util: Introduce qemu_get_host_name() (Michal Privoznik)
a799013e71: qga: fix assert regression on guest-shutdown (Marc-Andr=C3=A9 L=
ureau)
54e74a45a5: chardev/tcp: Fix error message double free error (lichun)
9380cb9de2: nbd: Avoid off-by-one in long export name truncation (Eric Blak=
e)
b3e49baa79: usb/dev-mtp: Fix Error double free after inotify failure (Marku=
s Armbruster)
558905635b: error: Use error_reportf_err() where appropriate (Markus Armbru=
ster)
b17b3c209b: net/virtio: Fix failover_replug_primary() return value regressi=
on (Markus Armbruster)
7a1f17a51e: hw/audio/gus: Fix registers 32-bit access (Allan Peramaki)
0aad2a5255: virtiofsd: Whitelist fchmod (Max Reitz)
0fd3972e1c: hw/net/e1000e: Do not abort() on invalid PSRCTL register value =
(Philippe Mathieu-Daud=C3=A9)
045849b078: hw/display/artist: Unbreak size mismatch memory accesses (Helge=
 Deller)
974b857df6: acpi: accept byte and word access to core ACPI registers (Micha=
el Tokarev)
782e94132a: xhci: fix valid.max_access_size to access address registers (La=
urent Vivier)
182be02962: hw/riscv: Allow 64 bit access to SiFive CLINT (Alistair Francis)
b14cd263ad: memory: Revert "memory: accept mismatching sizes in memory_regi=
on_access_valid" (Michael S. Tsirkin)
68d84b133d: libqos: pci-pc: use 32-bit write for EJ register (Paolo Bonzini)
e399bb1bf1: libqos: usb-hcd-ehci: use 32-bit write for config register (Pao=
lo Bonzini)
160546b81e: linux-user/strace.list: fix epoll_create{,1} -strace output (Se=
rgei Trofimovich)
dcc935873b: aio-posix: disable fdmon-io_uring when GSource is used (Stefan =
Hajnoczi)
5145f2471c: aio-posix: don't duplicate fd handler deletion in fdmon_io_urin=
g_destroy() (Stefan Hajnoczi)
458ae56d22: KVM: x86: believe what KVM says about WAITPKG (Paolo Bonzini)
521898ac31: net: use peer when purging queue in qemu_flush_or_purge_queue_p=
ackets() (Jason Wang)
c1abbd0f04: virtiofsd: stay below fs.file-max sysctl value (CVE-2020-10717)=
 (Stefan Hajnoczi)
a637ea0c52: virtiofsd: add --rlimit-nofile=3DNUM option (Stefan Hajnoczi)
73a01bc9b0: iotests/283: Use consistent size for source and target (Kevin W=
olf)
d723a57acd: Fix tulip breakage (Helge Deller)
dd506af071: es1370: check total frame count against current frame (Prasad J=
 Pandit)
387a3ac89d: ati-vga: check mm_index before recursive call (CVE-2020-13800) =
(Prasad J Pandit)
cb84d9d353: xen/9pfs: yield when there isn't enough room on the ring (Stefa=
no Stabellini)
b38d9cada4: Revert "9p: init_in_iov_from_pdu can truncate the size" (Stefan=
o Stabellini)
f56a86ad8d: xen-9pfs: Fix log messages of reply errors (Christian Schoenebe=
ck)
5bfdf41d7c: 9pfs: include linux/limits.h for XATTR_SIZE_MAX (Dan Robertson)
e37ba5c637: 9pfs: local: ignore O_NOATIME if we don't have permissions (Oma=
r Sandoval)
4cc0a28a6e: block: Call attention to truncation of long NBD exports (Eric B=
lake)
d1cba8ca60: virtio-balloon: unref the iothread when unrealizing (David Hild=
enbrand)
945d9273c8: virtio-balloon: fix free page hinting check on unrealize (David=
 Hildenbrand)
99458fbb56: virtio-balloon: fix free page hinting without an iothread (Davi=
d Hildenbrand)
d48973dc26: nbd/server: Avoid long error message assertions CVE-2020-10761 =
(Eric Blake)
c6414cb183: net: Do not include a newline in the id of -nic devices (Thomas=
 Huth)
250322bfbd: 9p: Lock directory streams with a CoMutex (Greg Kurz)
bdac9aabd9: qemu-nbd: Close inherited stderr (Raphael Pour)
352259fef8: target/arm: Clear tail in gvec_fmul_idx_*, gvec_fmla_idx_* (Ric=
hard Henderson)
9e6e3ba309: hostmem: don't use mbind() if host-nodes is empty (Igor Mammedo=
v)


