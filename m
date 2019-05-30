Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2C8C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647B325CC3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647B325CC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55499 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWMrU-0001pB-Nj
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 11:21:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWMqc-0001Ro-Ns
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWMqX-0001Lz-7r
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:20:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWMqV-000108-8e
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:20:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so4479289wrs.5
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 08:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fDl7Up76bQvJLfU8dD9TX43UFJ7OBQx7Oz2y/M4uMy8=;
	b=AMK5TWEgDJSyyZ2Hu8t4ETaaiBDoLkHhjyQLgUBR6BKZ9Ewse+hJGY1Q3Aiqifx7ab
	4reEqfcSeZkiCsX9iF7V6FlNKO5+/64VGp0BBP0Xjia14CfvaI3avWBADYyMRsYklMV5
	DlSnXeB3xYnsQ8TFDSwj18nbkszOJYEXEEGHPX7z2zwfVBNGbnuIVH1qHdFv4QQcFh0f
	0zk6iRfbv5da/Argy5ByiUallbQySs8/NLGyNAU2gAFg4A11CX/9QJU/UBZnlzk9TNaG
	QutUBhzlE8leiA75busWOxPNTWOh77kKxTHe1/eoor30Bnwoh8JJcIAAfqdxu+pmpExS
	06cg==
X-Gm-Message-State: APjAAAWbb/5K6Dtb0zwcR3XF7ie5xTstZ8fJvqPC53H8te5bJZCS+Ah7
	S8yoKg6DVAFw9Bzmn9iEaXQAbg==
X-Google-Smtp-Source: APXvYqx1gsIviiNn/OcE3Esle/WR34K4TF+tMiUbhyQ8cXdCdSxeuTmlaR1HKj6KoqqDHap6j0kuZA==
X-Received: by 2002:a5d:684c:: with SMTP id o12mr3057707wrw.305.1559229571680; 
	Thu, 30 May 2019 08:19:31 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	d11sm3747581wrv.72.2019.05.30.08.19.30
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 08:19:31 -0700 (PDT)
To: Li Qiang <liq3ea@gmail.com>
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-11-philmd@redhat.com>
	<CAKXe6SLrVkLhe3bG-_LsJd0qKBM8NQ-jDJjat80xLkqp8cg_ug@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2d4d64cb-7177-df14-25ee-3eeecbbaf48d@redhat.com>
Date: Thu, 30 May 2019 17:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6SLrVkLhe3bG-_LsJd0qKBM8NQ-jDJjat80xLkqp8cg_ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 10/20] hw/i386/pc: Pass the boot_cpus value
 by argument
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Samuel Ortiz <sameo@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/19 5:30 PM, Li Qiang wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com <mailto:philmd@redhat.com>> 于
> 2019年5月24日周五 下午2:50写道：
> 
>     The boot_cpus is used once. Pass it by argument, this will
>     allow us to remove the PCMachineState argument later.
> 
>     Suggested-by: Samuel Ortiz <sameo@linux.intel.com
>     <mailto:sameo@linux.intel.com>>
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      hw/i386/pc.c | 6 +++---
>      1 file changed, 3 insertions(+), 3 deletions(-)
> 
>     diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>     index 264074489b..01894b9875 100644
>     --- a/hw/i386/pc.c
>     +++ b/hw/i386/pc.c
>     @@ -928,7 +928,7 @@ static void pc_build_smbios(PCMachineState *pcms)
>          }
>      }
> 
>     -static FWCfgState *x86_create_fw_cfg(PCMachineState *pcms)
>     +static FWCfgState *x86_create_fw_cfg(PCMachineState *pcms, uint16_t
>     boot_cpus)
> 
> 
> For the patches 10/11/12, I don't think this is an elegant solution.
> When we add more data like 'boot_cpus'
> we need add more arguments?

This fonction is called once at machine creation, so there is no
performance penalty. To keep the code modularizable (reusable) it is an
acceptable tradeoff :)

> 
>      {
>          FWCfgState *fw_cfg;
>          uint64_t *numa_fw_cfg;
>     @@ -938,7 +938,7 @@ static FWCfgState
>     *x86_create_fw_cfg(PCMachineState *pcms)
> 
>          fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
>                                      &address_space_memory);
>     -    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
>     +    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, boot_cpus);
> 
>          /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
>           *
>     @@ -1762,7 +1762,7 @@ void pc_memory_init(PCMachineState *pcms,
>                                              option_rom_mr,
>                                              1);
> 
>     -    fw_cfg = x86_create_fw_cfg(pcms);
>     +    fw_cfg = x86_create_fw_cfg(pcms, pcms->boot_cpus);
> 
>          rom_set_fw(fw_cfg);
> 
>     -- 
>     2.20.1
> 
> 

