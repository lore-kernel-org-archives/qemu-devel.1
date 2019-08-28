Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B573C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00EA2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00EA2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i35V1-00034P-Uq
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 17:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i35Tl-0002Yj-7z
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i35Tk-0002yO-8K
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:27:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i35Tk-0002xo-0p
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D72B18C4266;
 Wed, 28 Aug 2019 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-242.rdu2.redhat.com
 [10.10.123.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E96D5D9CA;
 Wed, 28 Aug 2019 21:27:42 +0000 (UTC)
Date: Wed, 28 Aug 2019 17:27:40 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Message-ID: <20190828212726.GC11512@localhost.localdomain>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564760158-27536-3-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564760158-27536-3-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 28 Aug 2019 21:27:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] tests/acceptance: Add new test cases
 in linux_ssh_mips_malta.py
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
Cc: f4bug@amsat.org, cohuck@redhat.com, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 02, 2019 at 05:35:58PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add 15 new tests cases. They all rely on simple commands used for
> detecting hardware configuration information.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  tests/acceptance/linux_ssh_mips_malta.py | 45 ++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
> index 8368e1f..c153c41 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -155,6 +155,51 @@ class LinuxSSH(Test):
>  
>      def run_common_commands(self):
>          self.ssh_command_output_contains(
> +            'cat /proc/cpuinfo',
> +            '24Kc')
> +        self.ssh_command_output_contains(
> +            'uname -m',
> +            'mips')
> +        self.ssh_command_output_contains(
> +            'uname -r',
> +            '3.2.0-4-4kc-malta')
> +        self.ssh_command_output_contains(
> +            'cat /proc/interrupts',
> +            'timer')
> +        self.ssh_command_output_contains(
> +            'cat /proc/interrupts',
> +            'i8042')
> +        self.ssh_command_output_contains(
> +            'cat /proc/interrupts',
> +            'serial')
> +        self.ssh_command_output_contains(
> +            'cat /proc/interrupts',
> +            'ata_piix')
> +        self.ssh_command_output_contains(
> +            'cat /proc/interrupts',
> +            'eth0')
> +        self.ssh_command_output_contains(
> +            'cat /proc/interrupts',
> +            'eth0')
> +        self.ssh_command_output_contains(
> +            'cat /proc/devices',
> +            'input')
> +        self.ssh_command_output_contains(
> +            'cat /proc/devices',
> +            'usb')
> +        self.ssh_command_output_contains(
> +            'cat /proc/devices',
> +            'fb')
> +        self.ssh_command_output_contains(
> +            'cat /proc/ioports',
> +            'serial')
> +        self.ssh_command_output_contains(
> +            'cat /proc/ioports',
> +            'ata_piix')
> +        self.ssh_command_output_contains(
> +            'cat /proc/ioports',
> +            'piix4_smbus')
> +        self.ssh_command_output_contains(
>              'lspci -d 11ab:4620',
>              'GT-64120')
>          self.ssh_command_output_contains(
> -- 
> 2.7.4
> 
> 

This is fine, although using a loop would probably result in better
readability.  Something like:

   for cmd, exp in [('cat /proc/cpuinfo', '24Kc'),
                    ('uname -m', 'mips'),
                    ...]
      self.ssh_command_output_contains(cmd, exp)

Either way:

Reviewed-by: Cleber Rosa <crosa@redhat.com>

