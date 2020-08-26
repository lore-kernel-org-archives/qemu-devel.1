Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65228C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AC120786
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="Og/EXjSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AC120786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArkn-0000HG-BT
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kArkH-0008IZ-Up
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:29:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kArkG-00072q-DV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:29:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id c19so1149231wmd.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=y7hxvK7Uy9vFey1s15j1e8je+7JJ5C9O3obpNponljM=;
 b=Og/EXjSdlD5VO4aPBPIZpAt5cdKX5dgfjaNiSy+2L/8BHuvKLCojoYKyQfm1TDCE4R
 7lqFA7c1N7L8GweQH0Qf+wZ0VR48wON3aVmab2mBLRduOeTxDV5Lr+uRjTwSsnPJK12h
 j35YAMyqe4nE9Xh0CKypSeOU1lTnKK24JwWLw5p/a8Pp4kpkG613cPESzhZCTMOxwVIn
 nAq58iAtqmW/mqtpNUObvlj76sWrb5vGSyIifw4L6GSI+dgmTekq44VCsT0rKZX3PhvQ
 EsJKOdgupgdNlL0mx+xfQgq7AJwlQlRndUikO0qBBBFpGbUGo2eh7qOghB6RMeGJIh3E
 HADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=y7hxvK7Uy9vFey1s15j1e8je+7JJ5C9O3obpNponljM=;
 b=piCKAkPXQBpMEkGoKNcadJj59cFcm4gdZDeF0Thvtdb8hSgI4V018obdrtQvOGyRWZ
 pJV1F5Jedcgd2dEUsXEjOWe3JOpLRNNrNmoYEOBfEe0IdkhzcXd0961PKyEJDsJn46E2
 jtzCUx4N2WxW6BQVclFIpPxTtJXnNbQtabTaYrzyV6tSpn+vkwQftT1fG8gNtL1V4bT2
 FGGcoZ/WiOBRv6TD9X6IiQIl173UkgJtn2lkwqbQFq1uNUyST2ttCoucOEa1Ppg90JOF
 sR8c6Z5J2foAS0qflVEhJ7a3lPDGUjFaavk9r5Wht9Mhmogh+y01Quuu8KvE0ZRVstP3
 cfKw==
X-Gm-Message-State: AOAM532hrUGDCdeXEo6nFKqa+ACTfb8Isjl5rN5FRMpNgrA506OT+Gd0
 asXKgZgsNxBN947goUfWSkGnWQ==
X-Google-Smtp-Source: ABdhPJy0ux7pUBFg4DYiPl+3qVFsKqcFQ9S/1kh3AUd8ZK1UTunJ/HQpgVtROtMLa/O8mWNablZR4Q==
X-Received: by 2002:a1c:e006:: with SMTP id x6mr6555798wmg.128.1598434166832; 
 Wed, 26 Aug 2020 02:29:26 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id o2sm4261184wrj.21.2020.08.26.02.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 02:29:25 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 21f86949;
 Wed, 26 Aug 2020 09:29:24 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 03/12] migration/dirtyrate: Add RamlockDirtyInfo to
 store sampled page info
In-Reply-To: <1598260480-64862-4-git-send-email-zhengchuan@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-4-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 10:29:24 +0100
Message-ID: <m2lfi1lpqj.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::341;
 envelope-from=dme@dme.org; helo=mail-wm1-x341.google.com
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

On Monday, 2020-08-24 at 17:14:31 +08, Chuan Zheng wrote:

> Add RamlockDirtyInfo to store sampled page info of each ramblock.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>  migration/dirtyrate.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 33669b7..70000da 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -19,6 +19,11 @@
>   */
>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
>  
> +/*
> + * Record ramblock idstr
> + */
> +#define RAMBLOCK_INFO_MAX_LEN                     256
> +
>  /* Take 1s as default for calculation duration */
>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>  
> @@ -27,6 +32,19 @@ struct DirtyRateConfig {
>      int64_t sample_period_seconds; /* time duration between two sampling */
>  };
>  
> +/*
> + * Store dirtypage info for each ramblock.
> + */
> +struct RamblockDirtyInfo {
> +    char idstr[RAMBLOCK_INFO_MAX_LEN]; /* idstr for each ramblock */
> +    uint8_t *ramblock_addr; /* base address of ramblock we measure */
> +    uint64_t ramblock_pages; /* ramblock size in 4K-page */

It's probably a stupid question, but why not store a pointer to the
RAMBlock rather than copying some of the details?

> +    uint64_t *sample_page_vfn; /* relative offset address for sampled page */
> +    uint64_t sample_pages_count; /* count of sampled pages */
> +    uint64_t sample_dirty_count; /* cout of dirty pages we measure */

"cout" -> "count"

> +    uint32_t *hash_result; /* array of hash result for sampled pages */
> +};
> +
>  void *get_dirtyrate_thread(void *arg);
>  #endif
>  
> -- 
> 1.8.3.1

dme.
-- 
Please forgive me if I act a little strange, for I know not what I do.

