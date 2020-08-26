Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61CCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807F12071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="zrowGpLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807F12071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsWr-00080J-RS
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsUy-0005Wm-6F
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:17:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsUw-0005Ar-OK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:17:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id 2so1216182wrj.10
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=3iK+i1We6cZQJy3HPa+d1ZoIZt7Nh5me/hYR+iAvBSE=;
 b=zrowGpLBiesp1lOrw11msyKZfJC0rH8k/igZSjPQEMChKmaG/mJgl57UL9lDGGidap
 wxp57rNZMH2EUJ83tOUzSEspmLLFOyDMGovNEfE7T1bsj/JB1YhhFf0uyurD18ZXtibD
 GOfOx8ZmtZCO88PWVA+V04zu4V01ABOD5JkEhXObzd3g2YPl2eE6uTwi1M1//SkD6yDn
 GEYkSaYZVV+Ck7GBfdW2rWx6gs0p780zTjq+diolV+yxGO7vBR+bmTHEDLm4zI/Ca74N
 2QUeZcNLFhLwUPr28vACHB07T8XeOvjaM9ferKIFFoO/O+BppYzwNLjDIxvadzcyAd2u
 n9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=3iK+i1We6cZQJy3HPa+d1ZoIZt7Nh5me/hYR+iAvBSE=;
 b=Ce7WpOKLi0OzOqBWLFAr4FNNklXU8K5Mbii0On+bIZU8yB1RNur/pYkVQXFFDQHhZ0
 PT5JB6Te144iMQ11hbkJEBSfoXKpgnMkUNr+eD+TI3ntrsHK6Zn5JKXs51n+rh/oDEwR
 0iyw7nbXZ3+pymyuOUdimwtBBMbWf28muMzRC0VRvIE8KmhEa72BIdGHLPtwQTar2f2B
 7rOkP2Xj4613FmbbVUgoHVYilNNTQ1EjV9dQJLUApkmp/hdeX0cE+aKJnIGKNYwmf1mI
 hKugcn7AOufdyLhsWKxlRL6nYeUrGw6QHvftu7izopAoCEuyssNnOYAWShWZ6zEuUGyo
 YMEw==
X-Gm-Message-State: AOAM531lvcTjwpVgrY1981ssVt8qUrtKULEzRgG9DdN7o+YpfDVvpQEj
 gyinxo5bZU/uWOuaybs0TiyQoSmZL2u/C9UlnSo=
X-Google-Smtp-Source: ABdhPJwW+4w/S/qPCpPRjX8+dpPIzjPTU86dRdZa8tKgvy1m5fuizJf3JDzx15PWO0IcG2YIVczM1A==
X-Received: by 2002:adf:f610:: with SMTP id t16mr14045286wrp.97.1598437060968; 
 Wed, 26 Aug 2020 03:17:40 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id q6sm4628528wma.22.2020.08.26.03.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 03:17:40 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 9bcedd12;
 Wed, 26 Aug 2020 10:17:39 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 09/12] migration/dirtyrate: Implement
 get_sample_page_period() and block_sample_page_period()
In-Reply-To: <1598260480-64862-10-git-send-email-zhengchuan@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-10-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 11:17:39 +0100
Message-ID: <m23649lni4.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::441;
 envelope-from=dme@dme.org; helo=mail-wr1-x441.google.com
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

On Monday, 2020-08-24 at 17:14:37 +08, Chuan Zheng wrote:

> Implement get_sample_page_period() and set_sample_page_period() to
> sleep specific time between sample actions.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>  migration/dirtyrate.c | 24 ++++++++++++++++++++++++
>  migration/dirtyrate.h |  2 ++
>  2 files changed, 26 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index bd398b7..d1c0a78 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -28,6 +28,30 @@
>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
>  static struct DirtyRateStat DirtyStat;
>  
> +static int64_t set_sample_page_period(int64_t msec, int64_t initial_time)
> +{
> +    int64_t current_time;
> +
> +    current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if ((current_time - initial_time) >= msec) {
> +        msec = current_time - initial_time;
> +    } else {
> +        g_usleep((msec + initial_time - current_time) * 1000);
> +    }
> +
> +    return msec;
> +}
> +
> +static int64_t get_sample_page_period(int64_t sec)
> +{
> +    if (sec <= MIN_FETCH_DIRTYRATE_TIME_SEC ||

Shouldn't the minimum value be allowed?

That is, this test should be "sec < MIN_FETCH_DIRTYRATE_TIME_SEC" and
MIN_FETCH_DIRTYRATE_TIME_SEC should be 1.

> +        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
> +        sec = DEFAULT_FETCH_DIRTYRATE_TIME_SEC;
> +    }
> +
> +    return sec;
> +}
> +
>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>  {
>      assert(new_state < DIRTY_RATE_STATUS__MAX);
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 41bc264..50a5636 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -51,6 +51,8 @@
>  
>  /* Take 1s as default for calculation duration */
>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
> +#define MIN_FETCH_DIRTYRATE_TIME_SEC              0
> +#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
>  
>  struct DirtyRateConfig {
>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
> -- 
> 1.8.3.1

dme.
-- 
Facts don't do what I want them to.

