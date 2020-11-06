Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12C0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240FF217A0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUmcXhE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240FF217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb51U-0004eM-P7
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 11:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kb50C-0003JZ-Ui
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:54:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kb509-00074m-UO
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604681649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXy2jEDl3PP13g75nSR4KSd1i4RAX4+2ubbpiSLFwJQ=;
 b=DUmcXhE/pxg4emeJyl4RFbj5sXTYGX+QcRx9yPuSmh0YtgYdlrYnkltFIG9ut0ZO2luAto
 FdWckpmXjTu46Oi1OdonLU8SbKRycL8+Z1gY4+cmczOtF99nmDWp8QHngzLcCuEArGlHPM
 1avJwRCYyGxlDqjPWwcFEVHzhzr5ZnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-xRSk9USAOgCpvB7qKBDT8A-1; Fri, 06 Nov 2020 11:54:06 -0500
X-MC-Unique: xRSk9USAOgCpvB7qKBDT8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8000F804754;
 Fri,  6 Nov 2020 16:54:03 +0000 (UTC)
Received: from work-vm (ovpn-114-220.ams2.redhat.com [10.36.114.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55EA26EF75;
 Fri,  6 Nov 2020 16:54:01 +0000 (UTC)
Date: Fri, 6 Nov 2020 16:53:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH] migration/dirtyrate: simplify inlcudes in dirtyrate.c
Message-ID: <20201106165358.GN3576@work-vm>
References: <1604030281-112946-1-git-send-email-zhengchuan@huawei.com>
 <e19ac83b-dc05-a783-cb30-e09d592f6a8f@oracle.com>
 <a0f1a800-e9dc-d5df-6082-ffdcd5b8dfc5@huawei.com>
MIME-Version: 1.0
In-Reply-To: <a0f1a800-e9dc-d5df-6082-ffdcd5b8dfc5@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zheng Chuan (zhengchuan@huawei.com) wrote:
> Kindly ping for not forgetting this trivial fix:)

Yes but it's too late for the merge window, so it'll happen on the next
one, no rush!

Dave

> On 2020/10/30 22:09, Mark Kanda wrote:
> > On 10/29/2020 10:58 PM, Chuan Zheng wrote:
> >> Remove redundant blank line which is left by Commit 662770af7c6e8c,
> >> also take this opportunity to remove redundant includes in dirtyrate.c.
> >>
> >> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> > 
> > Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
> > 
> >> ---
> >>   migration/dirtyrate.c | 5 -----
> >>   1 file changed, 5 deletions(-)
> >>
> >> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> >> index 8f728d2..ccb9814 100644
> >> --- a/migration/dirtyrate.c
> >> +++ b/migration/dirtyrate.c
> >> @@ -11,17 +11,12 @@
> >>    */
> >>     #include "qemu/osdep.h"
> >> -
> >>   #include <zlib.h>
> >>   #include "qapi/error.h"
> >>   #include "cpu.h"
> >> -#include "qemu/config-file.h"
> >> -#include "exec/memory.h"
> >>   #include "exec/ramblock.h"
> >> -#include "exec/target_page.h"
> >>   #include "qemu/rcu_queue.h"
> >>   #include "qapi/qapi-commands-migration.h"
> >> -#include "migration.h"
> >>   #include "ram.h"
> >>   #include "trace.h"
> >>   #include "dirtyrate.h"
> >>
> 
> -- 
> Regards.
> Chuan
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


