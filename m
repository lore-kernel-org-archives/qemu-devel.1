Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D290FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 23:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7AE2074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 23:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7TFEzBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7AE2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ZOT-0005mZ-Pc
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 19:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0ZNC-0005Kc-MC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 19:51:06 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b]:45479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0ZN6-0001mG-6l
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 19:51:06 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id u8so10004297qvj.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=8RovAsyZU2OtDlKeBMT8ZtysbDM/3dFRefy4qLaIJB8=;
 b=H7TFEzBs1GOQ+qJ+qlW9p2D2MgmMp7NWm/bw4W+4w5yRZe10ahkUrO8ZB+ck8XGZw/
 eC6m8JloXX8p9xz+hazlCkNPAs1COIlgiFQ8AibumFMsLDXRSKnoZnSXpipmIS5MKbNL
 SxFeBC3vw82aAl12kEXaC27bEIoZVSO3g1Q0R/c4rTvz9iNz8O7gWayB6RJ3uL7FcuNm
 MaOuRx4slQjxgnmbISOrOKQZ42iKZkW69/WhPc6lP6S+UWIl1xW6bwKu7OTZoxMy3XTv
 ZLOPr4MakSq4z9qfQaniwO+aNEIGJZP5FlfSbZgy2rBVIdtJDj01DPg0YhPcJuS4heAr
 ThwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=8RovAsyZU2OtDlKeBMT8ZtysbDM/3dFRefy4qLaIJB8=;
 b=m/XTSEPw0YmImvTpO7fZSSPEo3cqSOPah9WEjPtqiwTGlcb8hJiJWIegmH3hgBVszk
 t5cfVPeqGu0QPliACpw+5btjMNsMM49y7ILQ+tUe+Hee4Oe4yLe4AIeNlU35704Qsg9U
 t0/8N5XQcHr8auLnVBorFH+nvEXTrZenecCLCRrq1d4twOmqryF8t8sQoZtp8XcR/lGE
 KM1drz4t4k9q4FkDFhgMFds/jQEyK/TioDoqDdU/Er47K+bdvLnc4fy/a9dfEJixmjx1
 y3mJC+zV8tHU4JHlPgllJyBcpkAVAUr0Huk+Ectl9oPojKUUhvHAYgB49yDF2khKW8v7
 cPnA==
X-Gm-Message-State: AOAM530bd04wGNfJ32FJri7t82t2gQe4iwdHsrmGSB70WeeQsTtrzpTv
 XMqnVVsK2C6z0wBV9uKIZ2M=
X-Google-Smtp-Source: ABdhPJwVPbwlYsVoMpMSxU1LhMcH514rslEmlPFT35JuiUVN/d27lKVAI9oVr288IV1ynzL9CGEolQ==
X-Received: by 2002:ad4:4526:: with SMTP id l6mr29413679qvu.16.1595980255728; 
 Tue, 28 Jul 2020 16:50:55 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id q29sm349649qtc.10.2020.07.28.16.50.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 28 Jul 2020 16:50:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <159598024236.15098.9369079990904967180@sif>
Subject: [ANNOUNCE] QEMU 5.1.0-rc2 is now available
Date: Tue, 28 Jul 2020 18:50:42 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=flukshun@gmail.com; helo=mail-qv1-xf2b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
third release candidate for the QEMU 5.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-5.1.0-rc2.tar.xz
  http://download.qemu-project.org/qemu-5.1.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 5.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/5.1

Please add entries to the ChangeLog for the 5.1 release below:

  http://wiki.qemu.org/ChangeLog/5.1

Thank you to everyone involved!

Changes since rc1:

5772f2b1fc: Update version for v5.1.0-rc2 release (Peter Maydell)
12c75e20a2: block/nbd: nbd_co_reconnect_loop(): don't sleep if drained (Vla=
dimir Sementsov-Ogievskiy)
fbeb3e63b3: block/nbd: on shutdown terminate connection attempt (Vladimir S=
ementsov-Ogievskiy)
dd1ec1a4af: block/nbd: allow drain during reconnect attempt (Vladimir Semen=
tsov-Ogievskiy)
fa35591b9c: block/nbd: split nbd_establish_connection out of nbd_client_con=
nect (Vladimir Sementsov-Ogievskiy)
03a970bb6f: iotests: Test convert to qcow2 compressed to NBD (Nir Soffer)
4b914b01cd: iotests: Add more qemu_img helpers (Nir Soffer)
b7719bcad2: iotests: Make qemu_nbd_popen() a contextmanager (Nir Soffer)
a2b333c018: block: nbd: Fix convert qcow2 compressed to nbd (Nir Soffer)
9c15f57891: slirp: update to latest stable-4.2 branch (Marc-Andr=C3=A9 Lure=
au)
297641d43c: test-char: abort on serial test error (Marc-Andr=C3=A9 Lureau)
890cbccb08: nbd: Fix large trim/zero requests (Eric Blake)
afac471b71: iotests/197: Fix for non-qcow2 formats (Max Reitz)
ae159450e1: iotests/028: Add test for cross-base-EOF reads (Max Reitz)
134b7dec6e: block: Fix bdrv_aligned_p*v() for qiov_offset !=3D 0 (Max Reitz)
22dc8663d9: net: forbid the reentrant RX (Jason Wang)
c546ecf27d: virtio-net: check the existence of peer before accessing vDPA c=
onfig (Jason Wang)
a48aaf882b: virtio-pci: fix wrong index in virtio_pci_queue_enabled (Yuri B=
enditovich)
ba620541d0: qga/qapi-schema: Document -1 for invalid PCI address fields (Th=
omas Huth)
3aaebc0cce: qga-win: fix "guest-get-fsinfo" wrong filesystem type (Basil Sa=
lman)
37931e006f: migration: Fix typos in bitmap migration comments (Eric Blake)
fbd1c1b642: iotests: Adjust which migration tests are quick (Eric Blake)
058a08a658: qemu-iotests/199: add source-killed case to bitmaps postcopy (V=
ladimir Sementsov-Ogievskiy)
845b2204c9: qemu-iotests/199: add early shutdown case to bitmaps postcopy (=
Vladimir Sementsov-Ogievskiy)
d4c6fcc01b: qemu-iotests/199: check persistent bitmaps (Vladimir Sementsov-=
Ogievskiy)
48f43820cd: qemu-iotests/199: prepare for new test-cases addition (Vladimir=
 Sementsov-Ogievskiy)
ee64722514: migration/savevm: don't worry if bitmap migration postcopy fail=
ed (Vladimir Sementsov-Ogievskiy)
1499ab0969: migration/block-dirty-bitmap: cancel migration on shutdown (Vla=
dimir Sementsov-Ogievskiy)
b91f33b81d: migration/block-dirty-bitmap: relax error handling in incoming =
part (Vladimir Sementsov-Ogievskiy)
0a47190a00: migration/block-dirty-bitmap: keep bitmap state for all bitmaps=
 (Vladimir Sementsov-Ogievskiy)
f3045b9a82: migration/block-dirty-bitmap: simplify dirty_bitmap_load_comple=
te (Vladimir Sementsov-Ogievskiy)
8949121644: migration/block-dirty-bitmap: rename finish_lock to just lock (=
Vladimir Sementsov-Ogievskiy)
3b52726ec0: migration/block-dirty-bitmap: refactor state global variables (=
Vladimir Sementsov-Ogievskiy)
d0cccbd118: migration/block-dirty-bitmap: move mutex init to dirty_bitmap_m=
ig_init (Vladimir Sementsov-Ogievskiy)
b25d364102: migration/block-dirty-bitmap: rename dirty_bitmap_mig_cleanup (=
Vladimir Sementsov-Ogievskiy)
fbbc6b1470: migration/block-dirty-bitmap: rename state structure types (Vla=
dimir Sementsov-Ogievskiy)
e6ce5e9224: migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_st=
art (Vladimir Sementsov-Ogievskiy)
e80a4150a5: qemu-iotests/199: increase postcopy period (Vladimir Sementsov-=
Ogievskiy)
31e3827913: qemu-iotests/199: change discard patterns (Vladimir Sementsov-O=
gievskiy)
edb90bbdf3: qemu-iotests/199: improve performance: set bitmap by discard (V=
ladimir Sementsov-Ogievskiy)
09feea6cf5: qemu-iotests/199: better catch postcopy time (Vladimir Sementso=
v-Ogievskiy)
f3f483ac63: qemu-iotests/199: drop extra constraints (Vladimir Sementsov-Og=
ievskiy)
8243219fa5: qemu-iotests/199: fix style (Vladimir Sementsov-Ogievskiy)
8098969cf2: qcow2: Fix capitalization of header extension constant. (Andrey=
 Shinkevich)
0f6bb1958f: linux-user: Use getcwd syscall directly (Andreas Schwab)
4d213001b3: linux-user: Fix syscall rt_sigtimedwait() implementation (Filip=
 Bozuta)
c9f8066697: linux-user: Ensure mmap_min_addr is non-zero (Richard Henderson)
0c9753ebda: virtio-pci: fix virtio_pci_queue_enabled() (Laurent Vivier)
d4f6dda182: target/arm: Improve IMPDEF algorithm for IRG (Richard Henderson)
7ad01d78a9: hw/arm/boot: Fix MTE for EL3 direct kernel boot (Richard Hender=
son)
24ac0d309a: hw/arm/boot: Fix PAUTH for EL3 direct kernel boot (Richard Hend=
erson)
222f45b759: docs/system/arm/virt: Document 'mte' machine option (Peter Mayd=
ell)
a6d6f37aed: target/arm: Always pass cacheattr in S1_ptw_translate (Richard =
Henderson)
ca05a240d4: hw/misc/aspeed_sdmc: Fix incorrect memory size (Philippe Mathie=
u-Daud=C3=A9)
4bf7c0cb09: ACPI: Assert that we don't run out of the preallocated memory (=
Dongjiu Geng)
54414d0fb1: Update OpenBIOS images to 7f28286f built from submodule. (Mark =
Cave-Ayland)
1855536256: iotests/197: Fix for compat=3D0.10 (Max Reitz)
d0d89526f7: MAINTAINERS: Cover the firmware JSON schema (Philippe Mathieu-D=
aud=C3=A9)
386494f29e: vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267 (Cindy Lu)
8fe9805c73: libvhost-user: Report descriptor index on panic (Philippe Mathi=
eu-Daud=C3=A9)
4fdecf0543: Fix vhost-user buffer over-read on ram hot-unplug (Raphael Norw=
itz)
2ebc21216f: hw/pci-host: save/restore pci host config register (Hogan Wang)
c22aba1963: virtio-mem-pci: force virtio version 1 (David Hildenbrand)
733dafe491: iotests: Select a default machine for the rx and avr targets (T=
homas Huth)
984c367814: block/amend: Check whether the node exists (Max Reitz)
4a70232b1d: tests/vm: add shutdown timeout in basevm.py (Robert Foley)
80ded8e99d: python/qemu: Change ConsoleSocket to optionally drain socket. (=
Robert Foley)
4b84d87449: python/qemu: Cleanup changes to ConsoleSocket (Robert Foley)
445883885a: linux-user, ppc: fix clock_nanosleep() for linux-user-ppc (Laur=
ent Vivier)
8ec68a0a87: linux-user: fix clock_nanosleep() (Laurent Vivier)
4c5aeb1238: tests/docker: add support for DEB_KEYRING (Alex Benn=C3=A9e)
182ec06076: tests/docker: fix binfmt_misc image building (Alex Benn=C3=A9e)
e336cec3a5: tests/docker: fix update command due to python3 str/bytes disti=
nction (Alex Benn=C3=A9e)
2667e069e7: linux-user: don't use MAP_FIXED in pgd_find_hole_fallback (Alex=
 Benn=C3=A9e)
163b3d1af2: target/i386: floatx80: avoid compound literals in static initia=
lizers (Laszlo Ersek)
c83d628b7f: accel/tcg: better handle memory constrained systems (Alex Benn=
=C3=A9e)
986babaab3: util/oslib-win32: add qemu_get_host_physmem implementation (Ale=
x Benn=C3=A9e)
ad06ef0efb: util: add qemu_get_host_physmem utility function (Alex Benn=C3=
=A9e)
7d2d6522bb: semihosting: don't send the trailing '\0' (KONRAD Frederic)
619985e937: semihosting: defer connect_chardevs a little more to use serial=
x (KONRAD Frederic)
3b6b4997b3: shippable: add one more qemu to registry url (Alex Benn=C3=A9e)
aef92d87c5: pseries: fix kvmppc_set_fwnmi() (Laurent Vivier)
8226a4b88b: python/machine: Change default timeout to 30 seconds (John Snow)
3cb3a7720b: target/i386: Save cc_op before loop insns (Richard Henderson)
79826f99fe: target/hppa: Free some temps in do_sub (Richard Henderson)
570ef3093b: tcg: update comments for save_iotlb_data in cputlb (Alex Benn=
=C3=A9e)
88f8307457: tpm_emulator: Report an error if chardev is missing (Stefan Ber=
ger)
5a6791c3d4: tpm: Improve help on TPM types when none are available (Markus =
Armbruster)
d64072c0ac: Revert "tpm: Clean up error reporting in tpm_init_tpmdev()" (Ma=
rkus Armbruster)
9b52b17ba5: configure: Allow to build tools without pixman (Thomas Huth)
2c9728c0db: hw/input/virtio-input-hid.c: Don't undef CONFIG_CURSES (Peter M=
aydell)
8d942986be: hw: Only compile the usb-dwc2 controller if it is really needed=
 (Thomas Huth)
192cf54ac5: qapi/error: Check format string argument in error_*prepend() (P=
hilippe Mathieu-Daud=C3=A9)
838886378e: sd/milkymist-memcard: Fix format string (Stefan Weil)
ff5b5d5b6d: error: Strip trailing '\n' from error string arguments (again) =
(Markus Armbruster)
cb3fa1e4c0: coccinelle/err-bad-newline: Fix for Python 3, and add patterns =
(Markus Armbruster)
d664548328: s390x/s390-virtio-ccw: fix loadparm property getter (Halil Pasi=
c)
d1bb69db4c: s390x/protvirt: allow to IPL secure guests with -no-reboot (Chr=
istian Borntraeger)
0baa4b445e: KVM: fix CPU reset wrt HF2_GIF_MASK (Vitaly Kuznetsov)
8ba26b0b2b: target/riscv: Fix the range of pmpcfg of CSR funcion table (Zon=
g Li)
e79d27cb32: hw/riscv: sifive_e: Correct debug block size (Bin Meng)
3e09396e36: target/riscv: fix vector index load/store constraints (LIU Zhiw=
ei)
eabfeb0cb9: target/riscv: Quiet Coverity complains about vamo* (LIU Zhiwei)
8380b3a453: goldfish_rtc: Fix non-atomic read behaviour of TIME_LOW/TIME_HI=
GH (Jessica Clarke)
ccec7e9603: virtio-pci: Changed vdev to proxy for VirtIO PCI BAR callbacks.=
 (Andrew Melnychenko)
a4544c45e1: intel_iommu: Use correct shift for 256 bits qi descriptor (Liu =
Yi L)
9b3a35ec82: virtio: verify that legacy support is not accidentally on (Corn=
elia Huck)
7c78bdd7a3: virtio: list legacy-capable devices (Cornelia Huck)
3219b42f02: virtio-balloon: Replace free page hinting references to 'report=
' with 'hint' (Alexander Duyck)
1a83e0b9c4: virtio-balloon: Add locking to prevent possible race when start=
ing hinting (Alexander Duyck)
20a4da0f23: virtio-balloon: Prevent guest from starting a report when we di=
dn't request one (Alexander Duyck)
cf4e3d000e: virtio: Drop broken and superfluous object_property_set_link() =
(Markus Armbruster)
dba04c3488: acpi: accept byte and word access to core ACPI registers (Micha=
el Tokarev)
029afc4e76: qdev: Fix device_add DRIVER,help to print to monitor (Markus Ar=
mbruster)
077195187b: hw/nvram/fw_cfg: Let fw_cfg_add_from_generator() return boolean=
 value (Philippe Mathieu-Daud=C3=A9)
a3ad58342a: hw/nvram/fw_cfg: Simplify fw_cfg_add_from_generator() error pro=
pagation (Philippe Mathieu-Daud=C3=A9)
5e29521a82: hw/avr/boot: Fix memory leak in avr_load_firmware() (Philippe M=
athieu-Daud=C3=A9)
b6c61f6934: qemu-common: Document qemu_find_file() (Philippe Mathieu-Daud=
=C3=A9)
d450cccc9a: qemu/osdep: Reword qemu_get_exec_dir() documentation (Philippe =
Mathieu-Daud=C3=A9)
7da1d7dcc0: qemu/osdep: Document os_find_datadir() return value (Philippe M=
athieu-Daud=C3=A9)


