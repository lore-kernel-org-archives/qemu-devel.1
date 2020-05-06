Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C27C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36A320714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8kedB2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36A320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIQO-00034f-5l
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 07:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWIOx-0001uM-Bo; Wed, 06 May 2020 07:39:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWIOw-0000GT-Lw; Wed, 06 May 2020 07:39:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id y4so1773382wrm.11;
 Wed, 06 May 2020 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KKHgCP+iHc+SKiHkbPN/nSorkFA7/T4CCDdYvJxSM0o=;
 b=D8kedB2c+9xqws30YyBhXuuAGviEaZYWuCWaWWc9QHYCHFWT1W5fBj3JTC7Ujx5S19
 dFpaa0rzfYp9k6gpB7I99qTvh8dtH4wpAVRHykpw8S5KSNy+plmIADWzyw1iqKVL/Kvn
 F0gwwid4fkNyzGa8kKEBJ3TvWOjlG2QkyfnUUDnLrU79AmlPAgWO+xhcVlbgt5Ruzgxe
 85QaIn1BXj4BvwuU/SkxcTNt5TOrx0GEHrd/6CmlY0uDVwWgG4qwD5SHyYGeR9RgUtp2
 BmyZzaNO79jfOESfawvz/0X89f4sU+wTAKuyVXgYTFanac9Dh5Y+KBsDf2wfObyCySsC
 ZE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KKHgCP+iHc+SKiHkbPN/nSorkFA7/T4CCDdYvJxSM0o=;
 b=X3UPsci2FQyJ2/9U0vX70WFd+IUMUI5wuDkPxCBKQNrIkto3SZt05YHO0J4OG63+Ho
 n71I49OsSc/dV0AQcwuztiSLg4HgiVavWlLvBjKf5PS/JonvLKLnxHWWjQyc8UiwlwSh
 AmVz03AszuLtmLnuu4Ohs5DpPib+hG/D6kWjKbufTvlRDkpVaCPPTQvIlLqE2Sf9ZT8M
 R/X/lcih3VZOcvTce1Ufhg9PoE+Lw+OKjOltfkh8rNiBsbH1Du4nAb13M6YmE2hn8Fin
 NxIlLa6SkYJ4zGQpBvyEPVxtwDK/99oFOCPLzW39RP6MQT+ZMHs5jQt6MZMGQRykFI+y
 Ls/A==
X-Gm-Message-State: AGi0PuZgkDMY74A/fTp7PM53VhHV9YwW+96eKR5HJ4L5dzoRDykDMaUJ
 lS31gi9vsGDNHw1vY1z+AJk=
X-Google-Smtp-Source: APiQypI6v4wjXMtz2zywlwmTNHsi8ac7foliXScDBA3tSZLT+G7i1oDOfDBEPnWcfp7CkeLms6FbkQ==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr5667802wrr.260.1588765182558; 
 Wed, 06 May 2020 04:39:42 -0700 (PDT)
Received: from [192.168.1.37] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 88sm2389294wrq.77.2020.05.06.04.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2020 04:39:41 -0700 (PDT)
Subject: Re: [PATCH v2 3/9] hw/net/xilinx_axienet: Remove unncessary cast
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
 <20200506082513.18751-4-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8022a626-f81e-a39d-f6f9-9259e2c99267@amsat.org>
Date: Wed, 6 May 2020 13:39:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200506082513.18751-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, figlesia@xilinx.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 10:25 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Remove unncessary cast, buf is already uint8_t *.

Typo "unnecessary" here and in patch subject.
Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> No functional change.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   hw/net/xilinx_axienet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 84073753d7..c8dfcda3ee 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -918,7 +918,7 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size)
>           uint16_t csum;
>   
>           tmp_csum = net_checksum_add(size - start_off,
> -                                    (uint8_t *)buf + start_off);
> +                                    buf + start_off);
>           /* Accumulate the seed.  */
>           tmp_csum += s->hdr[2] & 0xffff;
>   
> 

