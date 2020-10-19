Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF96C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950A5223BF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950A5223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUUY1-0005ld-7k
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kUUTT-00035e-HT; Mon, 19 Oct 2020 08:41:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58066 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kUUTG-0007jG-9F; Mon, 19 Oct 2020 08:41:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F0309AEF53A4DC87F162;
 Mon, 19 Oct 2020 20:40:48 +0800 (CST)
Received: from [10.174.185.201] (10.174.185.201) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 20:40:38 +0800
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
 <20200917154415.GB839531@stefanha-x1.localdomain>
 <20200917160054.GA2453251@dev>
 <5a5822ec-f3bc-a247-2b5a-f764b941c820@huawei.com>
 <20200918140628.GA2509473@dev>
 <1ba06b0d-3fcf-3676-f9e0-52875851ff19@huawei.com>
 <20200921111435.GA2524022@dev>
 <20201013100033.GB164611@stefanha-x1.localdomain>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <f70dc6ce-385b-a4f9-04a0-244018f3ddbb@huawei.com>
Date: Mon, 19 Oct 2020 20:40:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201013100033.GB164611@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.201]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 08:40:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, armbru@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 2020/10/13 18:00, Stefan Hajnoczi wrote:
> 
> Sorry, I lost track of this on-going email thread.
> 
> Thanks for the backtrace. It shows the io_submit call is done while the
> AioContext lock is held. The monitor thread is waiting for the
> IOThread's AioContext lock. vcpus threads can get stuck waiting on the
> big QEMU lock (BQL) that is held by the monitor in the meantime.
> 
> Please collect the kernel backtrace for io_submit so we can understand
> why multi-second io_submit latencies happen.
> 
> I also suggest trying aio=io_uring to check if Linux io_uring avoids the
> latency problem.
> 

The kernel backtrace for io_submit in GUEST is:

	guest# ./offcputime -K -p `pgrep -nx fio`
	    b'finish_task_switch'
	    b'__schedule'
	    b'schedule'
	    b'io_schedule'
	    b'blk_mq_get_tag'
	    b'blk_mq_get_request'
	    b'blk_mq_make_request'
	    b'generic_make_request'
	    b'submit_bio'
	    b'blkdev_direct_IO'
	    b'generic_file_read_iter'
	    b'aio_read'
	    b'io_submit_one'
	    b'__x64_sys_io_submit'
	    b'do_syscall_64'
	    b'entry_SYSCALL_64_after_hwframe'
	    -                fio (1464)
		40031912

And Linux io_uring can avoid the latency problem.

Thanks,
Zhenyu

