Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660CDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7E9206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="kjClMmaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7E9206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAreY-0004AX-Bl
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kArdt-0003kh-ER
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:22:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kArdr-0006Ks-Oa
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:22:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id x7so1068920wro.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=gY1tLyq5YZCFogtu3sK4Euh2mO8D/sIM5VONVBw5/HY=;
 b=kjClMmaZ23FamUhwdfVUrpt1bLsnVY3YTOEZkrXhnXx0GTWWwq0V1yGBVS4SBW/Rod
 Dl38bAT/PhLRDdCGaZR830vb/Oz2r10Nb/usiaiwRC0hEgHz7P7NcsZhvwlacCCNs92Y
 Wn66SmFGvUugNf1jnhTLPH5v2TKDs+8HEpslzVAlVVOP1D5Wg89jy87OodmOoMDYZbHh
 LZI9Eo6uxHEIa+FjplbcpC14NtRxQlPMneWvC5Xc6XRgck/frongIYL+tTN/h/heysbo
 Waa8s2LslNG39u8jSRN+xwL3YQ0meUgyiT/tLsHy53E8cCDxzGElzveYRH98fBEdzrJr
 SVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=gY1tLyq5YZCFogtu3sK4Euh2mO8D/sIM5VONVBw5/HY=;
 b=AAtSPSQSKzxTkHkAjhlReIOVPAG7fNahdlDaO5sw5s64CXvq5JfA3gdpZdL7RJ1/2S
 yBE/PGNPb5vPh2Xw+UgPh3EYxuBdK1KnmntLVHugmzsQHZQLmoX6wwEo0lKLnWISULok
 ZKdE9sXLs9HZ52aSd+hdApD1+VtX6bTW3Vqob/TZVv0QDbqB3aMx5FEcCKZgvSNcPvsd
 kOE92Rlwb/WplS7EFmVqLX4sp5kR5q7MpOc4kIqHdOS9To14yiu8LFTSA0sf388ZkfNP
 te1lpYxu8jrvLoUjxRKFMbfOuSpiNedsS+nHuM26TWgZsJl7Axr7t58dzxmosDeTuXCS
 6h0g==
X-Gm-Message-State: AOAM532dIBTLrDzLj0xKRDWZty6/yFb3Qf4oTGGXt3kdv4SiXRJJ/sOE
 +dqevf0eoPJL/Xd4mIRzH7XnMA==
X-Google-Smtp-Source: ABdhPJxpZQ1X5UqeC5stprWqJWMcgz1yCieWKOx/Px0VrkijlPaodNG4fI3vLbtIR5j5/i1ZR/InvA==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr11120673wru.358.1598433769443; 
 Wed, 26 Aug 2020 02:22:49 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id c9sm4476491wmf.3.2020.08.26.02.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 02:22:48 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id c7cf1874;
 Wed, 26 Aug 2020 09:22:47 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 02/12] migration/dirtyrate: add DirtyRateStatus to
 denote calculation status
In-Reply-To: <1598260480-64862-3-git-send-email-zhengchuan@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-3-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 10:22:47 +0100
Message-ID: <m2o8mxlq1k.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::442;
 envelope-from=dme@dme.org; helo=mail-wr1-x442.google.com
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

Minor wordsmithing...

On Monday, 2020-08-24 at 17:14:30 +08, Chuan Zheng wrote:

> add DirtyRateStatus to denote calculating status.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>  migration/dirtyrate.c | 22 ++++++++++++++++++++++
>  qapi/migration.json   | 17 +++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 366f4e9..91987c5 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -23,6 +23,19 @@
>  #include "migration.h"
>  #include "dirtyrate.h"
>  
> +static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
> +
> +static int dirtyrate_set_state(int *state, int old_state, int new_state)
> +{
> +    assert(new_state < DIRTY_RATE_STATUS__MAX);
> +    if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
> +        return 0;
> +    } else {
> +        return -1;
> +    }
> +}
> +
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> @@ -32,8 +45,17 @@ static void calculate_dirtyrate(struct DirtyRateConfig config)
>  void *get_dirtyrate_thread(void *arg)
>  {
>      struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
> +    int ret;
> +
> +    ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_UNSTARTED,
> +                              DIRTY_RATE_STATUS_MEASURING);
> +    if (ret == -1) {
> +        return NULL;
> +    }
>  
>      calculate_dirtyrate(config);
>  
> +    ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_MEASURING,
> +                              DIRTY_RATE_STATUS_MEASURED);
>      return NULL;
>  }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5f6b061..d640165 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1720,3 +1720,20 @@
>  ##
>  { 'event': 'UNPLUG_PRIMARY',
>    'data': { 'device-id': 'str' } }
> +
> +##
> +# @DirtyRateStatus:
> +#
> +# An enumeration of dirtyrate status.
> +#
> +# @unstarted: query-dirtyrate thread is not initial.

@unstarted: the dirtyrate thread has not been started.

> +#
> +# @measuring: query-dirtyrate thread is created and start to measure.

@measuring: the dirtyrate thread is measuring.

> +#
> +# @measured:  query-dirtyrate thread is end, we can get result.

@measured: the dirtyrate thread has measured and results are available.

> +#
> +# Since: 5.2
> +#
> +##
> +{ 'enum': 'DirtyRateStatus',
> +  'data': [ 'unstarted', 'measuring', 'measured'] }
> -- 
> 1.8.3.1

dme.
-- 
Tonight I'm gonna bury that horse in the ground.

