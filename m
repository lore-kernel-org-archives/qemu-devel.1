Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D826BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2302177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="vHPIayF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2302177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGYz-0000GP-PJ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBGYS-0008E4-0L
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:58:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBGYQ-0000Az-3c
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:58:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so5125040wrw.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 04:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=43pDmx6xDr2/6/hSxSmqLMTU81W7iOibc3api6w9ueM=;
 b=vHPIayF4D1xjtBe4K3Ok2pnUn/jDW7L82IS+UOs2WPjW/bXCMCapILcS1iT6QLMzku
 a5h/OZpCtSCEzwMWprlQWpSKCojRzzbuTeFbkiPQPvzLLXfk7/7F4aKHvD40de75hFjn
 fo0dXnOoCPMjjmMucL7s9gNTX+v1zTV5ytK8UfR7iN/wk4MNhLdC5iRyGWfZLAZX4UN/
 3M0euvqxnw3iBH7bAaea3t79fUN3nqZ3UKq/UNYi2+Xk+FS/A3zg7fdW+r2Elu0NIzT/
 9DZ0TccTFGokFinnkYZ+dHBsOLYYxx28GvooTZH8KYEKEUPN1s4Q4oHgUsjIfPCelryB
 RoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=43pDmx6xDr2/6/hSxSmqLMTU81W7iOibc3api6w9ueM=;
 b=RPh0Wx9eQ4Boz0fllfxhvpEbsp1eZjZki4GzR2RHHL5ZSIVdEmCmyiHemAXBQaq/S5
 HskDtylRZzKwFmMWX6jnpcyBotqZFtX4V1TULnERgMJHTdf81MQ5qa4kbCEg2zl+pdik
 fzLLaOXzMZwnSn9tTeC9trsv0kKYljA2SOS0fzQUj4NNnYQhvtwmAlhPVPCvZ3+SQW5n
 hfNaSbr+0nsZcJToajyiYA1teDeW/uOpjKADbWdboSQY2VAXEVTjnHodeAHffOgXj05R
 BIEFlfJoDcc4wvbbqnXt2cmNS3BYCWBFgY8GvkgOrzNcaMFCpluY0giTFEGdJK9MKx90
 RdYw==
X-Gm-Message-State: AOAM532V/km1/QKCnkf9DrPx0r20VZyolvks4crrFS6ms5qp2AuD+pgl
 V7hoQuYRfST0Ipp8q7QBEiWROw==
X-Google-Smtp-Source: ABdhPJwozNS2l6ZmNQHFe47laFA+VIyAVTaFBPqJarb7ovF+v/1MYWJKE2sYkw8aStQmFZZxxF4JJw==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr17894010wrm.285.1598529531560; 
 Thu, 27 Aug 2020 04:58:51 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id 126sm5013679wme.42.2020.08.27.04.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 04:58:50 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 59782559;
 Thu, 27 Aug 2020 11:58:48 +0000 (UTC)
To: Zheng Chuan <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
In-Reply-To: <1a23d60c-186b-d5b5-c43a-a8512826409b@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-12-git-send-email-zhengchuan@huawei.com>
 <m2wo1lk8j9.fsf@dme.org> <1a23d60c-186b-d5b5-c43a-a8512826409b@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Thu, 27 Aug 2020 12:58:48 +0100
Message-ID: <m2d03cjo5j.fsf@dme.org>
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

On Thursday, 2020-08-27 at 17:34:13 +08, Zheng Chuan wrote:

>>> +    /*
>>> +     * Only support query once for each calculation,
>>> +     * reset as DIRTY_RATE_STATUS_UNSTARTED after query
>>> +     */
>>> +    (void)dirtyrate_set_state(&CalculatingState, CalculatingState,
>>> +                              DIRTY_RATE_STATUS_UNSTARTED);
>> 
>> Is there a reason for this restriction? Removing it would require
>> clarifying the state model, I suppose.
>> 
> We only support query once for each calculation.
> Otherwise, it could always query dirtyrate, but maybe the dirtyrate is calculated
> long time ago.

There's nothing in the current interface that prevents this from being
the case already - the caller could initiate a 1 second sample, then
wait 24 hours to query the result.

Obviously this would generally be regarded as "d'oh - don't do that",
but the same argument would apply if the caller is allowed to query the
results multiple times.

Perhaps a complete solution would be to include information about the
sample period with the result. The caller could then determine whether
the sample is of adequate quality (sufficiently recent, taken over a
sufficiently long time period) for its' intended use.

dme.
-- 
I walk like a building, I never get wet.

