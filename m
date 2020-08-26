Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90514C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD06206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="GFoylxmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD06206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsQV-0001TT-ML
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsPv-0000tL-NV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:12:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsPu-0004SE-7C
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:12:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id c15so1194917wrs.11
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=RlOLEeFqoNCCTp4IjynWPIJsEAOOe/5UsKpjZ8mPxbY=;
 b=GFoylxmwbd++AGQyTHd76KTagSqRb75qItAy+oH8mJgmABW1Il6YxFqM/FSjUKCmMl
 ScwT7VgNROTOOVOqqN13mynyhtyOiJ9r76PPq8tWbUqjjIWwDdKvKkypmh2lr2oylqR+
 QEAgaZszTWlHt5DxikiMcWkgvefNDVTKOswDUjeTscr96Y2XP5CFnQMb/2sfH2+5/95I
 XRJxTgo7O1yGdOs64q+8FskyG/AyAaFBs3FjWbHXjYl+OQ5yl3RQt4xCZKpuROvu3v8N
 2Y9oiOVSyAnrxfRMUAokFf5V/diCZAR0C9oR08mV0I5UHE61Sx2R9je6+SkldUEwtYXs
 PNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=RlOLEeFqoNCCTp4IjynWPIJsEAOOe/5UsKpjZ8mPxbY=;
 b=Juwz+2P5eq7c55660kaiIWMaM7q38L62MDhx2JA71FxhVFI6Krq7V1nstrEW8gK17F
 emQ08lukLAMrmmEHkHuo3BNfQ43gI2H3ZL/1uDRcZGIgbo6V7djznaYMboh3O8PY1iMV
 LRgg3piIRP9CkMqzHKZw0Rx3hI4Rg0yPuZUA3V3XXeqIUaQS6LCmdT/cLK6HFXgF/8+Z
 PNnMlkHE79VemgzLG1iGQW2juq585ZbPaxMw9Tvgv0gTdr/tDkCCvIdpYxwjTWyIWZyi
 t5Rd1ein4o3Ya07kciMaJH40EcqR4VYyrClDkbVLoKeNLYfCapquOa6Oat0fUEMtO/lf
 fCmw==
X-Gm-Message-State: AOAM533vQa/42OwqUGVQfTm0oQv2LzxPfEMb3qq2o46ECLUYqkaVugmN
 CD7BCFXcSx1Rw+HpDoM/ibG5Gw==
X-Google-Smtp-Source: ABdhPJxn5lljTptcAfISkrrXeyxPDE0rVAVPdwsy0neHFDN/xTXaeE38st/k49y2XWBsLG4Pgt2Myg==
X-Received: by 2002:adf:db43:: with SMTP id f3mr16059669wrj.219.1598436748806; 
 Wed, 26 Aug 2020 03:12:28 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id r16sm5551383wrv.33.2020.08.26.03.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 03:12:28 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 6701e96f;
 Wed, 26 Aug 2020 10:12:27 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 08/12] migration/dirtyrate: skip sampling ramblock
 with size below MIN_RAMBLOCK_SIZE
In-Reply-To: <1598260480-64862-9-git-send-email-zhengchuan@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-9-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 11:12:27 +0100
Message-ID: <m25z95lnqs.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::443;
 envelope-from=dme@dme.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-08-24 at 17:14:36 +08, Chuan Zheng wrote:

> In order to sample real RAM, skip ramblock with size below MIN_RAMBLOCK_SIZE
> which is set as 128M.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>  migration/dirtyrate.c | 24 ++++++++++++++++++++++++
>  migration/dirtyrate.h | 10 ++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 050270d..bd398b7 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -173,6 +173,24 @@ alloc_ramblock_dirty_info(int *block_index,
>      return block_dinfo;
>  }
>  
> +static int skip_sample_ramblock(RAMBlock *block)
> +{
> +    int64_t ramblock_size;
> +
> +    /* ramblock size in MB */
> +    ramblock_size = qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SHIFT_MB;
> +
> +    /*
> +     * Consider ramblock with size larger than 128M is what we
> +     * want to sample.
> +     */
> +    if (ramblock_size < MIN_RAMBLOCK_SIZE) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>                                       struct DirtyRateConfig config,
>                                       int *block_index)
> @@ -183,6 +201,9 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>      int index = 0;
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block) < 0) {
> +            continue;
> +        }
>          dinfo = alloc_ramblock_dirty_info(&index, dinfo);
>          if (dinfo == NULL) {
>              return -1;
> @@ -249,6 +270,9 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
>      RAMBlock *block = NULL;
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block) < 0) {
> +            continue;
> +        }
>          block_dinfo = NULL;
>          if (!find_page_matched(block, info, block_index + 1, &block_dinfo)) {
>              continue;
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 5050add..41bc264 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -35,10 +35,20 @@
>  #define DIRTYRATE_PAGE_SHIFT_KB                   12
>  
>  /*
> + * Sample page size MB shift
> + */
> +#define DIRTYRATE_PAGE_SHIFT_MB                   20
> +
> +/*
>   * Sample page size 1G shift
>   */
>  #define DIRTYRATE_PAGE_SHIFT_GB                   30
>  
> +/*
> + * minimum ramblock size to sampled

"Minimum RAMBlock size to sample, in megabytes."

> + */
> +#define MIN_RAMBLOCK_SIZE                         128
> +
>  /* Take 1s as default for calculation duration */
>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>  
> -- 
> 1.8.3.1

dme.
-- 
I went starin' out of my window, been caught doin' it once or twice.

