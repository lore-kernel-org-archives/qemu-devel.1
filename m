Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FECC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 08:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0AB218BE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 08:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0AB218BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjJxw-0002Cv-OD
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 04:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjJwk-00018W-Cn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjJwj-0004aT-5T
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:51:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjJwi-0004Zw-Uc
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:51:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so8005450wmj.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 01:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mk4ycAxdx0O0XvVyW6e66hkGhmNaiymjWNoGqwtdors=;
 b=G6Ox8OOraOqp5nfzf8ODpLVg3oLjUZat49KzpUJ5bw8BMgVMar+0QYK95usyGwBXpY
 /WB9Wz0gutvUlWau87ZJVf0poi6oytFCu6jb2F+5qk0vreZA5oXNKiQGK5jJbabMoaWN
 JrxJ/XSl0j8mo+1Py6BdlZV+isnlpgt/AS4NJ8da4LlyPfeXTUhumLiSDgLt/Jp1Lz2g
 O/WW47ZlB3gMVgYcT5XQEDFjUSx2RONR7p5yzLnBvs23HONPgSULJJCiUJbQ5ws1SxbB
 OHpWnSxhnKIek1x1p/L8tS0g88nHoXVyCIlO1momsbU5lRnaDNXZpebUjiGnnlXj9Hu0
 /z9Q==
X-Gm-Message-State: APjAAAVTwhGw7hB5U+j5rGBhvTlBQ0OUD3YrCUsE7qUCb/+eEF3rRXVa
 PENM4OKfEwpCyx5OWa9xOM5QPA==
X-Google-Smtp-Source: APXvYqylONjj7snnNoLr97Ea0N5uQNID92/OspJwidDSnxT+IIykm+GMigOv0sBv/pId90OVWTUWOA==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr2398569wmd.73.1562316715449; 
 Fri, 05 Jul 2019 01:51:55 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id x20sm7612123wmc.1.2019.07.05.01.51.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 01:51:54 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190704142004.7150-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3bb189fa-8e47-acb0-89a2-9b5121c2269f@redhat.com>
Date: Fri, 5 Jul 2019 10:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704142004.7150-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/sbsa-ref: Remove
 unnecessary check for secure_sysmem == NULL
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
Cc: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Leif Lindholm <leif.lindholm@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/19 4:20 PM, Peter Maydell wrote:
> In the virt machine, we support TrustZone being either present or
> absent, and so the code must deal with the secure_sysmem pointer
> possibly being NULL. In the sbsa-ref machine, TrustZone is always
> present, but some code and comments copied from virt still treat
> it as possibly not being present.
> 
> This causes Coverity to complain (CID 1407287) that we check
> secure_sysmem for being NULL after an unconditional dereference.
> Simplify the code so that instead of initializing the variable
> to NULL, unconditionally assigning it, and then testing it for NULL,
> we just initialize it correctly in the variable declaration and
> then assume it to be non-NULL. We also delete a comment which
> only applied to the non-TrustZone config.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not a bug as such, but we should put it in for 4.1 to
> keep Coverity happy.
> ---
>  hw/arm/sbsa-ref.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index ee53f0ff60d..6f315b79445 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -254,8 +254,6 @@ static void sbsa_flash_map(SBSAMachineState *sms,
>       * sysmem is the system memory space. secure_sysmem is the secure view
>       * of the system, and the first flash device should be made visible only
>       * there. The second flash device is visible to both secure and nonsecure.
> -     * If sysmem == secure_sysmem this means there is no separate Secure
> -     * address space and both flash devices are generally visible.
>       */
>      hwaddr flashsize = sbsa_ref_memmap[SBSA_FLASH].size / 2;
>      hwaddr flashbase = sbsa_ref_memmap[SBSA_FLASH].base;
> @@ -588,7 +586,7 @@ static void sbsa_ref_init(MachineState *machine)
>      SBSAMachineState *sms = SBSA_MACHINE(machine);
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      MemoryRegion *sysmem = get_system_memory();
> -    MemoryRegion *secure_sysmem = NULL;
> +    MemoryRegion *secure_sysmem = g_new(MemoryRegion, 1);
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      bool firmware_loaded;
>      const CPUArchIdList *possible_cpus;
> @@ -612,13 +610,11 @@ static void sbsa_ref_init(MachineState *machine)
>       * containing the system memory at low priority; any secure-only
>       * devices go in at higher priority and take precedence.
>       */
> -    secure_sysmem = g_new(MemoryRegion, 1);
>      memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>                         UINT64_MAX);
>      memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
>  
> -    firmware_loaded = sbsa_firmware_init(sms, sysmem,
> -                                         secure_sysmem ?: sysmem);
> +    firmware_loaded = sbsa_firmware_init(sms, sysmem, secure_sysmem);
>  
>      if (machine->kernel_filename && firmware_loaded) {
>          error_report("sbsa-ref: No fw_cfg device on this machine, "
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

