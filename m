Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E959C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB2320663
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB2320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDRud-0004Gc-Kz
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 06:54:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDRtt-0003zT-7V
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDRts-00087B-6A
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:53:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDRtr-00086e-TJ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:53:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so15802694wrd.3
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 03:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=c4LLaF4aIrjPRRohp1SnH9OyoeWwemgrvvLMSakSvOA=;
	b=oEh+N7mrNcWbemvsQWMqz6mHZoJgrc0YL8X0p75keKHC6A0Vc/NCzMZK8ERhOVE+l3
	FUznVuZ0ZAqIn/KFi0LdbmSAaItOAqRWNASHdI3wF0FOS42W/AnkoS4O2I6Cef96HJUX
	aijCNyNsirVpBKJGqM2YEnp5IrvLyayj+oITh7WcNlUpd7wT/0hOQvioDpHtm9HmVYzS
	1XK3OhXiCrn7Q8KhWN/ufgCJlsYkWL/gLMzFm3UZyMKozFyTXl72Ut4ffcMLgIsU88Xz
	o3zX+P761MDp+hojguNn4AXz5x4+PiWH6B8PP/WWmkT3y0hV+tDN5aUiv7pvnpfonZWP
	SgpA==
X-Gm-Message-State: APjAAAXqr2J8yeEf634OMZ+luqC3mUkkfZCFPMB7e8hB0l3ydgsK5jlc
	JLxwDHO1714OxQN9DQPNBhhpug==
X-Google-Smtp-Source: APXvYqwhm/kuIH9mmxdfJfOcLKKmo9PqwMIMAulnMaYvE42o8wLeaIXwurnKpHsBgrjadSY1yJb38A==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr17413296wrq.242.1554720795040; 
	Mon, 08 Apr 2019 03:53:15 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	s10sm13705543wmh.0.2019.04.08.03.53.14
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 03:53:14 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8adaa89a-9e0d-a5ab-36c9-ea60d056885e@redhat.com>
Date: Mon, 8 Apr 2019 12:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-6-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 05/15] mips/boston: Report errors with
 error_report(), not error_printf()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Paul Burton <pburton@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408105313.mhjkZR3R4PYPRWa5atSD7VBExUFTvtkOv_1WRm0-86E@z>

On 4/8/19 10:36 AM, Markus Armbruster wrote:
> Cc: Paul Burton <pburton@wavecomp.com>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/mips/boston.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index e5bab3cadc..a8b29f62f5 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -528,21 +528,21 @@ static void boston_mach_init(MachineState *machine)
>          fw_size = load_image_targphys(machine->firmware,
>                                        0x1fc00000, 4 * MiB);
>          if (fw_size == -1) {
> -            error_printf("unable to load firmware image '%s'\n",
> +            error_report("unable to load firmware image '%s'",
>                            machine->firmware);
>              exit(1);
>          }
>      } else if (machine->kernel_filename) {
>          fit_err = load_fit(&boston_fit_loader, machine->kernel_filename, s);
>          if (fit_err) {
> -            error_printf("unable to load FIT image\n");
> +            error_report("unable to load FIT image");
>              exit(1);
>          }
>  
>          gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
>                       s->kernel_entry, s->fdt_base, is_64b);
>      } else if (!qtest_enabled()) {
> -        error_printf("Please provide either a -kernel or -bios argument\n");
> +        error_report("Please provide either a -kernel or -bios argument");
>          exit(1);
>      }
>  }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

