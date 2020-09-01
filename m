Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CC1206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvQsjUkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CC1206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6fD-0005Sw-Nk
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6eH-0004Xl-Ck; Tue, 01 Sep 2020 09:48:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6eF-0000pw-9b; Tue, 01 Sep 2020 09:48:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id o5so1588305wrn.13;
 Tue, 01 Sep 2020 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YDzzyttZt2ACMY6s7/wn7fRUYl8HWgLpZeknqVs9FvA=;
 b=RvQsjUkAeAV9nX6A+//yxkR+etotrOf3GPwLC1iTMSTSKQUmsxTK7tp8gi/vuflhF/
 7ch6x+uL1N4hoY8e6/4cPkwZ2Y++xmpEAXsuS2OsrKVZhkVIOvVyZ3Bi3MEnB7U6wKTf
 aRa+vPByavHsr1TWqF1A/kw3TnmjlH7y8ddVaQkCkxMo2uxMqbe+SjNl2UlJHbw7ydC0
 T2w4FIeVuHwiZ9bDMDFSzSrwWxjcz7Tk9EronaztToMHbaaNlWH3t+DaFwOAcegVxOwp
 qkrps83munNU0GkUkNFqOv9GkXKB/uSTtL30HL8xA4t1ZfjAzFi7W8vP5S+ndCYigmrd
 6YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YDzzyttZt2ACMY6s7/wn7fRUYl8HWgLpZeknqVs9FvA=;
 b=OY+RsyiMOnAeSBVi0TbX6WMTHo0sFwz6UQgAeKN5dEyL2CwPl983hAoPSszzk55oI9
 9rCdcDFnYNt4kUDroRt7rdXanVXMdYx6V0WI6VxcnSmrO1zlt//GRRDBccFOGMoMqrD1
 Y3iilzPLhnCjs24MsT/g9VDyu3Uk3PelET8GmK+foNFfclSIdMS6pCGG7HzlZw+r2ETA
 iotCV8JDAd7DWBv1i2wGPOsRVBPw0LJcI4/fA2BBsTNWfhHF3hWEB0ufD12my70ZuIrK
 JdT8S9t1Ovks/WQRaWEctqS3ByN92FMjsLSuEA01HIot+09rnHExdizKjgN0ZySzWlSW
 hqIw==
X-Gm-Message-State: AOAM532DmABV1DC5Q78wwtGsZ0BpL3KfUvYKzan5TH3ZrI+/kfY6gv8K
 S2cJpnIvrfNctAqr6WiXrVs=
X-Google-Smtp-Source: ABdhPJx1T1mTyKZ8gzr3fa6O80iU2ktfHvGNLbk1xfA62ALCJ2ZOxdinG/LQkYrKkYhIEMBAfK+lRA==
X-Received: by 2002:adf:e504:: with SMTP id j4mr2058327wrm.205.1598968109323; 
 Tue, 01 Sep 2020 06:48:29 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id h184sm2055701wmh.41.2020.09.01.06.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 06:48:28 -0700 (PDT)
Subject: Re: [PATCH] sd: sdhci: check data_count is within fifo_buffer
To: P J P <ppandit@redhat.com>
References: <20200827115336.1851276-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <816b3dbe-527f-1bec-a0cf-555e44068a56@amsat.org>
Date: Tue, 1 Sep 2020 15:48:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827115336.1851276-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 1:53 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While doing multi block SDMA, transfer block size may exceed
> the 's->fifo_buffer[s->buf_maxsz]' size. It may leave the
> current element pointer 's->data_count' pointing out of bounds.
> Leading the subsequent DMA r/w operation to OOB access issue.
> Add check to avoid it.
> 
>  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fsdhci_oob_write1

This directory is 3 months old, I can't find it on the list...
Did I missed that or did the list eat the report?

>  ==1459837==ERROR: AddressSanitizer: heap-buffer-overflow
>  WRITE of size 54722048 at 0x61500001e280 thread T3
>     #0  __interceptor_memcpy (/lib64/libasan.so.6+0x3a71d)
>     #1  flatview_read_continue ../exec.c:3245
>     #2  flatview_read ../exec.c:3278
>     #3  address_space_read_full ../exec.c:3291
>     #4  address_space_rw ../exec.c:3319
>     #5  dma_memory_rw_relaxed ../include/sysemu/dma.h:87
>     #6  dma_memory_rw ../include/sysemu/dma.h:110
>     #7  dma_memory_read ../include/sysemu/dma.h:116
>     #8  sdhci_sdma_transfer_multi_blocks ../hw/sd/sdhci.c:629
>     #9  sdhci_write ../hw/sd/sdhci.c:1097
>     #10 memory_region_write_accessor ../softmmu/memory.c:483
>     ...
> 
> Reported-by: Ruhr-University <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

