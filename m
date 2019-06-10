Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928DEC4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 23:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628CF20820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 23:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628CF20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50298 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haTep-0004U5-Ew
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 19:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57288)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1haTeD-00041t-Am
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 19:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1haTeC-0000yL-0l
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 19:24:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1haTeB-0000xY-PK
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 19:24:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D374308212A;
 Mon, 10 Jun 2019 23:24:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-202.rdu2.redhat.com
 [10.10.123.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E5BB60A9F;
 Mon, 10 Jun 2019 23:24:11 +0000 (UTC)
Date: Mon, 10 Jun 2019 19:24:09 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Message-ID: <20190610232059.GA30549@localhost.localdomain>
References: <1560196150-30436-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560196150-30436-1-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 10 Jun 2019 23:24:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/acceptance: Improve failure
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
Cc: amarkovic@wavecomp.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 10, 2019 at 09:49:10PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Rather than optputing a cryptic message:
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
>  tests/acceptance/linux_ssh_mips_malta.py | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
> index aafb0c3..cbf1b34 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -147,20 +147,27 @@ class LinuxSSH(Test):
>  
>      def run_common_commands(self):
>          stdout, stderr = self.ssh_command('lspci -d 11ab:4620')
> -        self.assertIn(True, ["GT-64120" in line for line in stdout])
> +        self.assertIn(True, ["GT-64120a" in line for line in stdout],

Looks like there's an extra, unintended, "a" in the expected output, that is,
s/GT-64120a/GT-64120/.

> +                      "'lspci -d 11ab:4620' output doesn't contain "
> +                      "the word 'GT-64120'")
>
>          stdout, stderr = self.ssh_command('cat /sys/bus/i2c/devices/i2c-0/name')
> -        self.assertIn(True, ["SMBus PIIX4 adapter" in line
> -                             for line in stdout])
> +        self.assertIn(True, ["SMBus PIIX4 adaptera" in line

Here too (s/adaptera/adapter/).

> +                             for line in stdout],
> +                      "cat /sys/bus/i2c/devices/i2c-0/name' doesn't contain "
> +                      "the words 'SMBus PIIX4 adapter'")
>  
>          stdout, stderr = self.ssh_command('cat /proc/mtd')
> -        self.assertIn(True, ["YAMON" in line
> -                             for line in stdout])
> +        self.assertIn(True, ["YAMONa" in line

Also here (s/YAMONa/YAMONa/).

> +                             for line in stdout],
> +                      "'cat /proc/mtd' doesn't contain the word 'YAMON'")
>  
>          # Empty 'Board Config'
>          stdout, stderr = self.ssh_command('md5sum /dev/mtd2ro')
> -        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in line
> -                             for line in stdout])
> +        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193a" in line
> +                             for line in stdout],

And finnaly in the hash (s/0dfbe8aa4c20b52e1b8bf3cb6cbdf193a/0dfbe8aa4c20b52e1b8bf3cb6cbdf193/).

> +                      "'md5sum /dev/mtd2ro' doesn't contain "
> +                      "the word '0dfbe8aa4c20b52e1b8bf3cb6cbdf193'")
>  
>      def do_test_mips_malta(self, endianess, kernel_path, uname_m):
>          self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_path)
> -- 
> 2.7.4
> 
> 

With those changes, the tests pass for me.  I'd recommend though:

1) Not related to your patch, but it's good practice to name unused
   variables "_", that is:

   stdout, _ = self.ssh_command('lspci -d 11ab:4620')

2) Avoid repeating the expected content (which lead to the trailing
   "a"s in this patch).  Something like:

   cmd = 'lspci -d 11ab:4620'
   stdout, _ = self.ssh_command(cmd)
   exp = "GT-64120"
   self.assertIn(True, [exp in line for line in stdout],
                 '"%s" output does not contain "%s"' % (cmd, exp))

3) Optionally, create an utility function that would make the check
   more obvious and avoid looping through all lines of the output
   (and creating a list, which a list comprehension will do).  Example:

   def ssh_command_output_contains(self, cmd, exp):
       stdout, _ = self.ssh_command(cmd)
       for line in stdout:
           if exp in line:
               break
       else:
           self.fail('"%s" output does not contain "%s"' % (cmd, exp))
   
    def run_common_commands(self):
        self.ssh_command_output_contains('lspci -d 11ab:4620', 'GT-64120')
        self.ssh_command_output_contains('cat /sys/bus/i2c/devices/i2c-0/name',
                                         'SMBus PIIX4 adapter')
        self.ssh_command_output_contains('cat /proc/mtd', 'YAMON')
        # Empty 'Board Config'
        self.ssh_command_output_contains('md5sum /dev/mtd2ro',
                                         '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')

Cheers,
- Cleber.

