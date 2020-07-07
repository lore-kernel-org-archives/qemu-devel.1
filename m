Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B6FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B9520663
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S76eBLZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B9520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspV3-00022V-8C
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jspUG-0001X8-U0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:26:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jspUD-0007J7-Ng
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594135580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJy4W+mX4kMvdIp7j638j71e7Rr9xpMtiWn4rOX+KfY=;
 b=S76eBLZdALFTav4RIkf+0Ye5AdZ2lihpenigtsGu8pxj5wIBIoeuCmIw0rDqzkHAN2GLOf
 kCNfrzdj39z9LAkrWWrh2tv8KfytUPTyN0Vo6n5aRacjqulSLgAIUDuWvQp268PecTx1a2
 iLyF7Tu8OxpWaJ4zzH7t3HeEu0wZtl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-J3UqijrvM7-iHzfs7PZZXQ-1; Tue, 07 Jul 2020 11:26:17 -0400
X-MC-Unique: J3UqijrvM7-iHzfs7PZZXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E34D8800D5C;
 Tue,  7 Jul 2020 15:26:15 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C842573FDD;
 Tue,  7 Jul 2020 15:26:14 +0000 (UTC)
Date: Tue, 7 Jul 2020 17:26:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update nvme entry
Message-ID: <20200707152613.GD7002@linux.fritz.box>
References: <20200706194342.1996219-1-kbusch@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200706194342.1996219-1-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.07.2020 um 21:43 hat Keith Busch geschrieben:
> The nvme emulated device development pace has increased recently.  Klaus
> has offered to co-maintain, and since we have many new contributions
> coming through, we're adding a repository to accumulate and test new
> features.
> 
> Cc: Klaus Jensen <its@irrelevant.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I assume that you'll merge this as the first thing through your new
tree, so instead of applying, I'll just add:

Acked-by: Kevin Wolf <kwolf@redhat.com>


