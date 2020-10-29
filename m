Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF47C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B1A2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B1A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY1Cx-0006XZ-JH
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 02:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kY1Br-0005bG-I8; Thu, 29 Oct 2020 02:13:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kY1Bp-0001Mi-9l; Thu, 29 Oct 2020 02:13:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CMFW34pjhzLr1d;
 Thu, 29 Oct 2020 14:13:35 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 14:13:24 +0800
Message-ID: <5F9A5D84.6000707@huawei.com>
Date: Thu, 29 Oct 2020 14:13:24 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/4] kvm: Add a --enable-debug-kvm option to configure
References: <5F97FD61.4060804@huawei.com> <5F991998.2020108@huawei.com>
 <404f58a5-180d-f3d7-dbcc-b533a29e6a94@redhat.com>
In-Reply-To: <404f58a5-180d-f3d7-dbcc-b533a29e6a94@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=alex.chen@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 02:03:54
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.921,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhengchuan@huawei.com, mtosatti@redhat.com, zhang.zhanghailiang@huawei.com,
 kvm@vger.kernel.org, cohuck@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 chenhc@lemote.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/10/28 15:44, Paolo Bonzini wrote:
> On 28/10/20 08:11, AlexChen wrote:
>> The current 'DEBUG_KVM' macro is defined in many files, and turning on
>> the debug switch requires code modification, which is very inconvenient,
>> so this series add an option to configure to support the definition of
>> the 'DEBUG_KVM' macro.
>> In addition, patches 3 and 4 also make printf always compile in debug output
>> which will prevent bitrot of the format strings by referring to the
>> commit(08564ecd: s390x/kvm: make printf always compile in debug output).
> 
> Mostly we should use tracepoints, but the usefulness of these printf
> statements is often limited (except for s390 that maybe could make them
> unconditional error_reports).  I would leave this as is, maintainers can
> decide which tracepoints they like to have.
> 
Thanks for your review, I agree with you to leave 'DEBUG_KVM' as is.
In addition, patches 3 and 4 resolved the potential risk of bitrot of the format strings,
could you help review these two patches?

Thanks,
Alex

