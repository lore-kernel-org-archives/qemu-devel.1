Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36916C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0801F217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0801F217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i354W-0001Au-OT
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 17:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i351L-00080U-DY
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i351J-0003tq-Or
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:58:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i351J-0003rs-Fw
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:58:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2D3C44BD7;
 Wed, 28 Aug 2019 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-242.rdu2.redhat.com
 [10.10.123.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1D82600CD;
 Wed, 28 Aug 2019 20:58:16 +0000 (UTC)
Date: Wed, 28 Aug 2019 16:58:14 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Message-ID: <20190828205749.GA11512@localhost.localdomain>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564760158-27536-2-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564760158-27536-2-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 28 Aug 2019 20:58:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/acceptance: Refactor and improve
 reporting in linux_ssh_mips_malta.py
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
Cc: cohuck@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 02, 2019 at 05:35:57PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This patch restructures code organization around the test case
> executions. At the same time, rather than outputing a cryptic message:
> 
> FAIL: True not found in [False],
> 
> the following will be reported too, if the command output does not meet
> specified expectations:
> 
> 'lspci -d 11ab:4620' output doesn't contain the word 'GT-64120'
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  tests/acceptance/linux_ssh_mips_malta.py | 36 +++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
> index aafb0c3..8368e1f 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -145,27 +145,33 @@ class LinuxSSH(Test):
>          self.ssh_disconnect_vm()
>          self.wait_for_console_pattern('Power down')
>  
> -    def run_common_commands(self):
> -        stdout, stderr = self.ssh_command('lspci -d 11ab:4620')
> -        self.assertIn(True, ["GT-64120" in line for line in stdout])
> -
> -        stdout, stderr = self.ssh_command('cat /sys/bus/i2c/devices/i2c-0/name')
> -        self.assertIn(True, ["SMBus PIIX4 adapter" in line
> -                             for line in stdout])
> -
> -        stdout, stderr = self.ssh_command('cat /proc/mtd')
> -        self.assertIn(True, ["YAMON" in line
> -                             for line in stdout])
> +    def ssh_command_output_contains(self, cmd, exp):
> +        stdout, _ = self.ssh_command(cmd)
> +        for line in stdout:
> +            if exp in line:
> +                break
> +        else:
> +            self.fail('"%s" output does not contain "%s"' % (cmd, exp))
>  
> +    def run_common_commands(self):
> +        self.ssh_command_output_contains(
> +            'lspci -d 11ab:4620',
> +            'GT-64120')
> +        self.ssh_command_output_contains(
> +            'cat /sys/bus/i2c/devices/i2c-0/name',
> +            'SMBus PIIX4 adapter')
> +        self.ssh_command_output_contains(
> +            'cat /proc/mtd',
> +            'YAMON')
>          # Empty 'Board Config'
> -        stdout, stderr = self.ssh_command('md5sum /dev/mtd2ro')
> -        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in line
> -                             for line in stdout])
> +        self.ssh_command_output_contains(
> +            'md5sum /dev/mtd2ro',
> +            '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
>  
>      def do_test_mips_malta(self, endianess, kernel_path, uname_m):
>          self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_path)
>  
> -        stdout, stderr = self.ssh_command('uname -a')
> +        stdout, _ = self.ssh_command('uname -a')
>          self.assertIn(True, [uname_m + " GNU/Linux" in line for line in stdout])

This should also make use of ssh_command_output_contains(), that is:

        self.ssh_command_output_contains('uname -a',
                                         uname_m + " GNU/Linux")

Other than that, it LGTM.

- Cleber.

>  
>          self.run_common_commands()
> -- 
> 2.7.4
> 

