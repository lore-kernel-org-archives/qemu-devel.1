Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5A5238E1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5A5238E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bwidawsk.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKQt-00055s-GK
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben@bwidawsk.net>) id 1kSKPa-0003sc-FO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:32:18 -0400
Received: from zangief.bwidawsk.net ([107.170.211.233]:57228
 helo=mail.bwidawsk.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben@bwidawsk.net>) id 1kSKPY-0001hx-UD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:32:18 -0400
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
 id BFFF5122C88; Tue, 13 Oct 2020 06:32:15 -0700 (PDT)
Received: from mail.bwidawsk.net (c-73-37-61-164.hsd1.or.comcast.net
 [73.37.61.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (Client did not present a certificate)
 by mail.bwidawsk.net (Postfix) with ESMTPSA id 8483A122C4D;
 Tue, 13 Oct 2020 06:32:11 -0700 (PDT)
Date: Tue, 13 Oct 2020 06:32:09 -0700
From: Ben Widawsky <ben@bwidawsk.net>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] monitor: Fix order in monitor_cleanup()
Message-ID: <20201013133209.uwqowwnnhylxdiyc@mail.bwidawsk.net>
References: <20201013125027.41003-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201013125027.41003-1-kwolf@redhat.com>
Received-SPF: none client-ip=107.170.211.233; envelope-from=ben@bwidawsk.net;
 helo=mail.bwidawsk.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 09:32:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.4,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: f4bug@amsat.org, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-10-13 14:50:27, Kevin Wolf wrote:
> We can only destroy Monitor objects after we're sure that they are not
> in use by the dispatcher coroutine any more. This fixes crashes like the
> following where we tried to destroy a monitor mutex while the dispatcher
> coroutine still holds it:
> 
>  (gdb) bt
>  #0  0x00007fe541cf4bc5 in raise () at /lib64/libc.so.6
>  #1  0x00007fe541cdd8a4 in abort () at /lib64/libc.so.6
>  #2  0x000055c24e965327 in error_exit (err=16, msg=0x55c24eead3a0 <__func__.33> "qemu_mutex_destroy") at ../util/qemu-thread-posix.c:37
>  #3  0x000055c24e9654c3 in qemu_mutex_destroy (mutex=0x55c25133e0f0) at ../util/qemu-thread-posix.c:70
>  #4  0x000055c24e7cfaf1 in monitor_data_destroy_qmp (mon=0x55c25133dfd0) at ../monitor/qmp.c:439
>  #5  0x000055c24e7d23bc in monitor_data_destroy (mon=0x55c25133dfd0) at ../monitor/monitor.c:615
>  #6  0x000055c24e7d253a in monitor_cleanup () at ../monitor/monitor.c:644
>  #7  0x000055c24e6cb002 in qemu_cleanup () at ../softmmu/vl.c:4549
>  #8  0x000055c24e0d259b in main (argc=24, argv=0x7ffff66b0d58, envp=0x7ffff66b0e20) at ../softmmu/main.c:51
> 
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]


