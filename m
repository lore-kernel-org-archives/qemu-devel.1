Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5150C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 01:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C7F21775
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 01:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C7F21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k62QT-0007jD-Q5
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 21:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1k62Pq-0007Er-Cq; Wed, 12 Aug 2020 21:52:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4178 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1k62Pn-0001em-ED; Wed, 12 Aug 2020 21:52:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A5B1690652AD20683930;
 Thu, 13 Aug 2020 09:52:06 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.173) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 13 Aug 2020 09:51:57 +0800
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200812135116.GA112330@stefanha-x1.localdomain>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <03676b7f-5114-6aa8-3144-e431119b12c4@huawei.com>
Date: Thu, 13 Aug 2020 09:51:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200812135116.GA112330@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.173]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 21:52:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, armbru@redhat.com,
 xiexiangyou@huawei.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 2020/8/12 21:51, Stefan Hajnoczi wrote:
> On Mon, Aug 10, 2020 at 10:52:44PM +0800, Zhenyu Ye wrote:
>> Before doing qmp actions, we need to lock the qemu_global_mutex,
>> so the qmp actions should not take too long time.
>>
>> Unfortunately, some qmp actions need to acquire aio context and
>> this may take a long time.  The vm will soft lockup if this time
>> is too long.
>>
>> So add a timeout mechanism while doing qmp actions.
> 
> aio_context_acquire_timeout() is a workaround for code that blocks the
> event loop. Ideally there should be no code that blocks the event loop.
> 
> Which cases have you found where the event loop is blocked?
> 

Currently I only found the io_submit() will block while I/O pressure
is too high, for details, see:

	https://lore.kernel.org/qemu-devel/c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com/

io_submit can not ensure non-blocking at any time.

> I think they should be investigated and fixed (if possible) before
> introducing an API like aio_context_acquire_timeout().
> 

We cannot ensure that everything is non-blocking in iothread, because
some actions seems like asynchronous but will block in some times (such
as io_submit).  Anyway, the _timeout() API can make these qmp commands
(which need to get aio_context) be safer.

Thanks,
Zhenyu


