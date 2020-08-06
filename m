Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E2420748
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+J18Z8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E2420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mQb-00029F-Ar
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k3lgJ-0002CK-U4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:36:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k3lgG-0000Kb-Is
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596742559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=61dXXeIZyWh05cG6QSGRLvDM75uMqy1Ob2hy0stJ0MA=;
 b=R+J18Z8a3s1U8jChetZ1kvsOrNpU7k+tJqn9tGkEn0q9nAqQhlECeIJ5fwYhzEVwI2scAd
 nx1r5SJiccdKdPxCcWloSmgwmrvt4jB1jvrJVNh2/PRmOVqguq8BYdpx9ne0L3Tyxeyqmo
 z5WcftKl205+8c32LoFczrJ3LuklFgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-p2oAekvDM7uNDCV40wZFDA-1; Thu, 06 Aug 2020 15:35:56 -0400
X-MC-Unique: p2oAekvDM7uNDCV40wZFDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB9AF800688;
 Thu,  6 Aug 2020 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-202.rdu2.redhat.com
 [10.10.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C8B01001B2B;
 Thu,  6 Aug 2020 19:35:54 +0000 (UTC)
Date: Thu, 6 Aug 2020 15:35:53 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Acceptance Test BootLinuxAarch64.test_virt_tcg execution times
Message-ID: <20200806193553.GA1463846@localhost.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

TL;DR: This is a followup from an IRC chat about the
tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg test
taking many orders of magnitute longer than other acceptance (and even
similar boot) tests.  I could not find an easy way for this specific
test (aarch64+tcg) to have a significant execution time improvement.
The best solution may be to filter out tests that are known to be
slow, and create a specific "test job" that includes them.

Fisrt, if it's not clear, this specific test runs QEMU with TCG and
boots a Fedora 31 "cloud image" and waits until the cloud-init agent
notifies the test that the boot is over.

Out of the four archtiectures tested with the same approach under
"tests/acceptance/boot_linux.py", aarch64 was special, in the sense
that many Linux "cloud images" got stuck very late in the boot
process.  What seemed to be a disk activity within the guest that
seemed to make the kernel drain its random number sources if my memory
serves me right.  Giving the machine a RNG device fixed it.  This can
still be verified Today if you comment the virtio-rng lines in the
aarch64 test.

So, even with the RNG device and the boot process not getting stuck, a
lot of the test time is spent with QEMU actively using CPU time
produced by the guest boot process.  This may or may not be the cause
for the slowness.

One approach to have a shorter test time, would be to reduce the
things that happen during the guest boot process.  Choosing a minimal
guest, such as CirrOS, would be an example of such a solution, but:

* With less things happening during the guest boot, less things
  get tested within QEMU;

* CirrOS can not make use of the same boot cloud-init configuration
  and boot verification the test currently uses;

So that leaves other non-minimal Linux "cloud images" as options.  But
still, the following things are required or nice to have:

* Support for cloud-init;

* Support for as many as possible architectures;

* Wide user base;

* Be thoroughly tested with this "boot_linux.py" test

So in the end, I picked Fedora 31, which was available and behaved
well for four different architectures with and without KVM. Today, I
verified if switching distros would provide an "easy fix", but the
results were negative.  Any ideas on how to improve the test execution
times are appreciated.

For the record, one of the ways we're trying to improve the overall
test experience is to allow tests to run in parallel (expected to be
fully supported on the upcoming version 81.0).

For those interested, these are the numbers I got, and how I tested
with other distros.  I'm using QEMU e1d322c405 with a vanilla
configure under a x86_64 Fedora 32 host.

Fedora 31 (baseline):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  $ make check-venv
  $ ./tests/venv/bin/avocado run -t arch:aarch64,accel:tcg --keep-tmp on --=
 tests/acceptance/boot_linux.py{,,,,}
  JOB ID     : 14802f9d5016a44d2937ed7b1fec63b2eaa06e89
  JOB LOG    : /home/cleber/avocado/job-results/job-2020-08-06T13.19-14802f=
9/job.log
   (1/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (153.12 s)
   (2/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (149.57 s)
   (3/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (154.45 s)
   (4/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (148.97 s)
   (5/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (150.70 s)
  RESULTS    : PASS 5 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 757.50 s

Fedora 32:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Tweak version and image hash:

---
diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.p=
y
index 0055dc7cee..44c62bd4a2 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -48,7 +48,7 @@ class BootLinuxBase(Test):
             image_arch =3D 'ppc64le'
         try:
             boot =3D vmimage.get(
-                'fedora', arch=3Dimage_arch, version=3D'31',
+                'fedora', arch=3Dimage_arch, version=3D'32',
                 checksum=3Dself.chksum,
                 algorithm=3D'sha256',
                 cache_dir=3Dself.cache_dirs[0],
@@ -160,7 +160,7 @@ class BootLinuxAarch64(BootLinux):
     :avocado: tags=3Dmachine:gic-version=3D2
     """
=20
-    chksum =3D '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf=
16fe49'
+    chksum =3D 'b367755c664a2d7a26955bbfff985855adfa2ca15e908baf15b4b176d6=
8d3967'
=20
     def add_common_args(self):
         self.vm.add_args('-bios',
---

2. Download the image before the test:

  $ ./tests/venv/bin/avocado vmimage get --distro=3Dfedora --arch aarch64 -=
-distro-version=3D32
  The image was downloaded:
  Provider Version Architecture File
  fedora   32      aarch64      /tmp/data/cache/by_location/7049001631a4b2e=
abf5766cc110e66d486e09821/Fedora-Cloud-Base-32-1.6.aarch64.qcow2

3. Run the tests:

  $ ./tests/venv/bin/avocado run -t arch:aarch64,accel:tcg --keep-tmp on --=
 tests/acceptance/boot_linux.py{,,,,}
JOB ID     : 09e740a41dc400f9fcbb9253f613734597fe0efc
JOB LOG    : /home/cleber/avocado/job-results/job-2020-08-06T13.53-09e740a/=
job.log
 (1/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS =
(162.06 s)
 (2/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS =
(167.78 s)
 (3/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS =
(166.98 s)
 (4/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS =
(171.13 s)
 (5/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS =
(167.43 s)
RESULTS    : PASS 5 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CA=
NCEL 0
JOB TIME   : 836.05 s

Ubuntu 20.04:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Tweak version and image hash:

---
diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.p=
y
index 0055dc7cee..03c0e1bee9 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -48,7 +48,7 @@ class BootLinuxBase(Test):
             image_arch =3D 'ppc64le'
         try:
             boot =3D vmimage.get(
-                'fedora', arch=3Dimage_arch, version=3D'31',
+                'ubuntu', arch=3Dimage_arch, version=3D'20.04',
                 checksum=3Dself.chksum,
                 algorithm=3D'sha256',
                 cache_dir=3Dself.cache_dirs[0],
@@ -160,7 +160,7 @@ class BootLinuxAarch64(BootLinux):
     :avocado: tags=3Dmachine:gic-version=3D2
     """
=20
-    chksum =3D '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf=
16fe49'
+    chksum =3D '1d9e50f3381145835b11911adf611f455d674a570814086b7d6581ecc0=
718770'
=20
     def add_common_args(self):
         self.vm.add_args('-bios',
---

2. Download the image before the test:

  $ ./tests/venv/bin/avocado vmimage get --distro=3Dubuntu --arch aarch64 -=
-distro-version=3D20.04
  The image was downloaded:
  Provider Version Architecture File
  ubuntu   20.04   arm64        /tmp/data/cache/by_location/19db8c6d910a3f2=
660c4109ffb85d73d43e5cdf2/ubuntu-20.04-server-cloudimg-arm64.img

3. Run the tests:

  $ ./tests/venv/bin/avocado run -t arch:aarch64,accel:tcg --keep-tmp on --=
 tests/acceptance/boot_linux.py{,,,,}
  JOB ID     : 92a1bdbb5e933e6dff8b882808a191f1de3c2600
  JOB LOG    : /home/cleber/avocado/job-results/job-2020-08-06T12.13-92a1bd=
b/job.log
   (1/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (341.40 s)
   (2/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (345.82 s)
   (3/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (335.91 s)
   (4/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (320.32 s)
   (5/5) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PAS=
S (319.79 s)
  RESULTS    : PASS 5 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 1663.92 s

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8sW5QACgkQZX6NM6Xy
CfN35xAAgz/pNB7NThCWslIt7+FJyCD0ycg3elcHoOGT9t655yv+zdft5sytmvC0
SKkHsqxc/OIHWfESJxIPDzHOiBYlhG28Fl2Lnt8SfBBz1r4jWuOqjxkh6vsYkCOW
obeVkPKK1UFuL+TFp0L0wFkiptpr1ZoMuzJETyCwcdmg/iD0j9nR5+uDfYqCqpU9
/I6XipbH34xIBMBTyr4bErlF5GUYUgARh/LHZoZA8CLg6HGXrlolNIknP09OP1BT
P37ET+DfrnOQLylYzhxKF3L2PDwdjq7niZQmaAqESBgqzGJ8N5H57mwglo4I+NVU
guXurQyif8A/D13WAzE2Rs8AjH3Xvr7pXas7uySbAzcRdvPt9bG5ob4o7WUM4ip9
I7MaNn8P8pv+ePeyreVd2FEPUcT7BX7OlHLbBuWHzswLJbexV9ChygbXWbIAVCKw
6VM8NCsOw/msw84khIvSbDRSRaU/YSzG6R+NXaWcsvUVudhWJhffmTqP4a4Xr3kk
ABEdAuUoJeTL4IIoeFunrLxhNa1zlFq6IlKd+Md3I6VWlMEbvcWcUjoe4TpCY8w9
GLIOMgNSvWea+yQjBE0w4VzbaGytCFr2H9sQJra/3tJx7RP2KCmfeKfrswSFQnpL
7bCJ3u/VOfaEo7t3cCwoJh4VueDMAaKxxtW8jQcQdddk5uzYjcM=
=AIw8
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--


