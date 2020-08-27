Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E932177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E932177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHSX-0001Wn-O4
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBHRx-0000oz-CE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:56:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45346 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBHRu-0000Rn-2L
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:56:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id DC09838025CDDBCA56DD;
 Thu, 27 Aug 2020 20:55:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 20:55:52 +0800
Subject: Re: [PATCH v5 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
To: David Edmondson <dme@dme.org>, <quintela@redhat.com>, <eblake@redhat.com>, 
 <dgilbert@redhat.com>, <berrange@redhat.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-12-git-send-email-zhengchuan@huawei.com>
 <m2wo1lk8j9.fsf@dme.org> <1a23d60c-186b-d5b5-c43a-a8512826409b@huawei.com>
 <m2d03cjo5j.fsf@dme.org>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <e578c320-4864-863a-f54c-be1d6ab9d1bd@huawei.com>
Date: Thu, 27 Aug 2020 20:55:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <m2d03cjo5j.fsf@dme.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:55:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.782,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/27 19:58, David Edmondson wrote:
> On Thursday, 2020-08-27 at 17:34:13 +08, Zheng Chuan wrote:
> 
>>>> +    /*
>>>> +     * Only support query once for each calculation,
>>>> +     * reset as DIRTY_RATE_STATUS_UNSTARTED after query
>>>> +     */
>>>> +    (void)dirtyrate_set_state(&CalculatingState, CalculatingState,
>>>> +                              DIRTY_RATE_STATUS_UNSTARTED);
>>>
>>> Is there a reason for this restriction? Removing it would require
>>> clarifying the state model, I suppose.
>>>
>> We only support query once for each calculation.
>> Otherwise, it could always query dirtyrate, but maybe the dirtyrate is calculated
>> long time ago.
> 
> There's nothing in the current interface that prevents this from being
> the case already - the caller could initiate a 1 second sample, then
> wait 24 hours to query the result.
> 
> Obviously this would generally be regarded as "d'oh - don't do that",
> but the same argument would apply if the caller is allowed to query the
> results multiple times.
> 
> Perhaps a complete solution would be to include information about the
> sample period with the result. The caller could then determine whether
> the sample is of adequate quality (sufficiently recent, taken over a
> sufficiently long time period) for its' intended use.
> 
You mean add timestamp when i calculate?
Actually, I do not want make it complicate for qemu code,
maybe it could be left for user to implement both two qmp commands
like in libvirt-api.

On the other hand, it really bother me that we need to reset calculating state
to make sure the state model could be restart in next calculation.

For now, i put it after query_dirty_rate_info is finished as you see, it should not be a good idea:(

Maybe it is better to initialize at the beginning of qmp_calc_dirty_rate().

> dme.
> 


