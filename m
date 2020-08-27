Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC5BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756ED22BEA
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="irylW0Yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756ED22BEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCM2-0004B6-PV
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 03:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBC4D-0005bU-VX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:11:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBC4B-0003oc-VK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:11:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so4291897wrw.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=KlssIaCmydO2Kg8rJrK8/pP8mqF/5JVAB5ryn3q5dMk=;
 b=irylW0YbRomELYP21X8GHbUv3xesEY21JBvP63PXWMjiRVODCnFwQRr8DSPOv9ccwu
 yjkzqm+crClCTL7Vl9aNe9xHwoJkUrySG1Ezmv7Fsqo+Jiec5BI98kSRfx6//lS1Q71L
 hh7oVCX/PNYYr8o1x/YoUD16ee5OGSpykZFC2YNqOVmMi4xxvNPSp32BoGKn9NXpXUS9
 t/K9IVbizm7kfKmg4BW1O4zLWbubhO2ZeeLCvLtfRALThc7RQGYQ0x5D4gO8ufhQTif8
 x4LHD0Gp3KTz7EFsIoZ1hqWvEx95pBq3zJkApuyTO2IjrHDWfestRslWE81mIoSch9ly
 8Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=KlssIaCmydO2Kg8rJrK8/pP8mqF/5JVAB5ryn3q5dMk=;
 b=JbPkUS0oiFnAbBDLqWLyMlYfjGLrJ5k/yFPMpNWNfz7lYt3Q1lZ9wJbxpvCeE8hjHi
 1/PscsymElA27LC0XsiJPsi3fGCtYFK3qqv6Y9HWIkzxfFEgULM5fAqLlyQP/DsIw6MW
 HmwjwxpzSXS3Jzul/5qUzAxl1Y9mEoH9Op7mmzUOHdcnnYNUhzpIV15OCVEldVUIWG3B
 ukdxKZulTjrSsVZD3dcjU0CQ1DXNHfKTEEcRklGiOn4BO21FCgAHP84zlRblm+XFnEXv
 7GorAuH8q/myVmV+mD+wisWTZN8Pu0WmBAoLjKEJyu9kFbGUglmLFoGbFkMM05yvvvB1
 3Gwg==
X-Gm-Message-State: AOAM5312PaYj6wniG/DswlPYY3C0EhGkugeTg9qD34AowH/kPL1CX36C
 zB9pfFxT3UmyW60OwB3NqvQvOg==
X-Google-Smtp-Source: ABdhPJxuNzYVppPii5zbjox8GL7w915z4HJPqq61w5SVV6sFKQc+R4O6Biju6AmN8xLrkwDfX/6c3Q==
X-Received: by 2002:adf:8b12:: with SMTP id n18mr9075590wra.85.1598512281950; 
 Thu, 27 Aug 2020 00:11:21 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id m10sm3065761wmi.9.2020.08.27.00.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 00:11:21 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 67f9e09b;
 Thu, 27 Aug 2020 07:11:20 +0000 (UTC)
To: Zheng Chuan <zhengchuan@huawei.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
Subject: Re: [PATCH v5 06/12] migration/dirtyrate: Record hash results for
 each sampled page
In-Reply-To: <a86e273f-8bca-e789-d868-cb3832c162b4@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-7-git-send-email-zhengchuan@huawei.com>
 <m2eentlogl.fsf@dme.org> <20200826123016.GA2727@work-vm>
 <a86e273f-8bca-e789-d868-cb3832c162b4@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Thu, 27 Aug 2020 08:11:20 +0100
Message-ID: <m2lfi0k1gn.fsf@dme.org>
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-08-27 at 14:28:03 +08, Zheng Chuan wrote:

>>>> +static struct RamblockDirtyInfo *
>>>> +alloc_ramblock_dirty_info(int *block_index,
>>>> +                          struct RamblockDirtyInfo *block_dinfo)
>>>> +{
>>>> +    struct RamblockDirtyInfo *info = NULL;
>>>> +    int index = *block_index;
>>>> +
>>>> +    if (!block_dinfo) {
>>>> +        index = 0;
>>>> +        block_dinfo = g_try_new(struct RamblockDirtyInfo, 1);
>>>> +    } else {
>>>> +        index++;
>>>> +        block_dinfo = g_try_realloc(block_dinfo, (index + 1) *
>>>> +                                    sizeof(struct RamblockDirtyInfo));
>>>
>>> g_try_renew() instead of g_try_realloc()?
>>>
> Hi,
> I am not sure that because there only one place in qemu to use g_try_renew.
> Could you tell me why, because i think g_try_realloc will also return NULL when error happen:)

Only suggested because it would make the two branches of the code more
similar.

dme.
-- 
And you can't hold me down, 'cause I belong to the hurricane.

