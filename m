Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB40C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAE624953
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIfxqFzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAE624953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX54g-0004P1-RR
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shannon.zhaosl@gmail.com>)
 id 1jX4rK-00007k-P1; Fri, 08 May 2020 11:24:18 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shannon.zhaosl@gmail.com>)
 id 1jX4rJ-0002dD-Rr; Fri, 08 May 2020 11:24:18 -0400
Received: by mail-pj1-x1044.google.com with SMTP id y6so4417547pjc.4;
 Fri, 08 May 2020 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=efdEzAVZoqUilZ5KPe1GctEjRCGzwaERAh49d2ZqPBU=;
 b=FIfxqFzP5dwFKdw/CgVu4lGSf9VJCaiXgfjfbBB60x6ifE0NAdovInYpaqQJQrTYdQ
 LFMr7mMOYjrCXSJy5S/RXIu+658jvBz7iKvIItBWBrWtlDjhAapzRtTB6yD1TIeKtnkr
 deiVa5FMdLvUo/D4NLWRGJEUrc4a5X2v0iCG5YgBIJt9tt+K6a4Y3na42X6keU4gtQ1Q
 XVe9MDm4SV+wuOQBwOarBhg+E4O08oqt233lczilK4HoelQd4bdD95XE9lWBm6fWNzrB
 0pLF8RKfDBUOatJjmKiTfvwd0KObGH+VfY+D9uYByVjfP2Gk1El+sbhmO48NCCCLlTW0
 KsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=efdEzAVZoqUilZ5KPe1GctEjRCGzwaERAh49d2ZqPBU=;
 b=tl5Dj6eaOSjxILrzdrSarY8OcK15oIg4vB7LibmWcEfrW0mNX2AbqeExdkPcI3sqaI
 iAv5s3NqrXqsIwKsCFdXLWCHyl8AWd9MSwX8cIsvAPQXY+nlks9pB+0IefSZhDKDNnBJ
 7Z9dwWDB+brD9x70wx6189Zt5sFdXSXeHsoWLAVYrb3Ga6Wk7VYBpQ8HnEwOB94ybOCg
 NM1mpiqrmgvxjRoCxsDw3SUADy9b8YhyJJVEYTA3wZYaclclQSVdAKGy9Q08x0PN1Owp
 KL2VgGcLnCzIuK6IaWJUhshBfVmx2KD1eLTGk8LpVg3FQMPG8YmseOGFhDiSYyEplASd
 7qhQ==
X-Gm-Message-State: AGi0PuZoetq83KyxUjPYp+c/4tWYBiA9xME8m/+P4T30Eq3VEO+5oAfy
 DWcC0eHAAJ5KNg1Hjdw29Ew=
X-Google-Smtp-Source: APiQypL+9bFNwRg399lBO5n62W+k+JzeiZ4wypQY2BC1laUU0ItX5US4o4/HG9S9no7swpflpoMDRw==
X-Received: by 2002:a17:902:a981:: with SMTP id
 bh1mr3015317plb.43.1588951455848; 
 Fri, 08 May 2020 08:24:15 -0700 (PDT)
Received: from [192.168.3.36] ([125.121.205.131])
 by smtp.gmail.com with ESMTPSA id mn1sm2585518pjb.24.2020.05.08.08.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 08:24:15 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arm/acpi: Add the TPM2.0 device under the DSDT
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 stefanb@linux.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, imammedo@redhat.com, mst@redhat.com
References: <20200505144419.29174-1-eric.auger@redhat.com>
 <20200505144419.29174-4-eric.auger@redhat.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
Message-ID: <976a1479-4443-da02-2ad8-1e1570742caa@gmail.com>
Date: Fri, 8 May 2020 23:24:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200505144419.29174-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=shannon.zhaosl@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, gshan@redhat.com,
 lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 2020/5/5 22:44, Eric Auger wrote:
> +static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
> +{
> +    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    MemoryRegion *sbdev_mr;
> +    SysBusDevice *sbdev;
> +    hwaddr tpm_base;
> +
> +    sbdev = (SysBusDevice *)object_dynamic_cast(OBJECT(tpm_find()),
> +                                                TYPE_SYS_BUS_DEVICE);

Does it need to check the tpm version like you do in previous patch?

tpm_get_version(tpm_find()) == TPM_VERSION_2_0

Thanks,
Shannon

