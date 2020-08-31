Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF96C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F264206EB
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F264206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCgYJ-0007EN-NH
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kCgXn-0006fG-Dt
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:56:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58922 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kCgXh-0008Ux-Tj
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:56:06 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 41D9D68DAAA3712C1564;
 Mon, 31 Aug 2020 17:55:50 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 31 Aug 2020
 17:55:40 +0800
Subject: Re: [PATCH v6 00/12] *** A Method for evaluating dirty page rate ***
To: David Edmondson <dme@dme.org>, <quintela@redhat.com>, <eblake@redhat.com>, 
 <dgilbert@redhat.com>, <berrange@redhat.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <m2h7sjchid.fsf@dme.org>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <b597768c-eb89-d131-ebf4-5a82bcf1e326@huawei.com>
Date: Mon, 31 Aug 2020 17:55:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <m2h7sjchid.fsf@dme.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 05:55:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.207,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 zhang.zhanghailiang@huawei.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/31 17:05, David Edmondson wrote:
> Trying to think like a control plane developer and user (of which I am
> neither) raised some questions about the overall interface provided
> here. If everyone else is happy with the current interface, then I'll
> shut up :-)
> 
> It seems like it should be possible to query the last measured dirty
> rate at any time. In particular, it should be possible to query the
> value before any rate has been measured (either returning an error, or
> if that is unpalatable perhaps a result with a zero interval to indicate
> "this data isn't useful"), but also *during* a subsequent measurement
> period.
> 
Hi, Thank you for your review.

For now,
i. if we query the value before any rate has been measured, it will return unstarted,
   and dirtyrate will return -1.
{"return":{"status":"unstarted","dirty-rate":-1,"start-time":0,"calc-time":0},"id":"libvirt-14"}

ii.if we specify the measurement interval like -1 or 61, it will return error
{"id":"libvirt-13","error":{"class":"GenericError","desc":"calc-time is out of range[1, 60]."}}

iii. We can query the last measured dirty rate at any time now as you expected in last patch version
     with returning the measurement timestamp and calc-time.

If i have missed some other scenes, please let me know:)

> That is, the result of the previous measurement should always be
> available on demand and a measurement becomes "current" when it
> completes.
> 
> Given that we allow the caller to specify the measurement interval, some
> callers might specify a long period. As only one measurement can be
> taken at a time, a long running measurement rules out taking a short
> measurement. That's probably okay, but does lead me to wonder whether
> the API should include a mechanism allowing the cancellation of an
> in-progress measurement.

That's why we restrict the maximum time to 60s, i think this is enough and also
not too long for user to observe the average dirty rate.
I think it is may a little expensive and hardly used to implement cancellation mechanism.

On the other hand, users could call several times with the measurement interval
like 1s, to improve its accuracy otherwise observe a long time.



> 
> dme.
> 


