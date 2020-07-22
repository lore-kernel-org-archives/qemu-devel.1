Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65930C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 00:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3148F20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 00:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENk12no1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3148F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy30j-0003yw-Ez
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 20:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jy2zs-0003Vd-My
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 20:52:36 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:43543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jy2zq-0000aP-Bq
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 20:52:36 -0400
Received: by mail-oo1-xc41.google.com with SMTP id t12so91301ooc.10
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 17:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=2KXezpPilin8a5OYzUmdcvSm0cTapbrbrX4sl1X9Dpo=;
 b=ENk12no1WlfYCGM7zML++rZtu4VhLmuz6VIDqknS+sIQBh0KCT2j2wmKt1UPVrVIs0
 cpsJGgxDHMZVcJv29hL0Mn3PD3TZnFU7dkEVsZFIqZvuPFn8Sfe5f+e/vghbpbRdfbT1
 vGtNWTYjcAfQnqNM6/LyNj0G6yuog+CjrgC8lobOL7EJJ8vjhv3CwBZNKfg9z4NU46KY
 jWrC3C5lWFf5V6O1LzVGOxsfor9iRZgtdskIvqfF4AoHXuxF41nyFJV28Tzd0Gi+91PO
 wFo1hW8yEx4a4QBCv7wh5BnxyEbwvodD7pZ1OOsnTuybWDQ6gwV2/vb5uNAhp5w/n4cD
 XtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=2KXezpPilin8a5OYzUmdcvSm0cTapbrbrX4sl1X9Dpo=;
 b=NFq8NM2gn7fB9bpgkh6f+pkZyKn0353SrYJINPKxcc1Ghx32NRfCSNtefunGW+mYXw
 o08+2j6DuxW3dK9ofASUof7EAb3d4FN7UZpL6FjsB4tW9OtVJr8Y1Z3vOcZA7b9+5E8W
 jnF18xsoTmTYtxwJ8rohasWjHn8YCztHqpKTTn5DmdwMdht9mbA8GqGHy32uQOjqeJLb
 V7v6oJHOfeKxpW7t8Yk3SlogwZ32ZeRaK8F+j/XDlvm0x8vv6aWXV3DMY/2DH7tEs214
 ULaYWfqEZ9veq6bJkQdAFisWtVPBNC2sTVQnIhq9x9ok60YX2WQssnTW7b9Ifm23XFl0
 MwxQ==
X-Gm-Message-State: AOAM531m0XGcfpdmRSAeLNTNGgjQNh6vEcIN4M00yQ85GVdahMHXHmXT
 rSMbsT1cJGs5JiPRA0d26XI=
X-Google-Smtp-Source: ABdhPJyc2MO/kF5tk7zjz6Ne4g/rVt0IFlobo4T7aU06XVWJWDjVvtqng/n+vQdoIw/0hTJa6/e4ow==
X-Received: by 2002:a05:6820:1051:: with SMTP id
 x17mr26331895oot.44.1595379152375; 
 Tue, 21 Jul 2020 17:52:32 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id d10sm5036122oia.18.2020.07.21.17.52.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 21 Jul 2020 17:52:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <159537914509.15440.6638263944433654743@sif>
Subject: [ANNOUNCE] QEMU 5.1.0-rc1 is now available
Date: Tue, 21 Jul 2020 19:52:25 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc41.google.com
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
second release candidate for the QEMU 5.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-5.1.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-5.1.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 5.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/5.1

Please add entries to the ChangeLog for the 5.1 release below:

  http://wiki.qemu.org/ChangeLog/5.1

Thank you to everyone involved!

Changes since rc0:

c8004fe6bb: Update version for v5.1.0-rc1 release (Peter Maydell)
4a01e27ddc: iotests: Test sparseness for qemu-img convert -n (Kevin Wolf)
0dde9fd12f: qom: Make info qom-tree sort children more efficiently (Markus =
Armbruster)
61b3043965: qcow2: Implement v2 zero writes with discard if possible (Kevin=
 Wolf)
bae127d4dc: file-posix: Handle `EINVAL` fallocate return value (Antoine Dam=
het)
5bd929d2ff: qom: Document object_get_canonical_path() returns malloced stri=
ng (Markus Armbruster)
7a309cc95b: qom: Change object_get_canonical_path_component() not to malloc=
 (Markus Armbruster)
5519724a13: hw/net/xgmac: Fix buffer overflow in xgmac_enet_send() (Mauro M=
atteo Cascella)
e219d30910: hw/net: Added plen fix for IPv6 (Andrew)
cbf97d5b79: qapi: Fix visit_type_STRUCT() not to fail for null object (Mark=
us Armbruster)
1d719ddc35: block: fix bdrv_aio_cancel() for ENOMEDIUM requests (Stefan Haj=
noczi)
d87350b065: module: ignore NULL type (Gerd Hoffmann)
d97df4b84b: qxl: fix modular builds with dtrace (Gerd Hoffmann)
8e67fda2dd: xhci: fix valid.max_access_size to access address registers (La=
urent Vivier)
0fca43de1b: qemu-iotests: add testcase for bz #1857490 (Maxim Levitsky)
662d0c5392: block/crypto: disallow write sharing by default (Maxim Levitsky)
7ad36e2e24: hw: Mark nd_table[] misuse in realize methods FIXME (Markus Arm=
bruster)
2b0650205b: msf2: Unbreak device-list-properties for "msf-soc" (Markus Armb=
ruster)
6184e5fb42: MAINTAINERS: Extend the device fuzzing section (Thomas Huth)
09a14f586c: docs/fuzz: add instructions for generating a coverage report (A=
lexander Bulekov)
19a91e4af8: docs/fuzz: add information about useful libFuzzer flags (Alexan=
der Bulekov)
ee16da12d7: docs/fuzz: describe building fuzzers with enable-sanitizers (Al=
exander Bulekov)
dd0162653c: fuzz: build without AddressSanitizer, by default (Alexander Bul=
ekov)
48eac10197: gitlab-ci.yml: Add oss-fuzz build tests (Alexander Bulekov)
bcbad8b05c: fuzz: Fix leak when assembling datadir path string (Alexander B=
ulekov)
7cee363bc2: scripts/oss-fuzz: Limit target list to i386-softmmu (Thomas Hut=
h)
6a0b7505f1: docs/system: Document the arm virt board (Peter Maydell)
bb309000c8: docs/system: Briefly document gumstix boards (Peter Maydell)
b76b60f59b: docs/system: Briefly document collie board (Peter Maydell)
2d21dd17c5: docs/system: Briefly document canon-a1100 board (Peter Maydell)
3f410039b7: hw/arm/armsse: Assert info->num_cpus is in-bounds in armsse_rea=
lize() (Peter Maydell)
cd07d7f9f5: qdev: Document GPIO related functions (Peter Maydell)
46ea1be1ee: qdev: Document qdev_unrealize() (Peter Maydell)
b51238e251: qdev: Move doc comments from qdev.c to qdev-core.h (Peter Mayde=
ll)
8edbca515c: util: Implement qemu_get_thread_id() for OpenBSD (David CARLIER)
19bd6aafbd: hw/arm/virt: Disable memory hotplug when MTE is enabled (Richar=
d Henderson)
7f6185ed9c: hw/arm/virt: Error for MTE enabled with KVM (Richard Henderson)
6f4e1405b9: hw/arm/virt: Enable MTE via a machine property (Richard Henders=
on)
d69cda7ed7: Makefile: Remove config-devices.mak on "make clean" (Peter Mayd=
ell)
b25fbd6a13: pseries: Update SLOF firmware image (Alexey Kardashevskiy)
a6030d7e0b: spapr: Add a new level of NUMA for GPUs (Reza Arbab)
a4beb5f5d4: spapr_pci: Robustify support of PCI bridges (Greg Kurz)
14de3d4ac5: ppc/pnv: Make PSI device types not user creatable (Greg Kurz)
ba3c35d9c4: tcg/cpu-exec: precise single-stepping after an interrupt (Richa=
rd Henderson)
e3f7320caa: ipmi: add SET_SENSOR_READING command (C=C3=A9dric Le Goater)
789101b73d: ipmi: Fix a man page entry (Corey Minyard)
323679da77: ipmi: Add man page pieces for the IPMI PCI devices (Corey Minya=
rd)
7cb015197b: migration/block-dirty-bitmap: fix add_bitmaps_to_list (Vladimir=
 Sementsov-Ogievskiy)
a8c5cf27c9: file-posix: Fix leaked fd in raw_open_common() error path (Kevi=
n Wolf)
bca5283bd4: file-posix: Fix check_hdev_writable() with auto-read-only (Kevi=
n Wolf)
20eaf1bf6e: file-posix: Move check_hdev_writable() up (Kevin Wolf)
5edc85571e: file-posix: Allow byte-aligned O_DIRECT with NFS (Kevin Wolf)
9c60a5d197: block: Require aligned image size to avoid assertion failure (K=
evin Wolf)
d047cfa78d: iotests: test shutdown when bitmap is exported through NBD (Vla=
dimir Sementsov-Ogievskiy)
453cc6be0a: nbd: make nbd_export_close_all() synchronous (Vladimir Sementso=
v-Ogievskiy)
f21f12936f: iotests/030: Reduce job speed to make race less likely (Kevin W=
olf)
3e018afbfe: crypto: use a stronger private key for tests (Daniel P. Berrang=
=C3=A9)
1c404d756f: qemu-img resize: Require --shrink for shrinking all image forma=
ts (Kevin Wolf)
a08464521c: Remove VXHS block device (Marc-Andr=C3=A9 Lureau)
4b7c5bc447: vvfat: set status to odd fixes (Prasad J Pandit)
9ece07d7a3: docs/s390x: fix vfio-ccw type (Cornelia Huck)
b610eba335: gitlab-ci.yml: Add fuzzer tests (Thomas Huth)
ab2d185d6b: qom: Plug memory leak in "info qom-tree" (Markus Armbruster)
12a9b8d824: configure: Fix for running with --enable-werror on macOS (Thoma=
s Huth)
f5ec79f5e0: fuzz: Expect the cmdline in a freeable GString (Alexander Bulek=
ov)
15c51f724e: tests: qmp-cmd-test: fix memory leak (Li Qiang)
82e258db15: qtest: bios-tables-test: fix a memory leak (Li Qiang)
a7ba744f40: tcg/cpu-exec: precise single-stepping after an exception (Luc M=
ichel)
69c918d2ef: tcg: Save/restore vecop_list around minmax fallback (Richard He=
nderson)
818b9f111d: i386: hvf: Explicitly set CR4 guest/host mask (Roman Bolshakov)
73d5f22ecb: hw/i2c: Document the I2C qdev helpers (Philippe Mathieu-Daud=C3=
=A9)
1373b15bb5: hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple() =
(Philippe Mathieu-Daud=C3=A9)
2616f57231: hw/i2c: Rename i2c_realize_and_unref() as i2c_slave_realize_and=
_unref() (Philippe Mathieu-Daud=C3=A9)
db437ca6df: hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new() (Phili=
ppe Mathieu-Daud=C3=A9)
7a204cbdc2: hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus() (Philippe Math=
ieu-Daud=C3=A9)
ae163b8d95: hw/i2c/Kconfig: Add an entry for the SMBus (Philippe Mathieu-Da=
ud=C3=A9)
644e3c5d81: target/i386: add the missing vmx features for Skylake-Server an=
d Cascadelake-Server CPU models (Chenyi Qiang)
e0013791b9: target/i386: fix model number and add missing features for Icel=
ake-Server CPU model (Chenyi Qiang)
5cb287d2bd: target/i386: add fast short REP MOV support (Chenyi Qiang)
f9f08e7cae: i386/cpu: Don't add unavailable_features to env->user_features =
(Xiaoyao Li)
1f43671a0d: i368/cpu: Clear env->user_features after loading versioned CPU =
model (Xiaoyao Li)
4084e35068: usb: fix storage regression (Gerd Hoffmann)
8ec1415935: vfio: fix use-after-free in display (Gerd Hoffmann)
df8a756893: tests: tpm: Skip over pcrUpdateCounter byte in result compariso=
n (Stefan Berger)
f8b332a1ff: tpm: tpm_spapr: Exit on TPM backend failures (Stefan Berger)
a134321ef6: ftgmac100: fix dblac write test (erik-smit)
e7b347d0bf: net: detect errors from probing vnet hdr flag for TAP devices (=
Daniel P. Berrange)
894022e616: net: check if the file descriptor is valid before using it (Lau=
rent Vivier)
2b28a7ef90: qemu-options.hx: Clean up and fix typo for colo-compare (Zhang =
Chen)
a2e5cb7a87: net/colo-compare.c: Expose compare "max_queue_size" to users (Z=
hang Chen)
9a8d949245: hw/net: Added CSO for IPv6 (Andrew)
650181007a: virtio-net: fix removal of failover device (Juan Quintela)

