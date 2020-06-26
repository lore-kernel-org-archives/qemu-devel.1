Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAADC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 00:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF38E2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 00:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rheNBc6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF38E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jocig-0007dA-T9
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 20:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jochm-0006ke-Mj; Thu, 25 Jun 2020 20:58:58 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:46260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jochk-0002VB-7Q; Thu, 25 Jun 2020 20:58:58 -0400
Received: by mail-oi1-x22a.google.com with SMTP id l63so6644412oih.13;
 Thu, 25 Jun 2020 17:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:to:message-id
 :user-agent:subject:date;
 bh=tTzrU/7cIARTJdmGIzd3R/w5L/BPBqOuHhaPCYLzYYs=;
 b=rheNBc6VtveMQ/ZECAuMm59BARPpYCWruXEZyEBWV1XJhbqrrS2r9dG8XF9llUf7Jt
 WjnSijkb1xnjNBlF7X4xqEZZiO5e7DI2fNj9IcsK4S0fLxf8d6SsinDKew/O6SxolDcK
 D1DToQkhvbLM1803kw6JimU89/WLoEq7iXVUjwIaVudxHofAHsFvCeekSv3bu8Vs6DE/
 MfzOWfWKUYjRXSdNcwQ4J1DBuKYSGAlfpZ1qohirCITD4LP6I0XFs6XL32StNhYJ8dfu
 oMkf3/BfFzXZzPmorUjgxrn5m/mRAbv2LaCeds8kfZR1IVqRqX+iJnhFcqg7skCcuG8e
 Vk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:to:message-id:user-agent:subject:date;
 bh=tTzrU/7cIARTJdmGIzd3R/w5L/BPBqOuHhaPCYLzYYs=;
 b=WeELDh4ulwNadUKoGVD/DwnzF69eoRmHXkkuGOO1ARpnBZw0eR/ic4h2OluuoG09BU
 oupRbsHLQ4jllaYNfPG+aTphhaOMwURvbj5xfNDbR1afUJ8LCXvtdGinv3fJqxSSOxnq
 Ll4mbJqBZllEMOf/Z06Uc5VStBizziwT3W1bclS84rqbQ7IMpgwxFNxTXuIXs3hLNOO9
 mDDFCLhUxCoVb/ZnNvSvVGlnl3TD5VzKxzqAoLFG+Slvp7c0c0mckOoxvzm+WjGYyAYm
 4295e+DoqaGt0A1AryPZQK65y14m747W8ACR9gNiyZou/2WrzGKjyVFWTJyV0rn3ct+p
 VyWA==
X-Gm-Message-State: AOAM532tghd5tCYvjEbFzmGwJfYluMSjwZgWpiNDyBezHkX/U/UCQ+om
 Lr/8kbvwwA5FBVXiY6KNmqGEq11u
X-Google-Smtp-Source: ABdhPJx+Nb9Wc0dMh94sHw2PnI3H/k+ruBCDd2VzvbSQVNpsXH5INiyJviQ6gzOv8xJfIfZQCoIBnw==
X-Received: by 2002:aca:1a03:: with SMTP id a3mr612062oia.99.1593133133210;
 Thu, 25 Jun 2020 17:58:53 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id q10sm5837536otl.40.2020.06.25.17.58.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 25 Jun 2020 17:58:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Message-ID: <159313312275.22574.7530445282588665139@sif>
User-Agent: alot/0.7
Subject: [ANNOUNCE] QEMU 4.2.1 Stable released
Date: Thu, 25 Jun 2020 19:58:42 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

I am pleased to announce that the QEMU v4.2.1 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v4.2.1 is now tagged in the official qemu.git repository,
and the stable-4.2 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-4.2

This update contains general fixes for various architectures/subsystems,
including CVE fixes for slirp (CVE-2020-1983), NBD (CVE-2020-10761),
iscsi (CVE-2020-1711), ati-vga (CVE-2020-13800, CVE-2020-11869), and
es1370 (CVE-2020-13361).

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

6cdf8c4efa: Update version for 4.2.1 release (Michael Roth)
4a0db6ba7d: iotests/283: Use consistent size for source and target (Kevin W=
olf)
0664ffac4b: Fix tulip breakage (Helge Deller)
27f56b9aa2: tcg/mips: mips sync* encode error (lixinyu)
97701bc03e: target/xtensa: fix pasto in pfwait.r opcode name (Max Filippov)
ecdb0d5651: vpc: Don't round up already aligned BAT sizes (Kevin Wolf)
9c2e242077: spapr: Fix failure path for attempting to hot unplug PCI bridge=
s (David Gibson)
fb6a24fb1d: net: tulip: check frame size and r/w data length (Prasad J Pand=
it)
60c21aa017: sheepdog: Consistently set bdrv_has_zero_init_truncate (Eric Bl=
ake)
5eca12bbad: qcow2: List autoclear bit names in header (Eric Blake)
1c8d9fb334: migration/ram: fix use after free of local_err (Vladimir Sement=
sov-Ogievskiy)
09397e9657: migration/colo: fix use after free of local_err (Vladimir Semen=
tsov-Ogievskiy)
674d382225: hmp/vnc: Fix info vnc list leak (Dr. David Alan Gilbert)
5ff78dc9bc: block: bdrv_set_backing_bs: fix use-after-free (Vladimir Sement=
sov-Ogievskiy)
47e0fa7479: block: Avoid memleak on qcow2 image info failure (Eric Blake)
745859d5bf: ppc/ppc405_boards: Remove unnecessary NULL check (Philippe Math=
ieu-Daud=C3=A9)
c6decabc4a: iotests: Fix nonportable use of od --endian (Eric Blake)
580c08b326: pc-bios: s390x: Save iplb location in lowcore (Janosch Frank)
9dd68ac26b: hw/arm/cubieboard: use ARM Cortex-A8 as the default CPU in mach=
ine definition (Niek Linnenbank)
4e258da94a: vhost-user-blk: delete virtioqueues in unrealize to fix memleak=
s (Pan Nengyuan)
e08de99abe: virtio-crypto: do delete ctrl_vq in virtio_crypto_device_unreal=
ize (Pan Nengyuan)
5e063a5846: virtio-pmem: do delete rq_vq in virtio_pmem_unrealize (Pan Neng=
yuan)
1509a13240: target/arm: Correct definition of PMCRDP (Peter Maydell)
0b487ea664: block: Fix VM size field width in snapshot dump (Max Reitz)
3dd28c8ecc: block: fix crash on zero-length unaligned write and read (Vladi=
mir Sementsov-Ogievskiy)
ee9f37f3e5: target/arm/monitor: query-cpu-model-expansion crashed qemu when=
 using machine type none (Liang Yan)
8952da32c3: iotests: add test for backup-top failure on permission activati=
on (Vladimir Sementsov-Ogievskiy)
e92b21ffc4: block/backup-top: fix failure path (Vladimir Sementsov-Ogievski=
y)
a967e75f3a: block: fix memleaks in bdrv_refresh_filename (Pan Nengyuan)
aacf6bfb7e: target/arm: fix TCG leak for fcvt half->double (Alex Benn=C3=A9=
e)
4b34c6d724: audio/oss: fix buffer pos calculation (Gerd Hoffmann)
9adb6569bf: hw/intc/arm_gicv3_kvm: Stop wrongly programming GICR_PENDBASER.=
PTZ bit (Zenghui Yu)
b1b362aa8e: tpm-ppi: page-align PPI RAM (Marc-Andr=C3=A9 Lureau)
dc6bdba433: block/backup: fix memory leak in bdrv_backup_top_append() (Eiic=
hi Tsukata)
bc509b2a5b: s390x: adapter routes error handling (Cornelia Huck)
cd8ecfb19c: target/i386: kvm: initialize feature MSRs very early (Paolo Bon=
zini)
abf9ffa7b3: target/arm: Fix PAuth sbox functions (Vincent Dehors)
c44015c50c: m68k: Fix regression causing Single-Step via GDB/RSP to not sin=
gle step (Laurent Vivier)
b5ba361d8f: Revert "vnc: allow fall back to RAW encoding" (Gerd Hoffmann)
52771abbfa: migration: Rate limit inside host pages (Dr. David Alan Gilbert)
d306348fd6: runstate: ignore finishmigrate -> prelaunch transition (Laurent=
 Vivier)
f3ef98874e: target/arm: Return correct IL bit in merge_syn_data_abort (Jeff=
 Kubascik)
e8a286010c: migration-test: ppc64: fix FORTH test program (Laurent Vivier)
9a30621d3d: blkdebug: Allow taking/unsharing permissions (Max Reitz)
0972fbf353: block: Add bdrv_qapi_perm_to_blk_perm() (Max Reitz)
9b59fdf478: hw/arm/smmuv3: Report F_STE_FETCH fault address in correct word=
 position (Simon Veith)
ec3bd881e2: hw/arm/smmuv3: Use correct bit positions in EVT_SET_ADDR2 macro=
 (Simon Veith)
65fad28d85: hw/arm/smmuv3: Align stream table base address to table size (S=
imon Veith)
256ecc06eb: hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE (=
Simon Veith)
606a6bf788: hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value (Simon Veith)
e8ae3a4e2b: hw/arm/smmuv3: Apply address mask to linear strtab base address=
 (Simon Veith)
7e1bc51f3f: display/bochs-display: fix memory leak (Cameron Esfahani)
8d151ab5c2: vhost-user-gpu: Drop trailing json comma (Cole Robinson)
6772bba8a4: iotests: Fix IMGOPTSSYNTAX for nbd (Max Reitz)
45b65bf8df: Fix double free issue in qemu_set_log_filename(). (Robert Foley)
aea7a50fb5: Revert "qemu-options.hx: Update for reboot-timeout parameter" (=
Han Han)
2f7597fbc2: iotests/026: Move v3-exclusive test to new file (Max Reitz)
f127d16397: dp8393x: Mask EOL bit from descriptor addresses, take 2 (Finn T=
hain)
862240852b: slirp: update to fix CVE-2020-1983 (Marc-Andr=C3=A9 Lureau)
1343d33371: kvm: Reallocate dirty_bmap when we change a slot (Dr. David Ala=
n Gilbert)
c436692c6a: es1370: check total frame count against current frame (Prasad J=
 Pandit)
69a6048e1e: ati-vga: check mm_index before recursive call (CVE-2020-13800) =
(Prasad J Pandit)
01392ae31a: ati-vga: Fix checks in ati_2d_blt() to avoid crash (BALATON Zol=
tan)
4e98c388d6: iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711) (Fel=
ipe Franciosi)
54bcaf08d6: target/i386: do not set unsupported VMX secondary execution con=
trols (Vitaly Kuznetsov)
e727aa1a7b: target/riscv: update mstatus.SD when FS is set dirty (ShihPo Hu=
ng)
690e3004ae: target/riscv: fsd/fsw doesn't dirty FP state (ShihPo Hung)
a918ea2ec3: target/riscv: Fix tb->flags FS status (ShihPo Hung)
c1cad76dcd: riscv: Set xPIE to 1 after xRET (Yiting Wang)
a6e44eee6c: riscv/sifive_u: fix a memory leak in soc_realize() (Pan Nengyua=
n)
3729ff3032: tests: fix modules-test 'duplicate test case' error (Cole Robin=
son)
2367c7235b: xen/9pfs: yield when there isn't enough room on the ring (Stefa=
no Stabellini)
0c6499ff2b: 9pfs: include linux/limits.h for XATTR_SIZE_MAX (Dan Robertson)
17216bc044: 9pfs: local: ignore O_NOATIME if we don't have permissions (Oma=
r Sandoval)
410252fc5b: 9p/proxy: Fix export_flags (Greg Kurz)
603cda272d: virtio-9p-device: fix memleak in virtio_9p_device_unrealize (Pa=
n Nengyuan)
03afe9c035: 9p: local: always return -1 on error in local_unlinkat_common (=
Daniel Henrique Barboza)
18f6b13e08: 9pfs: local: Fix possible memory leak in local_link() (Jiajun C=
hen)
6c75ddf4a9: block: Call attention to truncation of long NBD exports (Eric B=
lake)
d6d45d9ed1: virtio-balloon: unref the iothread when unrealizing (David Hild=
enbrand)
2a7c80d82e: virtio-balloon: fix free page hinting check on unrealize (David=
 Hildenbrand)
e27f334fdc: virtio-balloon: fix free page hinting without an iothread (Davi=
d Hildenbrand)
0c1d805360: nbd/server: Avoid long error message assertions CVE-2020-10761 =
(Eric Blake)
252d614ea2: net: Do not include a newline in the id of -nic devices (Thomas=
 Huth)
dad6d5e7e6: 9p: Lock directory streams with a CoMutex (Greg Kurz)
ad56aecb21: qemu-nbd: Close inherited stderr (Raphael Pour)
d5691a6373: target/arm: Clear tail in gvec_fmul_idx_*, gvec_fmla_idx_* (Ric=
hard Henderson)
34c78a4100: hostmem: don't use mbind() if host-nodes is empty (Igor Mammedo=
v)
8d127b4be7: target/ppc: Fix mtmsr(d) L=3D1 variant that loses interrupts (N=
icholas Piggin)
ea1518bb5e: vhost-user-gpu: Release memory returned by vu_queue_pop() with =
free() (Philippe Mathieu-Daud=C3=A9)
c5feb39219: xen-block: Fix double qlist remove and request leak (Anthony PE=
RARD)
25fcaed9a3: dump: Fix writing of ELF section (Peter Maydell)
aabd9ddd2d: tcg/i386: Fix INDEX_op_dup2_vec (Richard Henderson)
33be7aa9b6: hw/i386/amd_iommu.c: Fix corruption of log events passed to gue=
st (Peter Maydell)
8f5728cb97: qemu-ga: document vsock-listen in the man page (Stefan Hajnoczi)
e3531619f1: qga: Fix undefined C behavior (Eric Blake)
4996bd7161: qga-win: prevent crash when executing guest-file-read with larg=
e count (Basil Salman)
3c3e1653c5: qga-win: Handle VSS_E_PROVIDER_ALREADY_REGISTERED error (Sameeh=
 Jubran)
7cc217b30d: qga: Installer: Wait for installation to finish (Basil Salman)
219362f965: compat: disable edid on correct virtio-gpu device (Cornelia Huc=
k)
8fc4aa4822: block/io: fix bdrv_co_do_copy_on_readv (Vladimir Sementsov-Ogie=
vskiy)
4a9486a02d: target/ppc: Fix rlwinm on ppc64 (Vitaly Chikunov)
c44c4f7229: block/block-copy: fix progress calculation (Vladimir Sementsov-=
Ogievskiy)
a0dc4d2495: job: refactor progress to separate object (Vladimir Sementsov-O=
gievskiy)
e0ccde3887: block/qcow2-threads: fix qcow2_decompress (Vladimir Sementsov-O=
gievskiy)
4a1c5955e7: scsi/qemu-pr-helper: Fix out-of-bounds access to trnptid_list[]=
 (Christophe de Dinechin)
2dc540e40d: virtio: gracefully handle invalid region caches (Stefan Hajnocz=
i)
4540aa4a8d: iotests/026: Test EIO on allocation in a data-file (Max Reitz)
30aa0ea6c5: iotests/026: Test EIO on preallocated zero cluster (Max Reitz)
382b9f09bd: qcow2: Fix alloc_cluster_abort() for pre-existing clusters (Max=
 Reitz)
373fd948ab: iotests: Test copy offloading with external data file (Kevin Wo=
lf)
ab7f6eaa5b: qcow2: Fix qcow2_alloc_cluster_abort() for external data file (=
Kevin Wolf)
f9854de0d8: qcow2: update_refcount(): Reset old_table_index after qcow2_cac=
he_put() (Kevin Wolf)
e49ae74a24: tcg: save vaddr temp for plugin usage (Alex Benn=C3=A9e)
0319118bcf: plugins/core: add missing break in cb_to_tcg_flags (Emilio G. C=
ota)
2a7569e751: s390/sclp: improve special wait psw logic (Christian Borntraege=
r)
3e1d95301e: dp8393x: Don't stop reception upon RBE interrupt assertion (Fin=
n Thain)
735cd8ddab: dp8393x: Don't reset Silicon Revision register (Finn Thain)
1190026fe4: dp8393x: Always update RRA pointers and sequence numbers (Finn =
Thain)
8d61b1e2c4: dp8393x: Clear descriptor in_use field to release packet (Finn =
Thain)
cbc8277051: dp8393x: Pad frames to word or long word boundary (Finn Thain)
e7cad754fd: dp8393x: Use long-word-aligned RRA pointers in 32-bit mode (Fin=
n Thain)
d50aa8acbc: dp8393x: Don't clobber packet checksum (Finn Thain)
3a8068f4eb: dp8393x: Implement packet size limit and RBAE interrupt (Finn T=
hain)
5f08c382ca: dp8393x: Clear RRRA command register bit only when appropriate =
(Finn Thain)
edd67a61f4: dp8393x: Update LLFA and CRDA registers from rx descriptor (Fin=
n Thain)
153c3320e7: dp8393x: Have dp8393x_receive() return the packet size (Finn Th=
ain)
bf3f12ac8c: dp8393x: Clean up endianness hacks (Finn Thain)
956e1b2d97: dp8393x: Always use 32-bit accesses (Finn Thain)
eb54a2f9ce: dp8393x: Mask EOL bit from descriptor addresses (Finn Thain)
fa446ae444: qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap (Vladimir S=
ementsov-Ogievskiy)
3fb2521040: vfio/pci: Don't remove irqchip notifier if not registered (Pete=
r Xu)
742195db17: intel_iommu: add present bit check for pasid table entries (Liu=
 Yi L)
98c74fe49a: intel_iommu: a fix to vtd_find_as_from_bus_num() (Liu Yi L)
7042922dd7: virtio-net: delete also control queue when TX/RX deleted (Yuri =
Benditovich)
a474197f11: virtio: reset region cache when on queue deletion (Yuri Bendito=
vich)
a843731d7f: virtio: make virtio_delete_queue idempotent (Michael S. Tsirkin)
d5a5d43e27: virtio: add ability to delete vq through a pointer (Michael S. =
Tsirkin)
0253531824: virtio-mmio: update queue size on guest write (Denis Plotnikov)
2f4affb721: virtio: update queue size on guest write (Michael S. Tsirkin)
77d9c84d9f: target/arm: Set ISSIs16Bit in make_issinfo (Richard Henderson)
4412cb3bca: ide: Fix incorrect handling of some PRDTs in ide_dma_cb() (Alex=
ander Popov)
3a94a8b7fd: tests/ide-test: Create a single unit-test covering more PRDT ca=
ses (Alexander Popov)
0cfa46da8f: hw/i386/pc: fix regression in parsing vga cmdline parameter (Pe=
ter Wu)
ba6a94e64e: arm/arm-powerctl: rebuild hflags after setting CP15 bits in arm=
_set_cpu_on() (Niek Linnenbank)
a5f815514a: arm/arm-powerctl: set NSACR.{CP11, CP10} bits in arm_set_cpu_on=
() (Niek Linnenbank)
2215837fe2: backup-top: Begin drain earlier (Max Reitz)
cbdfd3865b: numa: properly check if numa is supported (Igor Mammedov)
89eebb016d: numa: remove not needed check (Igor Mammedov)
def30090ad: virtio-blk: fix out-of-bounds access to bitmap in notify_guest_=
bh (Li Hangjing)
52a02834e0: block: Activate recursively even for already active nodes (Kevi=
n Wolf)
da0948d13c: target/arm: ensure we use current exception state after SCR upd=
ate (Alex Benn=C3=A9e)
d636d64b35: qapi: better document NVMe blockdev @device parameter (Daniel P=
. Berrang=C3=A9)
bed590f2b8: i386: Resolve CPU models to v1 by default (Eduardo Habkost)
a115daadf6: block/nbd: fix memory leak in nbd_open() (Pan Nengyuan)
85df33073a: block/nbd: extract the common cleanup code (Pan Nengyuan)


