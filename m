Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A88EC4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EE32193E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="68iq79FD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EE32193E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRxV-0002Do-SH
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKRu1-0008UQ-KB; Mon, 21 Sep 2020 15:55:09 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:41372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKRtz-0001PC-2T; Mon, 21 Sep 2020 15:55:09 -0400
Received: from [172.17.10.14] (unknown [172.17.10.14])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 381C621CBD;
 Mon, 21 Sep 2020 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1600718104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdJf3DJWe80vJXiNV130z2krnIwjKy7duFJpGl4uerI=;
 b=68iq79FDXW/8qHw7/8VxAFFhx7FthZ9skKQ8w1WRF/JuB26b3IXdT66V6obq6bNQUPLhX5
 WNOEWZM2hIqUtYHJNL+sJG+ZCVnR7WyT3uXOBIKt/wyUDS0Kn+FVLPb/Eakj8ycUhxFwkh
 0XuCqaov//hVOixM/O5b8w/hv1vC6uY=
Subject: Re: [PATCH v3 3/8] hw/arm/raspi: Move arm_boot_info structure to
 RaspiMachineState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200921075628.466506-1-f4bug@amsat.org>
 <20200921075628.466506-4-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <08b7576d-a8d5-f2f1-fa98-a363ec3b7ac3@greensocs.com>
Date: Mon, 21 Sep 2020 21:55:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921075628.466506-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 15:38:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 9:56 AM, Philippe Mathieu-Daudé wrote:
> The arm_boot_info structure belong to the machine,
> move it to RaspiMachineState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   hw/arm/raspi.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 8716a80a75e..16e6c83c925 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -41,6 +41,7 @@ struct RaspiMachineState {
>       MachineState parent_obj;
>       /*< public >*/
>       BCM283XState soc;
> +    struct arm_boot_info binfo;
>   };
>   typedef struct RaspiMachineState RaspiMachineState;
>   
> @@ -206,12 +207,11 @@ static void reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
>   static void setup_boot(MachineState *machine, int version, size_t ram_size)
>   {
>       RaspiMachineState *s = RASPI_MACHINE(machine);
> -    static struct arm_boot_info binfo;
>       int r;
>   
> -    binfo.board_id = MACH_TYPE_BCM2708;
> -    binfo.ram_size = ram_size;
> -    binfo.nb_cpus = machine->smp.cpus;
> +    s->binfo.board_id = MACH_TYPE_BCM2708;
> +    s->binfo.ram_size = ram_size;
> +    s->binfo.nb_cpus = machine->smp.cpus;
>   
>       if (version <= 2) {
>           /* The rpi1 and 2 require some custom setup code to run in Secure
> @@ -220,21 +220,21 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
>            * firmware for some cache maintenance operations.
>            * The rpi3 doesn't need this.
>            */
> -        binfo.board_setup_addr = BOARDSETUP_ADDR;
> -        binfo.write_board_setup = write_board_setup;
> -        binfo.secure_board_setup = true;
> -        binfo.secure_boot = true;
> +        s->binfo.board_setup_addr = BOARDSETUP_ADDR;
> +        s->binfo.write_board_setup = write_board_setup;
> +        s->binfo.secure_board_setup = true;
> +        s->binfo.secure_boot = true;
>       }
>   
>       /* Pi2 and Pi3 requires SMP setup */
>       if (version >= 2) {
> -        binfo.smp_loader_start = SMPBOOT_ADDR;
> +        s->binfo.smp_loader_start = SMPBOOT_ADDR;
>           if (version == 2) {
> -            binfo.write_secondary_boot = write_smpboot;
> +            s->binfo.write_secondary_boot = write_smpboot;
>           } else {
> -            binfo.write_secondary_boot = write_smpboot64;
> +            s->binfo.write_secondary_boot = write_smpboot64;
>           }
> -        binfo.secondary_cpu_reset_hook = reset_secondary;
> +        s->binfo.secondary_cpu_reset_hook = reset_secondary;
>       }
>   
>       /* If the user specified a "firmware" image (e.g. UEFI), we bypass
> @@ -250,11 +250,11 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
>               exit(1);
>           }
>   
> -        binfo.entry = firmware_addr;
> -        binfo.firmware_loaded = true;
> +        s->binfo.entry = firmware_addr;
> +        s->binfo.firmware_loaded = true;
>       }
>   
> -    arm_load_kernel(&s->soc.cpu[0].core, machine, &binfo);
> +    arm_load_kernel(&s->soc.cpu[0].core, machine, &s->binfo);
>   }
>   
>   static void raspi_machine_init(MachineState *machine)
> 

