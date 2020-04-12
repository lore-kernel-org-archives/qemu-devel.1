Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A034C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 18:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2465206DA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 18:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDzBSvjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2465206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNgxR-0004TP-Nh
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 14:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNgwX-0003hX-8D
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 14:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNgwW-00082Y-45
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 14:02:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNgwT-0007zV-KU; Sun, 12 Apr 2020 14:02:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id v5so8056059wrp.12;
 Sun, 12 Apr 2020 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mnDmOQ5tHlp9o1eeZyM24TPzDLGHbt/uk6poZPWdH1c=;
 b=uDzBSvjrQq81UL487+tHf2PFlll6GsH1o5B4VXWjHzSS2Krp+7w8ULlGnBNvRe59hj
 mNbsRXQ4khX98obRxvBW/4BSMErAHLeOWJLOaggoKPQwgpMIy+7OW6j6pTqbycMXrh01
 TF0Cyph0lnpEMrLTu1iPgpXs6qC0WimmeBI0lA8exuHRe/iaDozYr3tXCLhN4dwFHCHV
 BsJRJedcp/57mexEE1h9EkAOBR/8YwnBLjSAWviH+SbSq4AJrKWWALlJVqNR/ijz0RHA
 AJKEHvrd3QQx2lS/xORtL7ts8HU3h3MvaylEby7phjAs+3jMTlkx+u+MR3TdOzRiKs6o
 XQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mnDmOQ5tHlp9o1eeZyM24TPzDLGHbt/uk6poZPWdH1c=;
 b=AgficWI1VcVlVxt5kbwbNejAnACgLMtkk3jlCESq7fcEiAZ9goTR3EZq5SHZ3bGmge
 usmQ5+hQrkEc0A+hM5CroCbSyjGxxdOWGHgq/j9RY2HCT7H4VEwxxQuK56gqDPDsMnZE
 ZXHUCeIPB7YUMa3CilCrhUt5/V5fxkeGzMbPEZOVsNKORBcBuuQKLcSsKO80CrD//TNn
 lS9tvXEHXUGX9PNuT+RB9FNwRsSkTYEA+iU415xXkQwMpP7Dku8g4qbjDNaJ3dr4+/db
 kwmQKqdqI1NaTca3yeCSAN3zWF2QyH9Ttc34OZ3wfYlxS7xAQ6eVmEtjq0cgR5m0IOrz
 m+GA==
X-Gm-Message-State: AGi0PuaysLMTRWFKwgNCTwT3r6DuaGraz1ZUnb5XvA+rYWO737J6G8GY
 8z2SPegQk3jSRiA1YM1ULLi9r9+xLS4=
X-Google-Smtp-Source: APiQypJw8xciIw4sDDKcSJaqidOnjhntQ20SqFW7jSetB21u/YUqKKFGzMjQOost01bpjIMP8UXzDw==
X-Received: by 2002:a05:6000:143:: with SMTP id
 r3mr14323266wrx.279.1586714568238; 
 Sun, 12 Apr 2020 11:02:48 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q19sm11665867wra.38.2020.04.12.11.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2020 11:02:47 -0700 (PDT)
Subject: Re: [Qemu devel PATCH v4 3/3] tests/boot_linux_console: Add ethernet
 test to SmartFusion2
To: sundeep.lkml@gmail.com, jasowang@redhat.com, peter.maydell@linaro.org,
 philmd@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <1586529926-11441-1-git-send-email-sundeep.lkml@gmail.com>
 <1586529926-11441-4-git-send-email-sundeep.lkml@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <b3d5a33f-150c-bfd8-ee78-40738ffe6b65@amsat.org>
Date: Sun, 12 Apr 2020 20:02:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586529926-11441-4-git-send-email-sundeep.lkml@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/10/20 4:45 PM, sundeep.lkml@gmail.com wrote:
> From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> 
> In addition to simple serial test this patch uses ping
> to test the ethernet block modelled in SmartFusion2 SoC.
> 
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> ---
>  tests/acceptance/boot_linux_console.py | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index f825cd9..c6b06a1 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -336,13 +336,13 @@ class BootLinuxConsole(Test):
>          """
>          uboot_url = ('https://raw.githubusercontent.com/'
>                       'Subbaraya-Sundeep/qemu-test-binaries/'
> -                     'fa030bd77a014a0b8e360d3b7011df89283a2f0b/u-boot')
> -        uboot_hash = 'abba5d9c24cdd2d49cdc2a8aa92976cf20737eff'
> +                     'fe371d32e50ca682391e1e70ab98c2942aeffb01/u-boot')
> +        uboot_hash = 'cbb8cbab970f594bf6523b9855be209c08374ae2'
>          uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
>          spi_url = ('https://raw.githubusercontent.com/'
>                     'Subbaraya-Sundeep/qemu-test-binaries/'
> -                   'fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin')
> -        spi_hash = '85f698329d38de63aea6e884a86fbde70890a78a'
> +                   'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin')
> +        spi_hash = '65523a1835949b6f4553be96dec1b6a38fb05501'
>          spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
>  
>          self.vm.set_console()
> @@ -352,7 +352,12 @@ class BootLinuxConsole(Test):
>                           '-drive', 'file=' + spi_path + ',if=mtd,format=raw',
>                           '-no-reboot')
>          self.vm.launch()
> -        self.wait_for_console_pattern('init started: BusyBox')
> +        self.wait_for_console_pattern('Enter \'help\' for a list')
> +
> +        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 10.0.2.15',
> +                                                 'eth0: link becomes ready')
> +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
> +            '3 packets transmitted, 3 packets received, 0% packet loss')

Very nice (and smart) :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>      def do_test_arm_raspi2(self, uart_id):
>          """
> 

