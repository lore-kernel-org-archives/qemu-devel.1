Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADB8C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317792184C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317792184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxDq-0000w1-FF
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48002)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwnX-0005uO-8N
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwnW-0005xl-5y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:56:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhwnV-0005wp-WA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:56:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so13986403wrm.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 06:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KlOGHNxxIFekZdwvx82DbIJwJdH1NIeLAxn4Dx2x6Po=;
 b=fUQtNecfM7oSAXq6uJQD+/vJ3pOIKebnGkCzmH3P8TPOQV5xYAnThXO4F61ILUxVtx
 QslefbOGhjeL2oW2aBsyUo7W8hANGR69b9zcQAuUj2O9+ldmeLej4t1cG1xqYLC/fRUJ
 OdQmuRZSgiq/l7+24RFc2o/P6I3wV00z5Jadi9R/9PR8mD5lKShKwYAXltClVnkXBv3v
 cNbmRb+51hRn7KtnzxXIx0lANG+z567nBgH425D7ychxaUB320/CQ4Nd8rvzN/YZ/GuZ
 Pmto7p0OoaQ2ogMcIfTlDc7ygWNn89YiMJyG4KsSekqLpqp6Yh0BN9IJRTMBIg5DRxCh
 LG0Q==
X-Gm-Message-State: APjAAAW9psjoQvHl1Uz+70Lt1AKnj/GR6DPzk6J6UeLZjBUaIQ1rG6kU
 xUUjUdjMGVg9+eEWGt7y1EhyNA==
X-Google-Smtp-Source: APXvYqxMnWelswb63qGVBuVnImwd9/AuqaCSbzRtpA0PSYnBXUFe0jC8bzuyvizHkXBRwUlX1SsgMw==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr18083400wrj.47.1561989404410; 
 Mon, 01 Jul 2019 06:56:44 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id o20sm27498686wrh.8.2019.07.01.06.56.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 06:56:43 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
References: <20190607174953.22342-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a09936fe-4fdc-1623-6300-43f4891ff389@redhat.com>
Date: Mon, 1 Jul 2019 15:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607174953.22342-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] BootLinuxSshTest: Only use 'test' for
 unittest.TestCase method names
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-trivial@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 6/7/19 7:49 PM, Philippe Mathieu-Daudé wrote:
> In commit f6e501a28ef9, Eduardo started to use "check_" as a
> prefix for methods of similar purpose. Follow this prior art,
> since it might become the conventions when writting Avocado
> tests.
> 
> Suggested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/acceptance/linux_ssh_mips_malta.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
> index aafb0c39f6..134f10cac3 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -162,7 +162,7 @@ class LinuxSSH(Test):
>          self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in line
>                               for line in stdout])
>  
> -    def do_test_mips_malta(self, endianess, kernel_path, uname_m):
> +    def check_mips_malta(self, endianess, kernel_path, uname_m):
>          self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_path)
>  
>          stdout, stderr = self.ssh_command('uname -a')
> @@ -184,7 +184,7 @@ class LinuxSSH(Test):
>          kernel_hash = '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>  
> -        self.do_test_mips_malta('be', kernel_path, 'mips')
> +        self.check_mips_malta('be', kernel_path, 'mips')
>  
>      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
>      def test_mips_malta32el_kernel3_2_0(self):
> @@ -199,7 +199,7 @@ class LinuxSSH(Test):
>          kernel_hash = 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>  
> -        self.do_test_mips_malta('le', kernel_path, 'mips')
> +        self.check_mips_malta('le', kernel_path, 'mips')
>  
>      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
>      def test_mips_malta64eb_kernel3_2_0(self):
> @@ -213,7 +213,7 @@ class LinuxSSH(Test):
>                        'vmlinux-3.2.0-4-5kc-malta')
>          kernel_hash = 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> -        self.do_test_mips_malta('be', kernel_path, 'mips64')
> +        self.check_mips_malta('be', kernel_path, 'mips64')
>  
>      @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
>      def test_mips_malta64el_kernel3_2_0(self):
> @@ -227,4 +227,4 @@ class LinuxSSH(Test):
>                        'vmlinux-3.2.0-4-5kc-malta')
>          kernel_hash = '6a7f77245acf231415a0e8b725d91ed2f3487794'
>          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> -        self.do_test_mips_malta('le', kernel_path, 'mips64')
> +        self.check_mips_malta('le', kernel_path, 'mips64')
> 

