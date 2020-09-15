Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F39C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D322068D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM5VTIEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D322068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDgO-0006l8-1p
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDf1-0005iD-3h
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:18:27 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDez-0003UI-KQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:18:26 -0400
Received: by mail-oi1-x243.google.com with SMTP id n2so4534918oij.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eZxWE3pQjl4YdFvM8EZubAcZA23HLoUqr6tK+o271pg=;
 b=BM5VTIEb5f+TNd9ntUbmX1urqRamKC92FS1lR2uTpS0rzE+/HipJwPnHLbilnCXgpA
 rygz85q45SdGP6M7/AN/mxc/7c3l0BfyJbKixNbBMM5NXaLJ97XpN1r/QwBu1Dl0QHe0
 u5+r6bVOzVEWqIkH4Aa1USdOJ1UYZLuM/cANVDgnGx6ydv+Hj3vDwtqpPoZKZINVWdJk
 VAEXm/oF4qv2nPhuWW+7qWT/7fPPv2dxciDP/akp6RfDZOja2Ntihmjv7zGza8M+q/ZC
 7dDYq7nfFChuNCy7bqe+WHjLPezUL0p9zBn8+j3LPQXWP4QbX960OuBFdqQs/ST5hf/6
 oCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eZxWE3pQjl4YdFvM8EZubAcZA23HLoUqr6tK+o271pg=;
 b=mxt1fx4NnaKX5R4A0EWAzsjQTXeYDBBCA/OCfr8kw5OeCc7Zl/bF21uG/01MlQsDDI
 XkBfihZYX1xsLuyhR/V1lTcNqJRT1+GNKn3Ol2u8iI0DJ/3zJ4d6X1Q3pxfpk6K9EXj9
 KfEqdrNUUMrdMe+L5H7lKQBdQKEo2mKWFzik3AfQmBswHB4nZAd+gLJkXwOg6DxEJYXF
 nlmLWeZUReGc0A9N7TFH8zAPn6ZChJrk/G+f57+Jyw8bn7xN3JNQv5KfTSee+gReDjOK
 gXzSDfhch/evCnT4+JQeTyO3Hm7/IYtvqstz+rJsJTa7DRspraSBdQJ76TQHXSstf931
 eHJw==
X-Gm-Message-State: AOAM530DtFyxldDMvSh3JZbuM5DjL/REywYcEs838r/DorNPh2uAynWW
 0CBPuhrIlD6aX/aCTK6dKyax+dTebdenSsPmfho=
X-Google-Smtp-Source: ABdhPJxMVeSnZP1Xih8eqUkQ7kFwYqsLf/aaQE3j6929ZVmIXhZCx/1dxg00xLx/kjgFxHAQOewzx4JXCKDujlbzLB0=
X-Received: by 2002:aca:904:: with SMTP id 4mr114472oij.97.1600186701473; Tue,
 15 Sep 2020 09:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-4-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-4-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:17:45 +0800
Message-ID: <CAKXe6SJRZKweELs8O+M9BbNT1pP+3MCG67FmC1yPXViE+Tip2A@mail.gmail.com>
Subject: Re: [PATCH v9 03/12] migration/dirtyrate: Add RamblockDirtyInfo to
 store sampled page info
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, yuxiating@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Add RamblockDirtyInfo to store sampled page info of each ramblock.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/dirtyrate.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 5be9714..479e222 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -19,11 +19,29 @@
>   */
>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
>
> +/*
> + * Record ramblock idstr
> + */
> +#define RAMBLOCK_INFO_MAX_LEN                     256
> +
>  struct DirtyRateConfig {
>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>      int64_t sample_period_seconds; /* time duration between two sampling=
 */
>  };
>
> +/*
> + * Store dirtypage info for each ramblock.
> + */
> +struct RamblockDirtyInfo {
> +    char idstr[RAMBLOCK_INFO_MAX_LEN]; /* idstr for each ramblock */
> +    uint8_t *ramblock_addr; /* base address of ramblock we measure */
> +    uint64_t ramblock_pages; /* ramblock size in TARGET_PAGE_SIZE */
> +    uint64_t *sample_page_vfn; /* relative offset address for sampled pa=
ge */
> +    uint64_t sample_pages_count; /* count of sampled pages */
> +    uint64_t sample_dirty_count; /* count of dirty pages we measure */
> +    uint32_t *hash_result; /* array of hash result for sampled pages */
> +};
> +
>  void *get_dirtyrate_thread(void *arg);
>  #endif
>
> --
> 1.8.3.1
>

