Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A1C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38647208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38647208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJJx-00081O-H5
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57633)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hlJ81-0002Aa-Of
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hlJ80-0003Tb-87
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hlJ7z-0003Lv-Tb
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16260C04AC70;
 Wed, 10 Jul 2019 20:23:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-95.rdu2.redhat.com
 [10.10.125.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00E3E60A97;
 Wed, 10 Jul 2019 20:23:42 +0000 (UTC)
Date: Wed, 10 Jul 2019 16:23:41 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Message-ID: <20190710202316.GA27117@localhost.localdomain>
References: <1562781026-27570-1-git-send-email-chihmin.chao@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562781026-27570-1-git-send-email-chihmin.chao@sifive.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 10 Jul 2019 20:23:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/boot_linux_console: add a test for
 riscv64 + virt
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 10, 2019 at 10:50:23AM -0700, Chih-Min Chao wrote:
> Similar to the mips + malta test, it boots a Linux kernel on a virt
> board and verify the serial is working.  Also, it relies on the serial
> device set by the machine itself.
> 
> If riscv64 is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:riscv64" tags.
> 
> Alternatively, this test can be run using:
> 
>   $ avocado run -t arch:riscv64 tests/acceptance
> 
> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> ---
>  tests/acceptance/boot_linux_console.py | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 3215950..bbc6b06 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -354,3 +354,43 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_riscv64_virt(self):
> +        """
> +        :avocado: tags=arch:riscv64
> +        :avocado: tags=machine:virt
> +        """
> +
> +        kernel_url = ('https://github.com/chihminchao/test-binary/raw/'
> +                      '0b7787305d9e40815c05a805266cc74ff356239e/qemu/riscv64/'
> +                      'bbl_w_kernel.gz')
> +        kernel_hash = 'c7f6cc7967975ad42dc61ee0535db01c9cbd0968'
> +        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.workdir + "bbl_w_kernel"
> +
> +        with gzip.open(kernel_path_gz, 'rb') as f_in:
> +            with open(kernel_path, 'wb') as f_out:
> +                shutil.copyfileobj(f_in, f_out)

There are currently two patterns for extracting a gzipped file
in this test.  So, this is not a must, but maybe you'd prefer:

---
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index bbc6b0683f..9f819e20e1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -365,12 +365,8 @@ class BootLinuxConsole(Test):
                       '0b7787305d9e40815c05a805266cc74ff356239e/qemu/riscv64/'
                       'bbl_w_kernel.gz')
         kernel_hash = 'c7f6cc7967975ad42dc61ee0535db01c9cbd0968'
-        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        kernel_path = self.workdir + "bbl_w_kernel"
-
-        with gzip.open(kernel_path_gz, 'rb') as f_in:
-            with open(kernel_path, 'wb') as f_out:
-                shutil.copyfileobj(f_in, f_out)
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        uncompressed_kernel = archive.uncompress(kernel_path, self.workdir)
 
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
                       '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
@@ -382,7 +378,7 @@ class BootLinuxConsole(Test):
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
                                + 'console=ttyS0 noreboot')
-        self.vm.add_args('-kernel', kernel_path,
+        self.vm.add_args('-kernel', uncompressed_kernel,
                          '-initrd', initrd_path,
                          '-append', kernel_command_line)
         self.vm.launch()
---

> +
> +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
> +                      'riscv64/rootfs.cpio.gz')
> +        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +
> +        self.vm.set_machine('virt')
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
> +                               + 'console=ttyS0 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot successful.')
> +
> +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
> +                                               'isa')
> +        self.exec_command_and_wait_for_pattern('uname -a',
> +                                               'sifive')
> +        self.exec_command_and_wait_for_pattern('reboot',
> +                                               'reboot: Restarting system')
> -- 
> 2.7.4
> 
> 

It'd be nice to also add riscv64 to the target list in .travis.yaml
"acceptance tests" job.

Regards and many thanks for this contribution!
- Cleber.

