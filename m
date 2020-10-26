Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E957C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CF4223AB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1pweP2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CF4223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1gs-0002n2-Ab
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX1Yo-0008Ea-Qk
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX1Yf-000521-Q0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603715104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VVjEaZYCCNWWiJR+IM4OLkD8tVrgII1U2RMm30QUANc=;
 b=P1pweP2EE9Fl4IQJhj9MCCdNWeQyWcyiyqr9pr1iiIsvPTbDF3okG3MfGqyPDp7aESM5uB
 eaBL3bxI7vsVWWMY7Oyc5YM78tpJ3TDFm2yUg3SREF66R4kzm2naJriuYzuZ3I1x7fs4bM
 L90mXCNVxga/BTDXuRu6lN+tSKOYci0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-xf39owNNN1SHoO2Wn-pYrg-1; Mon, 26 Oct 2020 08:25:01 -0400
X-MC-Unique: xf39owNNN1SHoO2Wn-pYrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D87BE80572E;
 Mon, 26 Oct 2020 12:24:59 +0000 (UTC)
Received: from work-vm (ovpn-112-208.ams2.redhat.com [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1927A19728;
 Mon, 26 Oct 2020 12:24:57 +0000 (UTC)
Date: Mon, 26 Oct 2020 12:24:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v3 0/8] Fix some style problems in migration
Message-ID: <20201026122455.GA28658@work-vm>
References: <1603163448-27122-1-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1603163448-27122-1-git-send-email-yubihong@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: zhengchuan@huawei.com, quintela@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Bihong Yu (yubihong@huawei.com) wrote:
> Recently I am reading migration related code, find some style problems in
> migration directory while using checkpatch.pl to check migration code. Fix the
> error style problems.
> 

Queued

> v2:
> - fix Signed-off-by error
> - fix printf format error: "%0x" -> "0x%x"
> 
> v3:
> - change "VMStateDescription * []" to "VMStateDescription *[]"
> 
> Bihong Yu (8):
>   migration: Do not use C99 // comments
>   migration: Don't use '#' flag of printf format
>   migration: Add spaces around operator
>   migration: Open brace '{' following struct go on the same line
>   migration: Add braces {} for if statement
>   migration: Do not initialise statics and globals to 0 or NULL
>   migration: Open brace '{' following function declarations go on the
>     next line
>   migration: Delete redundant spaces
> 
>  migration/block.c        |  4 ++--
>  migration/migration.c    |  4 ++--
>  migration/migration.h    |  3 +--
>  migration/postcopy-ram.c |  2 +-
>  migration/ram.c          | 14 ++++++++------
>  migration/rdma.c         |  7 ++++---
>  migration/savevm.c       |  4 ++--
>  migration/vmstate.c      | 10 +++++-----
>  8 files changed, 25 insertions(+), 23 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


