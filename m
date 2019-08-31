Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9321C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841A521874
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzSoKd/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841A521874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i49Em-00048l-KL
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 15:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i49Dx-0003iK-Li
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i49Dw-0003XY-J3
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:39:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1i49Dw-0003WS-Cu
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:39:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id z11so10121908wrt.4
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=EKP43mUFdCSBDMYyOkRe2zSQO4YQxUZxpgJ8hnBaBx0=;
 b=jzSoKd/g9WC65GE4NRnipQOfQS/B12oug6oi6Km9qcPTx9ctM0mo7R3pVE82Y9FIU5
 WHUVdJHioI2UZbTV0bFUPB0GVQSSvl/4oirdgDC6RkLgNLZxIrZ0uviEr5IpFctAgKBc
 tgjDNJJsBIuEfM00onPnsA/9Cj94lAO0JKEj2bUtP5FdknKqou9xiYaWGtMUM7a4TPax
 SZzIr2wYpBVSQQ5skbY4tOvsyWuLH81TcXDhm+zq0+WGeYzXKGZKqoxt7zCXVNAm8HZl
 bxvKidjo7EEtHquECCWwXh+u6taFghRfU0l/988etTIaFqKAEUTCSVkfbrVp+j2IaLN5
 HTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=EKP43mUFdCSBDMYyOkRe2zSQO4YQxUZxpgJ8hnBaBx0=;
 b=bXyJ6dybL3OQZzPtn2R8xsEPTeQoo2QjYyO6rV2A4zoB8+i0Q4AbZiG1AhCGyXAz8U
 NZMLz1tmXuzSZSw7x+gk4iQCf7Ldg998/cgqWfkMFulKHvTFwSsPV/GvlbeCKG4J/nu7
 eZigePoS6f0Dz4Kssqj3+UR5fIHF0ySgFh/Qcc3VeXomNupe7bfvHZ/cvJ3Eu3V7lOys
 UdlSTRFyMatX435LGH8v4q2XwmWfVOa0X7P41izm/nnKqgNqOHWUf2ouGxIuLTfJ/ylU
 g+2sojpuBGsTIqTKTqPMxhGk1cPhF2HKho0OI6fhHqfymhD5772el2gau7Yo0mhVpAj6
 BwSQ==
X-Gm-Message-State: APjAAAUgFdJ8XYqkZUm9IUMEaNKT6j6oOB2V3esSmyGBoPH8w/0k5nGw
 26eHOsKZnF+bVs7G4VL9JJY=
X-Google-Smtp-Source: APXvYqzj+5z6c6thDzud7lyhwFNgBYX446fF7OXRooGibztnJUk6cCESHJJ9uWpS5jBqBs6rJusUog==
X-Received: by 2002:adf:e503:: with SMTP id j3mr807839wrm.166.1567280387147;
 Sat, 31 Aug 2019 12:39:47 -0700 (PDT)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id v7sm10320193wru.87.2019.08.31.12.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Aug 2019 12:39:46 -0700 (PDT)
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
 <20190828142328.24561-2-skrtbhtngr@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <f97b1f97-abd7-d3ea-2be4-0cce66fe2303@gmail.com>
Date: Sat, 31 Aug 2019 22:39:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828142328.24561-2-skrtbhtngr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 1/2] hw/pvrdma: make DSR mapping
 idempotent in load_dsr()
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/28/19 5:23 PM, Sukrit Bhatnagar wrote:
> Map to DSR only when there is no mapping done already i.e., when
> dev->dsr_info.dsr is NULL. This allows the rest of mappings and
> ring inits to be done by calling load_dsr() when DSR has already
> been mapped to, somewhere else.
>
> Move free_dsr() out of load_dsr() and call it before the latter
> as and when needed. This aids the case where load_dsr() is called
> having DSR mapping already done, but the rest of map and init
> operations are pending, and prevents an unmap of the DSR.
>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> ---
>   hw/rdma/vmw/pvrdma_main.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index adcf79cd63..6c90db96f9 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -172,15 +172,15 @@ static int load_dsr(PVRDMADev *dev)
>       DSRInfo *dsr_info;
>       struct pvrdma_device_shared_region *dsr;
>   
> -    free_dsr(dev);
> -
> -    /* Map to DSR */
> -    dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
> -                              sizeof(struct pvrdma_device_shared_region));
>       if (!dev->dsr_info.dsr) {
> -        rdma_error_report("Failed to map to DSR");
> -        rc = -ENOMEM;
> -        goto out;
> +        /* Map to DSR */
> +        dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
> +                                  sizeof(struct pvrdma_device_shared_region));
> +        if (!dev->dsr_info.dsr) {
> +            rdma_error_report("Failed to map to DSR");
> +            rc = -ENOMEM;
> +            goto out;
> +        }
>       }
>   
>       /* Shortcuts */
> @@ -402,6 +402,7 @@ static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
>       case PVRDMA_REG_DSRHIGH:
>           trace_pvrdma_regs_write(addr, val, "DSRHIGH", "");
>           dev->dsr_info.dma |= val << 32;
> +        free_dsr(dev);
>           load_dsr(dev);
>           init_dsr_dev_caps(dev);
>           break;

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

