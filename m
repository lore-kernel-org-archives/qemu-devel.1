Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9490AC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C321214F1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlGltmq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C321214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDppC-000426-F4
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDpoM-0003PO-2y; Thu, 03 Sep 2020 10:01:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDpoJ-0003sl-Ve; Thu, 03 Sep 2020 10:01:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so3360114wrp.8;
 Thu, 03 Sep 2020 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=13WaekktsB6G9WTCTKH58o3wny6AmIkyjQOBODkJsUU=;
 b=KlGltmq6mwgsNzQZDG50dqcKhzBrw043lKKusvxF62immTOFZFnj7XXxuRm8nR43R3
 Dm0Nj+/tK9r4ce2zsDMmymjPbFf8TS99UnWk4ffVVUamR9gy5wx/H0aX1NaLS6Z8wUx6
 l08ZT+uhhbhEGkBhwYu415DTl/mOw/GEMB+sdAWkB3OXwDqsCH5xw7+Msl7U/+joNkJr
 ZblpWxJZThbkxn8gkc9J1y2urPLFVJ/iQxeIcmZmD0ygTzcUhPyz90UFQczQ98cgIzRG
 fjgvPwCplTOsW08kHUU0xS5YLpKvIBc2L9SCVOmLmgTTLasgNKKrVQbXE1IXP/yHwDOI
 h6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=13WaekktsB6G9WTCTKH58o3wny6AmIkyjQOBODkJsUU=;
 b=rNIDKtholUiaGnCTpKKzjj33HZP4qOs3WAeyGrQyLO0chwa3Cc32boOvErejSbNDyI
 KPme8Q0dnxDBGJllLIAFQkL3SJsYoSmzzpmRKRreq8TpUhLQ/ujGo8rFPMPxHaRiL4S+
 LzJ1E9bUmTqpPnNeaJM+3U8ZSv7+rE/eJmdkvUjWoU2FjVAcVqcG5G5Kq/j0ENWz4zkW
 P3X2p+gTXETOrqfwA8G2FlJQbU06O4cUET+1eCmgUKN90q6y+/uHZr6SIExM6dygRcg6
 GiMnz+3GxOCMBxow9XTBW2wOP9aJUthVo/FsW9M8g9bLmc2sMBCxZyugGMXHZhJsRFhA
 ADCg==
X-Gm-Message-State: AOAM533COoLQglERK1IOnJ3T2ZL60SD7P0ljZZ78AC2zM5aGNB7PfnRA
 DVFsEB5DzCs4GR1sGG1+1Co=
X-Google-Smtp-Source: ABdhPJwJbHcZFrdya9FfXPkO8e4NDYgRLo+yM9oH3bocsVaHU29xAgs4LUyItcUmbd5uOIP1UvqPxg==
X-Received: by 2002:adf:f106:: with SMTP id r6mr2693858wro.106.1599141714131; 
 Thu, 03 Sep 2020 07:01:54 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id k84sm4701217wmf.6.2020.09.03.07.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 07:01:53 -0700 (PDT)
Subject: Re: [PATCH v1] sd: sdhci: assert data_count is within fifo_buffer
To: P J P <ppandit@redhat.com>
References: <20200903070842.2125083-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7af91ab-5874-0619-b7c7-5f475ebf07ca@amsat.org>
Date: Thu, 3 Sep 2020 16:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903070842.2125083-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
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

On 9/3/20 9:08 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While doing multi block SDMA, transfer block size may exceed
> the 's->fifo_buffer[s->buf_maxsz]' size. It may leave the
> current element pointer 's->data_count' pointing out of bounds.
> Leading the subsequent DMA r/w operation to OOB access issue.
> Assert that 's->data_count' is within fifo_buffer.
> 
>  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fsdhci_oob_write1
>  ==1459837==ERROR: AddressSanitizer: heap-buffer-overflow
>  WRITE of size 54722048 at 0x61500001e280 thread T3
>  #0  __interceptor_memcpy (/lib64/libasan.so.6+0x3a71d)
>  #1  flatview_read_continue ../exec.c:3245
>  #2  flatview_read ../exec.c:3278
>  #3  address_space_read_full ../exec.c:3291
>  #4  address_space_rw ../exec.c:3319
>  #5  dma_memory_rw_relaxed ../include/sysemu/dma.h:87
>  #6  dma_memory_rw ../include/sysemu/dma.h:110
>  #7  dma_memory_read ../include/sysemu/dma.h:116
>  #8  sdhci_sdma_transfer_multi_blocks ../hw/sd/sdhci.c:629
>  #9  sdhci_write ../hw/sd/sdhci.c:1097
>  #10 memory_region_write_accessor ../softmmu/memory.c:483
>  ...
> 
> Reported-by: Ruhr-University <bugs-syssec@rub.de>
> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/sd/sdhci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Update v1: use assert(3) calls
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg00966.html
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 1785d7e1f7..023acbed41 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -604,6 +604,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>                      s->blkcnt--;
>                  }
>              }
> +            assert(s->data_count <= s->buf_maxsz && s->data_count > begin);
>              dma_memory_write(s->dma_as, s->sdmasysad,
>                               &s->fifo_buffer[begin], s->data_count - begin);
>              s->sdmasysad += s->data_count - begin;
> @@ -626,6 +627,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
>                  s->data_count = block_size;
>                  boundary_count -= block_size - begin;
>              }
> +            assert(s->data_count <= s->buf_maxsz && s->data_count > begin);
>              dma_memory_read(s->dma_as, s->sdmasysad,
>                              &s->fifo_buffer[begin], s->data_count - begin);
>              s->sdmasysad += s->data_count - begin;
> 

qemu-system-i386: hw/sd/sdhci.c:632: void
sdhci_sdma_transfer_multi_blocks(SDHCIState *): Assertion `s->data_count
<= s->buf_maxsz && s->data_count > begin' failed.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

If you don't mind I might split the assert in 2 when applying:

-            assert(s->data_count <= s->buf_maxsz && s->data_count > begin);
+            assert(s->data_count <= s->buf_maxsz);
+            assert(s->data_count > begin);

To directly display the problem straight:

qemu-system-i386: hw/sd/sdhci.c:635: void
sdhci_sdma_transfer_multi_blocks(SDHCIState *): Assertion `s->data_count
> begin' failed.

Thanks,

Phil.

