Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A23520774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOX4P9WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A23520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Ga9-0003OG-7y
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6GZZ-0002sD-LW
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:59:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1k6GZX-0004zv-0e
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597337961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2WWLij4JbEML1tdctaOE5u3kQuiDemA1l/3RNN7EtJk=;
 b=DOX4P9WRt//3DxwhDhSbQfgZiIBWq2ht0Smf3c+JhnMieT3ckKrZAKjMRanDMY6v+miokP
 KEp/IeRQGh6f4kao4BqyVTM6/0bRMDlafqVvcdcbRAkEJY//PSMvqxGiJ9u44I1oDpuNUX
 Cdjtypybf9gibnkeC9V/Aa3nWlmHxEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-sqwXXLa_P9aa57AXN6JHSg-1; Thu, 13 Aug 2020 12:59:19 -0400
X-MC-Unique: sqwXXLa_P9aa57AXN6JHSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CC2C1005E5D;
 Thu, 13 Aug 2020 16:59:18 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6E0A19C78;
 Thu, 13 Aug 2020 16:59:12 +0000 (UTC)
Date: Thu, 13 Aug 2020 10:59:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH 07/11] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
Message-ID: <20200813105911.2312adb5@x1.home>
In-Reply-To: <20200813073712.4001404-8-kuhn.chenqun@huawei.com>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-8-kuhn.chenqun@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 pannengyuan@huawei.com, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 15:37:08 +0800
Chen Qun <kuhn.chenqun@huawei.com> wrote:

> Clang static code analyzer show warning:
> hw/vfio/platform.c:239:9: warning: Value stored to 'ret' is never read
>         ret = event_notifier_test_and_clear(intp->interrupt);
>         ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/vfio/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index ac2cefc9b1..869ed2c39d 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -236,7 +236,7 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
>          trace_vfio_intp_interrupt_set_pending(intp->pin);
>          QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
>                               intp, pqnext);
> -        ret = event_notifier_test_and_clear(intp->interrupt);
> +        event_notifier_test_and_clear(intp->interrupt);
>          return;
>      }

Testing that an event is pending in our notifier is generally a
prerequisite to doing anything in the interrupt handler, I don't
understand why we're just consuming it and ignoring the return value.
The above is in the delayed handling branch of the function, but the
normal non-delayed path would only go on to error_report() if the
notifier is not pending and then inject an interrupt anyway.  This all
seems rather suspicious and it's a unique pattern among the vfio
callers of this function.  Is there a more fundamental bug that this
function should perform this test once and return without doing
anything if it's called spuriously, ie. without a notifier pending?
Thanks,

Alex


