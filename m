Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB64CC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CD220658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaVx+non"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CD220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izonK-00019c-FU
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoaJ-0008S2-E6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoaF-00049z-9Z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47448
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoaD-0003qz-Hx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AX7+KHHxDeVNAZAkl2ahELkkJcrkwDuEWZLArNAoVR4=;
 b=AaVx+nonzY6Ou82sSSqHMjEqVGoL/VoXM44LkCS9IAr9jV142VHI1Ruo+KxpuMQ4JE3Upj
 q7veeC3BARFkbUbUCbPKFzTrWiJr53210l+Bx90kGcsNuhJ21IGWOJRe8uiMyuEYw7DHUE
 qvOf9UMEzi9GAuVb9gdKR1833Lf7zWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-DR8CGrnhOiOcWPt22VdlEQ-1; Thu, 06 Feb 2020 16:21:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D4142F61;
 Thu,  6 Feb 2020 21:21:01 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 059C460BEC;
 Thu,  6 Feb 2020 21:20:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/46] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
Date: Thu,  6 Feb 2020 22:19:07 +0100
Message-Id: <20200206211936.17098-18-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DR8CGrnhOiOcWPt22VdlEQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The 2018 edition of the QEMU advent calendar 2018 featured Linux images
for various non-x86 machines. We can use them for a boot tests in our
acceptance test suite.

Let's also make sure that we build the corresponding machines in Travis.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200124170325.30072-1-thuth@redhat.com>
[PMD: Rebased, --python=3Dpython3 parameter dropped in commit 5311cb12e]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 96 ++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 54e1d12762..5887055951 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -313,7 +313,7 @@ matrix:
     # Acceptance (Functional) tests
     - name: "GCC check-acceptance"
       env:
-        - CONFIG=3D"--target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-s=
oftmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,=
ppc64-softmmu,m68k-softmmu,sparc-softmmu"
+        - CONFIG=3D"--target-list=3Daarch64-softmmu,alpha-softmmu,arm-soft=
mmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-sof=
tmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86=
_64-softmmu,xtensa-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       after_script:
         - python3 -c 'import json; r =3D json.load(open("tests/results/lat=
est/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"=
] not in ("PASS", "SKIP")]' | xargs cat
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index a6191ee410..a6ce917e45 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -590,3 +590,99 @@ class BootLinuxConsole(Test):
         self.wait_for_console_pattern(console_pattern)
         console_pattern =3D 'No filesystem could mount root'
         self.wait_for_console_pattern(console_pattern)
+
+    def do_test_advcal_2018(self, day, tar_hash, kernel_name):
+        tar_url =3D ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day' + day + '.tar.xz')
+        file_path =3D self.fetch_asset(tar_url, asset_hash=3Dtar_hash)
+        archive.extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel',
+                         self.workdir + '/day' + day + '/' + kernel_name)
+        self.vm.launch()
+        self.wait_for_console_pattern('QEMU advent calendar')
+
+    def test_arm_vexpressa9(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:vexpress-a9
+        """
+        tar_hash =3D '32b7677ce8b6f1471fb0059865f451169934245b'
+        self.vm.add_args('-dtb', self.workdir + '/day16/vexpress-v2p-ca9.d=
tb')
+        self.do_test_advcal_2018('16', tar_hash, 'winter.zImage')
+
+    def test_m68k_mcf5208evb(self):
+        """
+        :avocado: tags=3Darch:m68k
+        :avocado: tags=3Dmachine:mcf5208evb
+        """
+        tar_hash =3D 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
+        self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
+
+    def test_microblaze_s3adsp1800(self):
+        """
+        :avocado: tags=3Darch:microblaze
+        :avocado: tags=3Dmachine:petalogix-s3adsp1800
+        """
+        tar_hash =3D '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
+        self.do_test_advcal_2018('17', tar_hash, 'ballerina.bin')
+
+    def test_or1k_sim(self):
+        """
+        :avocado: tags=3Darch:or1k
+        :avocado: tags=3Dmachine:or1k-sim
+        """
+        tar_hash =3D '20334cdaf386108c530ff0badaecc955693027dd'
+        self.do_test_advcal_2018('20', tar_hash, 'vmlinux')
+
+    def test_nios2_10m50(self):
+        """
+        :avocado: tags=3Darch:nios2
+        :avocado: tags=3Dmachine:10m50-ghrd
+        """
+        tar_hash =3D 'e4251141726c412ac0407c5a6bceefbbff018918'
+        self.do_test_advcal_2018('14', tar_hash, 'vmlinux.elf')
+
+    def test_ppc64_e500(self):
+        """
+        :avocado: tags=3Darch:ppc64
+        :avocado: tags=3Dmachine:ppce500
+        """
+        tar_hash =3D '6951d86d644b302898da2fd701739c9406527fe1'
+        self.vm.add_args('-cpu', 'e5500')
+        self.do_test_advcal_2018('19', tar_hash, 'uImage')
+
+    def test_ppc_g3beige(self):
+        """
+        :avocado: tags=3Darch:ppc
+        :avocado: tags=3Dmachine:g3beige
+        """
+        tar_hash =3D 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
+        self.vm.add_args('-M', 'graphics=3Doff')
+        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
+
+    def test_ppc_mac99(self):
+        """
+        :avocado: tags=3Darch:ppc
+        :avocado: tags=3Dmachine:mac99
+        """
+        tar_hash =3D 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
+        self.vm.add_args('-M', 'graphics=3Doff')
+        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
+
+    def test_sparc_ss20(self):
+        """
+        :avocado: tags=3Darch:sparc
+        :avocado: tags=3Dmachine:SS-20
+        """
+        tar_hash =3D 'b18550d5d61c7615d989a06edace051017726a9f'
+        self.do_test_advcal_2018('11', tar_hash, 'zImage.elf')
+
+    def test_xtensa_lx60(self):
+        """
+        :avocado: tags=3Darch:xtensa
+        :avocado: tags=3Dmachine:lx60
+        """
+        tar_hash =3D '49e88d9933742f0164b60839886c9739cb7a0d34'
+        self.vm.add_args('-cpu', 'dc233c')
+        self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.elf')
--=20
2.21.1


