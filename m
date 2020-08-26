Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220572071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="uczUQVBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220572071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAse1-0005v9-Af
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsdM-0005UC-Qv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:26:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAsdL-0006be-9Q
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:26:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id o21so1238889wmc.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=7cPVXoBzLf32DPlSxx2fzPXG290u10vq6V2t2E9oL9s=;
 b=uczUQVBB5BPbsF7iZQ0IYKeSdSavc6KHrCTKVPorrXekkuPfP703T2rQLAn2c9EBIR
 sJ4TrEFly+1UCdF1TSnqjPVYSQ7aTwCNFqDugBUqaWOz6EPM6WTgWUtrqCbn9q6jYImZ
 Z8kBAz5jdc+4mTV5ISMCqOf2c3zLbHotzophDXdTjFbmb08qQ0pQQN8bjMMlu6ea1e/B
 BUUr9+ZaedpyO73OmM3UtQrWfC5e6vG4RNa1Zv7AxxDpC67knh2DvWMosnCvx2Fb7eJD
 b348xVogdCCyaTpxwPTndO/+KQpnZTv7w9m8BNUwqlIW+xiTRWw+mxml3S2V2pD1Gvs0
 pwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=7cPVXoBzLf32DPlSxx2fzPXG290u10vq6V2t2E9oL9s=;
 b=NNCz1oIekNXyMNIK6DLjtNHlk7JWe5TrNpsyvvDBa+pHcyWqJcA7RIyKxaZ79bjr7D
 XT98MPGOzFfjUdR2rnbfPu7HHEnLtThjwZbSQOQLMff72tOtxCo8XCt64BShl6GVgHD9
 LbE8DaUU/TWfn2ZAmqISU/MiO0+6xJ1PKNZj1V8b2M+T1n2CTSLzqQn1Pm0SQie9Okk7
 DIpt/s02T4UHKiLgQNst0IvwaUx2ddtNQ2sAOJggINGT960pp+A1Y3pp5Qn2ziYpv7L0
 lmWeAqdz1MXOxM5qLE02miyHKk0An/Biob3qzudTFr+lOPxx47QfgxPaNvp+c11pk4fg
 KxuA==
X-Gm-Message-State: AOAM531UewddSQom64T2pYuQG0pSVrZNq6GD4rDGt8Rpa60khkbFCpUY
 5lSbjwZOC4EKHq/xKnzSN/99Bw==
X-Google-Smtp-Source: ABdhPJynHvkuCyqv8nYE3QplFiFhsBUqpexYpJLxpp5XqfUjuvk5KsITWBD8UsqfgEYozCYErY+exQ==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr6201452wmc.42.1598437579893; 
 Wed, 26 Aug 2020 03:26:19 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id z8sm4423385wmf.10.2020.08.26.03.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 03:26:19 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id cffc4fb8;
 Wed, 26 Aug 2020 10:26:18 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
In-Reply-To: <1598260480-64862-12-git-send-email-zhengchuan@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-12-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 11:26:18 +0100
Message-ID: <m2wo1lk8j9.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::342;
 envelope-from=dme@dme.org; helo=mail-wm1-x342.google.com
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

On Monday, 2020-08-24 at 17:14:39 +08, Chuan Zheng wrote:

> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  qapi/migration.json   | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 9f52f5f..08c46d3 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -62,6 +62,28 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
>      }
>  }
>  
> +static struct DirtyRateInfo *query_dirty_rate_info(void)
> +{
> +    int64_t dirty_rate = DirtyStat.dirty_rate;
> +    struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
> +
> +    if (CalculatingState == DIRTY_RATE_STATUS_MEASURED) {
> +        info->dirty_rate = dirty_rate;
> +    } else {
> +        info->dirty_rate = -1;
> +    }
> +
> +    info->status = CalculatingState;
> +    /*
> +     * Only support query once for each calculation,
> +     * reset as DIRTY_RATE_STATUS_UNSTARTED after query
> +     */
> +    (void)dirtyrate_set_state(&CalculatingState, CalculatingState,
> +                              DIRTY_RATE_STATUS_UNSTARTED);

Is there a reason for this restriction? Removing it would require
clarifying the state model, I suppose.

> +
> +    return info;
> +}
> +
>  static void reset_dirtyrate_stat(void)
>  {
>      DirtyStat.total_dirty_samples = 0;
> @@ -378,3 +400,26 @@ void *get_dirtyrate_thread(void *arg)
>                                DIRTY_RATE_STATUS_MEASURED);
>      return NULL;
>  }
> +
> +void qmp_calc_dirty_rate(int64_t calc_time, Error **errp)
> +{
> +    static struct DirtyRateConfig config;
> +    QemuThread thread;
> +
> +    /*
> +     * We don't begin calculating thread only when it's in calculating status.

"If the dirty rate is already being measured, don't attempt to start."

> +     */
> +    if (CalculatingState == DIRTY_RATE_STATUS_MEASURING) {

Should this return an error to the caller?

> +        return;
> +    }
> +
> +    config.sample_period_seconds = get_sample_page_period(calc_time);

If the specified sample period is outside the min/max, should an error
be returned to the caller?

> +    config.sample_pages_per_gigabytes = DIRTYRATE_DEFAULT_SAMPLE_PAGES;
> +    qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
> +                       (void *)&config, QEMU_THREAD_DETACHED);
> +}
> +
> +struct DirtyRateInfo *qmp_query_dirty_rate(Error **errp)
> +{
> +    return query_dirty_rate_info();
> +}
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d640165..826bfd7 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1737,3 +1737,47 @@
>  ##
>  { 'enum': 'DirtyRateStatus',
>    'data': [ 'unstarted', 'measuring', 'measured'] }
> +
> +##
> +# @DirtyRateInfo:
> +#
> +# Information about current dirty page rate of vm.
> +#
> +# @dirty-rate: @dirtyrate describing the dirty page rate of vm
> +#          in units of MB/s.
> +#          If this field return '-1', it means querying is not
> +#          start or not complete.
> +#
> +# @status: status containing dirtyrate query status includes
> +#          'unstarted' or 'measuring' or 'measured'
> +#
> +# Since: 5.2
> +#
> +##
> +{ 'struct': 'DirtyRateInfo',
> +  'data': {'dirty-rate': 'int64',
> +           'status': 'DirtyRateStatus'} }
> +
> +##
> +# @calc-dirty-rate:
> +#
> +# start calculating dirty page rate for vm
> +#
> +# @calc-time: time in units of second for sample dirty pages
> +#
> +# Since: 5.2
> +#
> +# Example:
> +#   {"command": "cal-dirty-rate", "data": {"calc-time": 1} }

"cal-dirty-rate" -> "calc-dirty-rate".

> +#
> +##
> +{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64'} }
> +
> +##
> +# @query-dirty-rate:
> +#
> +# query dirty page rate in units of MB/s for vm
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
> -- 
> 1.8.3.1

dme.
-- 
I'm going in the out door, I'm doing all right.

