Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9336DC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A11F21E6E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A11F21E6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPsD-00057A-OT
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvPrk-0004hH-DZ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvPrj-00040Z-Gc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvPrj-0003zV-BK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:36:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB3858FAC9;
 Wed,  7 Aug 2019 17:36:46 +0000 (UTC)
Received: from work-vm (ovpn-117-204.ams2.redhat.com [10.36.117.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BACF0600CC;
 Wed,  7 Aug 2019 17:36:41 +0000 (UTC)
Date: Wed, 7 Aug 2019 18:36:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190807173639.GI27871@work-vm>
References: <20190719071129.11880-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719071129.11880-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 07 Aug 2019 17:36:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: use migration_in_postcopy() to
 check POSTCOPY_ACTIVE
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Use common helper function to check the state.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

queued

> ---
>  migration/rdma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 3036221ee8..0e73e759ca 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3140,7 +3140,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
>  
>      CHECK_ERROR_STATE();
>  
> -    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +    if (migration_in_postcopy()) {
>          rcu_read_unlock();
>          return RAM_SAVE_CONTROL_NOT_SUPP;
>      }
> @@ -3775,7 +3775,7 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
>  
>      CHECK_ERROR_STATE();
>  
> -    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +    if (migration_in_postcopy()) {
>          rcu_read_unlock();
>          return 0;
>      }
> @@ -3810,7 +3810,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
>  
>      CHECK_ERROR_STATE();
>  
> -    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +    if (migration_in_postcopy()) {
>          rcu_read_unlock();
>          return 0;
>      }
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

