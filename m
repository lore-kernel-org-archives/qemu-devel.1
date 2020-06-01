Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F120BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9701820734
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/SrlNZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9701820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfnep-0001bo-Nt
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfne7-000181-MA
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:50:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31208
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfne6-0001VZ-4U
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591030240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SYciRLtPV/wnOpQZgFqliy3CBKOT1moQGZ289dih70s=;
 b=V/SrlNZ22gUGaLXWDzhjmvs/4TuQhQKYXvQtYT90GTqXQaGeaPPFf6BYs36w3ilW3QojwC
 5aoZ9BvacA/OrjtfCtlyDK9TkudU253t/sMSlIDmp2LS20xBz8hN2LYf1B116GqkuFx/UG
 XIr3MwbCX0u4T5psmEjnMitHm/YLOO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-r-H5qPrEP2azaJscJqnKXg-1; Mon, 01 Jun 2020 12:50:38 -0400
X-MC-Unique: r-H5qPrEP2azaJscJqnKXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB4D1107B7E7;
 Mon,  1 Jun 2020 16:50:37 +0000 (UTC)
Received: from work-vm (ovpn-113-144.ams2.redhat.com [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A553F5C1D0;
 Mon,  1 Jun 2020 16:50:36 +0000 (UTC)
Date: Mon, 1 Jun 2020 17:50:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 0/6] colo: migration related bugfixes
Message-ID: <20200601165034.GB2738@work-vm>
References: <cover.1589193382.git.lukasstraub2@web.de>
MIME-Version: 1.0
In-Reply-To: <cover.1589193382.git.lukasstraub2@web.de>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 11:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> Hello Everyone,
> Here are fixes for bugs that I found in my tests.

I've queued 1,2,3,4,6 but not 5 since that was still under discussion.

Dave

> Regards,
> Lukas Straub
> 
> Lukas Straub (6):
>   migration/colo.c: Use event instead of semaphore
>   migration/colo.c: Use cpu_synchronize_all_states()
>   migration/colo.c: Flush ram cache only after receiving device state
>   migration/colo.c: Relaunch failover even if there was an error
>   migration/qemu-file.c: Don't ratelimit a shutdown fd
>   migration/colo.c: Move colo_notify_compares_event to the right place
> 
>  migration/colo.c      | 39 ++++++++++++++++++++++++---------------
>  migration/migration.h |  4 ++--
>  migration/qemu-file.c |  2 +-
>  migration/ram.c       |  5 +----
>  migration/ram.h       |  1 +
>  5 files changed, 29 insertions(+), 22 deletions(-)
> 
> -- 
> 2.20.1


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


