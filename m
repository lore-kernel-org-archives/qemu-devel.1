Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4154C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D38820780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRQeESsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D38820780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4nd-0005vj-SS
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 21:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jq4ma-0005Lj-Ra; Mon, 29 Jun 2020 21:09:56 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jq4mY-0004gt-QW; Mon, 29 Jun 2020 21:09:56 -0400
Received: by mail-io1-xd44.google.com with SMTP id m81so19282708ioa.1;
 Mon, 29 Jun 2020 18:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SHz87V7dIZrshDxwiNROVV+HaOi4iIKGHix/vBfscjQ=;
 b=DRQeESsmidoxpYq0Y6o9GXe57TDd5t0o3VZ1TlueROGgQ6dYsuaIP/lKR6OlAVONBe
 o7GIzcvDsmN6N6q76yAGBK4IfrCi+u6CF7kdpspW3tfGhPLXq/PaJj68+e4WNNKLKMRx
 tlxOtqKstuFV02aB3zyliOUCNwomozF8R3hDP4g1wMPmpqqkuzoSkaYMoDtaA1AWShXK
 5C93ua1ATFvMQcSynia+oNcG2rGKjWbaFlngG5tsvlIVRchXrPTWcaDq82i1PKkYAybe
 0pGtuxAWFixQR17PHbFF3Tk7XdB3ld3zCeRpTBv1solPu/dPefvxYJudsy67k4MDUTcU
 Qpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SHz87V7dIZrshDxwiNROVV+HaOi4iIKGHix/vBfscjQ=;
 b=DzalJeKnF5hTM/wOmckfuk+QyIksX+Qu5fHX5mkOgtFVub5lUB7ZekTs/HBUoLyGPY
 RQoBtk/Qgow7nHZ0CjwhkuN4VEylzUds9qOVVf9vd4uU/ZQ21/oXLAMQAiNW5MH3aZSt
 EideH7y/Ef5ZizGtoiRxAOITQ6s2kdiZb9iwcWpKl8lEQPohzUvNKf+NBSIyimw+ShmZ
 JSHdWAbdN6kIZiq0x9EFxt6QqggRzgmqFsmBwAZYADEn3JjYSsQ4gXef2Tx10LbqVQ5m
 JEw1UaPBUm05PmwhD9OIhQQ8Mma0URQ1+U1y/OWl20vk2MBkr4zAAJhyXlVYpi60hzZn
 nbmw==
X-Gm-Message-State: AOAM5335veTs6kkSJ1ovmffOITuI+RI3rr1HqOec555ku6Jra+OU3Tei
 jv9UWrYqokfrYGI6TTqG2/xpztecpJIEqc0wQ2w=
X-Google-Smtp-Source: ABdhPJybcu9h85IqWYf6kpVHcY6V9+vKNW0TPkFgDDHtcE3VGB1lI//PDdyU6IfBnFrnA8kjcdZbq18kSe9guJq/a7E=
X-Received: by 2002:a02:1a06:: with SMTP id 6mr21248521jai.8.1593479393502;
 Mon, 29 Jun 2020 18:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-4-dmitry.fomichev@wdc.com>
In-Reply-To: <20200617213415.22417-4-dmitry.fomichev@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2020 18:00:11 -0700
Message-ID: <CAKmqyKPc1J+D5Yih0SamWD40GrVhyV75ogG5D5W8dv9ywaA3=g@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] hw/block/nvme: Clean up unused AER definitions
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 2:48 PM Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
>
> Removed unused struct NvmeAerResult and SMART-related async event
> codes. All other event codes are now categorized by their type.
> This avoids having to define the same values in a single enum,
> NvmeAsyncEventRequest, that is now removed.
>
> Later commits in this series will define additional values in some
> of these enums. No functional change.
>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/nvme.h      |  1 -
>  include/block/nvme.h | 43 ++++++++++++++++++++++---------------------
>  2 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 0460cc0e62..4f0dac39ae 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -13,7 +13,6 @@ typedef struct NvmeParams {
>
>  typedef struct NvmeAsyncEvent {
>      QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
> -    NvmeAerResult result;
>  } NvmeAsyncEvent;
>
>  enum NvmeRequestFlags {
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 9c3a04dcd7..3099df99eb 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -553,28 +553,30 @@ typedef struct NvmeDsmRange {
>      uint64_t    slba;
>  } NvmeDsmRange;
>
> -enum NvmeAsyncEventRequest {
> -    NVME_AER_TYPE_ERROR                     = 0,
> -    NVME_AER_TYPE_SMART                     = 1,
> -    NVME_AER_TYPE_IO_SPECIFIC               = 6,
> -    NVME_AER_TYPE_VENDOR_SPECIFIC           = 7,
> -    NVME_AER_INFO_ERR_INVALID_SQ            = 0,
> -    NVME_AER_INFO_ERR_INVALID_DB            = 1,
> -    NVME_AER_INFO_ERR_DIAG_FAIL             = 2,
> -    NVME_AER_INFO_ERR_PERS_INTERNAL_ERR     = 3,
> -    NVME_AER_INFO_ERR_TRANS_INTERNAL_ERR    = 4,
> -    NVME_AER_INFO_ERR_FW_IMG_LOAD_ERR       = 5,
> -    NVME_AER_INFO_SMART_RELIABILITY         = 0,
> -    NVME_AER_INFO_SMART_TEMP_THRESH         = 1,
> -    NVME_AER_INFO_SMART_SPARE_THRESH        = 2,
> +enum NvmeAsyncEventType {
> +    NVME_AER_TYPE_ERROR                     = 0x00,
> +    NVME_AER_TYPE_SMART                     = 0x01,
> +    NVME_AER_TYPE_NOTICE                    = 0x02,
> +    NVME_AER_TYPE_CMDSET_SPECIFIC           = 0x06,
> +    NVME_AER_TYPE_VENDOR_SPECIFIC           = 0x07,
>  };
>
> -typedef struct NvmeAerResult {
> -    uint8_t event_type;
> -    uint8_t event_info;
> -    uint8_t log_page;
> -    uint8_t resv;
> -} NvmeAerResult;
> +enum NvmeAsyncErrorInfo {
> +    NVME_AER_ERR_INVALID_SQ                 = 0x00,
> +    NVME_AER_ERR_INVALID_DB                 = 0x01,
> +    NVME_AER_ERR_DIAG_FAIL                  = 0x02,
> +    NVME_AER_ERR_PERS_INTERNAL_ERR          = 0x03,
> +    NVME_AER_ERR_TRANS_INTERNAL_ERR         = 0x04,
> +    NVME_AER_ERR_FW_IMG_LOAD_ERR            = 0x05,
> +};
> +
> +enum NvmeAsyncNoticeInfo {
> +    NVME_AER_NOTICE_NS_CHANGED              = 0x00,
> +};
> +
> +enum NvmeAsyncEventCfg {
> +    NVME_AEN_CFG_NS_ATTR                    = 1 << 8,
> +};
>
>  typedef struct NvmeCqe {
>      union {
> @@ -881,7 +883,6 @@ enum NvmeIdNsDps {
>
>  static inline void _nvme_check_size(void)
>  {
> -    QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 4);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeCmd) != 64);
> --
> 2.21.0
>
>

