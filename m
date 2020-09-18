Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1FCC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE8220872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvmOdwOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE8220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBkn-00006J-Vb
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJBjq-0007nf-8q; Fri, 18 Sep 2020 04:27:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJBjo-0005ct-LL; Fri, 18 Sep 2020 04:27:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id z9so4644281wmk.1;
 Fri, 18 Sep 2020 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eXO0wSijbGvC6EIwG3Yxcn6WF4lJBpevedKHEKK4YLs=;
 b=DvmOdwOJmsk0AdAPV02sVPC+ajkV2OcaLcJTbr31v5qfFioE22MTNrNdGysUqsDR2a
 9EKtVNoVH+MtU0hxtb5lf7dwNze5BwAJSeuP/sqMJRPCW+hfoMuYYvky7WsC89BaHyAN
 e4Gsb7fVuZ+2etzUSTd7Q59KVgVVFYP2fHpH+rm1mFPgeiChgQm1GNdybDphbdMqrkyM
 Sm+efkygIAAePtcYhQ/DHxWSjeDcPQi74xnUd4tIWQxprT+biul1ckAb4EvVEMhUE/RB
 7xVDhC2jXWCBU9D8MiVwE513R/7T8tBREKQ6wTCXxBtF+xLvLFsn9IdNSenLmVd7hxBg
 UbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eXO0wSijbGvC6EIwG3Yxcn6WF4lJBpevedKHEKK4YLs=;
 b=aP7HuFzcyZDytnbJP3nejMrRNgy3q1eCdFLrcP6ZsfhvzXFbDw4+pgb2uPxTxUYOHm
 3iE8RcqTjY0sww8SUmpbgAsl5s/59iMaXFV8eM9w2anuNdKNhimOJVHJIrLNxn9mZoyb
 oAUjhIr9+5ECnP5QzjC2QWtIkEDJLqElq4lXYmUJ8PCJQNvzu73U1NVoWuQWRAif8e3c
 +7ySbP3lYHccTXv2i9pu89yEr9+8G7TIajHaA00a29eBjaWM6EnbYcwzJ0vfcSZOB1jf
 ewMijpl3ZQbL1pLq37rHlboLj891g2yaUBYr8Bym9ZU/ki8uBd4Iire/xDGH8JOjoYmE
 eOGQ==
X-Gm-Message-State: AOAM533FkyHEJcLjZQr/nKfv6beCZRm3fjhToH515IP3Keeadazwu/f3
 PjHKYcrVuJZgzuGra1SwpNK0x9fwtXE=
X-Google-Smtp-Source: ABdhPJzvbd6+7Qp1LZZNbti1c0gRZY0oS1b5JsvTyibhfUc549mKGVh9iRiBkv1pnSkudriO5PzMfg==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr15104135wmj.134.1600417642634; 
 Fri, 18 Sep 2020 01:27:22 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u12sm3808528wrt.81.2020.09.18.01.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 01:27:21 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hw/sd/sdhci: Fix DMA Transfer Block Size field
 width
To: qemu-devel@nongnu.org
References: <20200901140411.112150-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6a58eec-c149-ad16-4550-d09f6a162a62@amsat.org>
Date: Fri, 18 Sep 2020 10:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901140411.112150-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 4:04 PM, Philippe Mathieu-Daudé wrote:
> Fix the SDHCI issue reported last week by Alexander:
> https://bugs.launchpad.net/qemu/+bug/1892960
> 
> The field is 12-bit (4KiB) but the guest can set
> up to 16-bit (64KiB), leading to OOB access.
> 
> since v1:
> commited unstaged change in patch #3...
> 
> Philippe Mathieu-Daudé (3):
>   hw/sd/sdhci: Fix qemu_log_mask() format string
>   hw/sd/sdhci: Document the datasheet used
>   hw/sd/sdhci: Fix DMA Transfer Block Size field

Thanks, series applied to my sd-next tree.

