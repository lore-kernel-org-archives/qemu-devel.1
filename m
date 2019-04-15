Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFBFC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A07420663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A07420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49922 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1HO-0004xv-LL
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:04:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG1G0-0004Hi-1q
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG1Ft-0004zL-C1
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:02:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hG1Fp-0004ir-M2
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:02:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so21810999wra.12
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 06:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4Zpb98NN9UpmgwbN/OmilnYPFoUa7Uafq0ZGYEx6/Qk=;
	b=bIjU2pMhOM4a/tOXIRojaOqS99TSQ8ZQ6uol5iRd25qphtUpjk5WFJ4h/g/hJkx+1l
	hbkHaarnLVUhNuhJYPwuGfF0fwC/CXq9IJP1mZgFkZh4JSCv2RWI4GuhWC9UwW206aOK
	Ujbv/Ipc6QG2oJvLoTJiP7z2sZN10T7vHUvv+ozOjhU9hm9mCer83BtiYHpS6dfWdhZa
	ZfrVZ5vP++cFpuZrkRAjP5973gty1bFnK5B7vTW5s8ukB/Y415E6PvjxHOioyMZbsMid
	olEl7Pz5BhoyUD2CTC0CcmtWL7FhAThpb4K6zr3S3D6ITXVDWttqnUx51LcZpz6WjasJ
	QbVg==
X-Gm-Message-State: APjAAAVR5NJlraK34KNm9L6vCXgc3xLKdamKubasZAiIdctgQr2evS5a
	gdWEg7Xu1Kf7xrS1kSq7lnmXeA==
X-Google-Smtp-Source: APXvYqz7P1HupGmu4elL/1Diy4rNQRiGaavl5ll8vCIdAqw+9PBxx3gPd9v7I4nOetCOn5FAJ1JoDg==
X-Received: by 2002:a5d:5192:: with SMTP id k18mr12899757wrv.171.1555333341718;
	Mon, 15 Apr 2019 06:02:21 -0700 (PDT)
Received: from [10.1.5.6] (206.red-80-28-210.staticip.rima-tde.net.
	[80.28.210.206]) by smtp.gmail.com with ESMTPSA id
	v6sm64000555wrt.56.2019.04.15.06.02.20
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 06:02:21 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
References: <20190415070307.13668-1-richardw.yang@linux.intel.com>
	<20190415070307.13668-2-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d4d6f1d4-9df8-a73e-4086-6c43e5ba7b4a@redhat.com>
Date: Mon, 15 Apr 2019 15:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415070307.13668-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/arm/virt-acpi-build: remove
 unnecessary variable mcfg_start
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, imammedo@redhat.com,
	shannon.zhaosl@gmail.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415130220.GwFpY_3NjkdMZnxkv1xjmMgxB_saGtYPBlnutgxVWAU@z>

On 4/15/19 9:03 AM, Wei Yang wrote:
> mcfg_start points to the start of MCFG table and is used in
> build_header. While this information could be derived from mcfg.
> 
> This patch removes the unnecessary variable mcfg_start.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 857989362a..e09e7eff8d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -552,7 +552,6 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      const MemMapEntry *memmap = vms->memmap;
>      int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
>      int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
> -    int mcfg_start = table_data->len;
>  
>      mcfg = acpi_data_push(table_data, len);
>      mcfg->allocation[0].address = cpu_to_le64(memmap[ecam_id].base);
> @@ -563,8 +562,7 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      mcfg->allocation[0].end_bus_number =
>          PCIE_MMCFG_BUS(memmap[ecam_id].size - 1);
>  
> -    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
> -                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
> +    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>  }
>  
>  /* GTDT */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

