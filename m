Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD93FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3BA022CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BA022CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ssS-00055R-M1
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 04:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i2srB-0004dS-Dl
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 03:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i2sr9-0003oB-Lt
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 03:59:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i2sr9-0003nS-D6
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 03:59:03 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64D56121D
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 07:59:01 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id x13so664601wmj.9
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 00:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JEBAiMLyJgthJx3VPifU811sxbADqYccB+1p9VYP+xo=;
 b=HH7UvJTQPmfF2/G2kah/cSqEDKyMR+GEgejMKIx8HzopV/Tz8yfDYxWpH7b6DsMj/Y
 id5Vj91Nw8Z96TcsEtr0yJGwa18S1IzTeH9wLMaqQ7AcNyhmbZtFipC/7MoOCmAdj7dK
 IbalJZtwyCs9EnhpfSDGfFuHnmxzNdyQrY5q8yzhHzQYTwfddyqt/rtBQimfefBwIoJW
 UR3XqTKXoIZXADtJkP3bRW7qgwIXJXdGuDUe3Lyo2O15hQhP8+aK88Aw6sgB4OWt3rUd
 fQEtLg2MXdq1AFW6gWxBC12Yi0UfzdwWFv7YK+Wbv9TiVa5mqFpl8KUxASOOdatBjOfS
 dexA==
X-Gm-Message-State: APjAAAUWGk0VqJlOwZl1l0BldhAOjYqTDlVbVSIe7m0uSQLwbHScTp7R
 aLKwxTYtZ5rRHrZ75+aTkBLKmgp838nkHd7z1aNo25xshrXU9gNP1vIpAYA4K8dWFpWNwdMg7g5
 ZszifSfcScZZZhMI=
X-Received: by 2002:adf:f991:: with SMTP id f17mr2734270wrr.233.1566979140113; 
 Wed, 28 Aug 2019 00:59:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykxlbTHr5lbico0Z/x0afk1pXZiNMlKnioeEc1EyAg03aV4sqNgXIrXWkq+vY3eNSWOJGN/w==
X-Received: by 2002:adf:f991:: with SMTP id f17mr2734240wrr.233.1566979139846; 
 Wed, 28 Aug 2019 00:58:59 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id s19sm2553303wrb.94.2019.08.28.00.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 00:58:59 -0700 (PDT)
Date: Wed, 28 Aug 2019 09:58:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Message-ID: <20190828075856.siiyf2zwlt43m5ca@steredhat>
References: <20190827111650.1436-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827111650.1436-1-fangying1@huawei.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qmp: Fix memory leak in
 migrate_params_test_apply
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
Cc: lcf.lichaofeng@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-devel@nongnu.org, zhouyibo3@huawei.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 27, 2019 at 07:16:50PM +0800, Ying Fang wrote:
> Address Sanitizer shows memory leak in migrate_params_test_apply
> migration/migration.c:1253 and the stack is as bellow:
> 
> Direct leak of 45 byte(s) in 9 object(s) allocated from:
>     #0 0xffffbd7fc1db in __interceptor_malloc (/lib64/libasan.so.4+0xd31db)
>     #1 0xffffbd514163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>     #2 0xffffbd52f43b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
>     #3 0xaaaadfa4d623 in migrate_params_test_apply migration/migration.c:1253
>     #4 0xaaaadfa4d623 in qmp_migrate_set_parameters migration/migration.c:1422
>     #5 0xaaaadfa963f3 in hmp_migrate_set_parameter monitor/hmp-cmds.c:1867
>     #6 0xaaaadfa8afe3 in handle_hmp_command monitor/hmp.c:1082
>     #7 0xaaaadf479c57 in qmp_human_monitor_command monitor/misc.c:140
>     #8 0xaaaadfadf87b in qmp_marshal_human_monitor_command qapi/qapi-commands-misc.c:1024
>     #9 0xaaaadfc7797b in do_qmp_dispatch qapi/qmp-dispatch.c:131
>     #10 0xaaaadfc7797b in qmp_dispatch qapi/qmp-dispatch.c:174
>     #11 0xaaaadfa84fff in monitor_qmp_dispatch monitor/qmp.c:120
>     #12 0xaaaadfa85bbf in monitor_qmp_bh_dispatcher monitor/qmp.c:209
>     #13 0xaaaadfd2228f in aio_bh_call util/async.c:89
>     #14 0xaaaadfd2228f in aio_bh_poll util/async.c:117
>     #15 0xaaaadfd29bc3 in aio_dispatch util/aio-posix.c:459
>     #16 0xaaaadfd21ff7 in aio_ctx_dispatch util/async.c:260
>     #17 0xffffbd50e2f7 in g_main_context_dispatch (/lib64/libglib-2.0.so.0+0x512f7)
>     #18 0xaaaadfd278d7 in glib_pollfds_poll util/main-loop.c:218
>     #19 0xaaaadfd278d7 in os_host_main_loop_wait util/main-loop.c:241
>     #20 0xaaaadfd278d7 in main_loop_wait util/main-loop.c:517
>     #21 0xaaaadf67b5e7 in main_loop vl.c:1806
>     #22 0xaaaadf15d453 in main vl.c:4488
> 
> Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Ying Fang <fangying1@huawei.com>
> ---
>  migration/migration.c | 2 ++
>  1 file changed, 2 insertions(+)

LGTM:
Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Just a note, please use the version tag [PATCH vX] next time:
https://wiki.qemu.org/Contribute/SubmitAPatch#When_resending_patches_add_a_version_tag
In this case it had to be [PATCH v2].

Thanks,
Stefano

