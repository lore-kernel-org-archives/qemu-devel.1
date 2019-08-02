Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B54C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E12C2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E12C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htZxZ-0008Uk-MI
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 11:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1htZx3-00084V-19
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1htZx1-0005FA-PD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:58:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1htZx1-0005Dl-Hf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:58:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id v15so72827852eds.9
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 08:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mdVaBBfegqRBWuGVv3fcrgrnieb0rN41um/u33kyB1g=;
 b=UGSKvrWMoxbCPkRNWlab2C/ar5Uo21ynWv3eVj6k1+TT5TPpmVmFqIkuUNGdILl47k
 HQVOcMtd4vz5GK2zydppmlQfMoAbaFgrReePgaYu8wofxjOsloun55JllHbGCJh/+Y7W
 X3XGThyVYC7RlF3UCFfb13LDEgZPrK8z/L+RVdCguYAwljv6uOLfoSwCRWLc7GeFFa8b
 c2uOieQflb6mEeiL8IbonM4Aw5APkUjFk3b/qKEDwi4/+BAgWYjiddLF7ZZc2silxjWx
 WmwCsZIxaz07aAK3BD993qF/WMSWEZ0maAOqoGbb8/+lndHZ8rbD8amF9woJ3DWMBr0A
 DVpw==
X-Gm-Message-State: APjAAAXBF9RNlYxSbV/aovQFQW1kFPUwxoup47m5fvr9GRjSMWZkj3bL
 oU77QbFdn5dFg8cqbCN/k+5HCQ==
X-Google-Smtp-Source: APXvYqzwG4xOTKpL93bW/jg4rsrw2IMNoHvA6PZ/wuNanQGTR8M3KF1E/wEwH/omCG7GbgYRnozrcg==
X-Received: by 2002:a17:906:470a:: with SMTP id
 y10mr90476915ejq.115.1564761518487; 
 Fri, 02 Aug 2019 08:58:38 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id x11sm13404955eju.26.2019.08.02.08.58.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 08:58:37 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564760158-27536-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f71dae2e-52ce-5ad8-fe1d-1433788b5d11@redhat.com>
Date: Fri, 2 Aug 2019 17:58:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564760158-27536-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.65
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
Cc: cohuck@redhat.com, ehabkost@redhat.com, crosa@redhat.com, f4bug@amsat.org,
 amarkovic@wavecomp.com, ccarrara@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/2/19 5:35 PM, Aleksandar Markovic wrote:
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

Or easier using 'return':

     def ssh_command_output_contains(self, cmd, exp):
        stdout, _ = self.ssh_command(cmd)
        for line in stdout:
            if exp in line:
                return
        self.fail('"%s" output does not contain "%s"' % (cmd, exp))

Regardless, thanks for the cleanup!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
>  
>          self.run_common_commands()
> 

