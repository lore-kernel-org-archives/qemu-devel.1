Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343AAC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0804E20673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0804E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL5J1-0007mC-NS
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 08:22:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hL5I1-0007HB-Rf
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hL5Hz-0000Kr-V5
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:21:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hL5Hz-0000JF-Lq
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:21:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA2443092663;
	Mon, 29 Apr 2019 12:21:40 +0000 (UTC)
Received: from work-vm (ovpn-117-192.ams2.redhat.com [10.36.117.192])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A35E5D71C;
	Mon, 29 Apr 2019 12:21:39 +0000 (UTC)
Date: Mon, 29 Apr 2019 13:21:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhang Chen <chen.zhang@intel.com>
Message-ID: <20190429122136.GE2748@work-vm>
References: <20190426090730.2691-1-chen.zhang@intel.com>
	<20190426090730.2691-2-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190426090730.2691-2-chen.zhang@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 29 Apr 2019 12:21:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] migration/colo.c: Remove redundant
 input parameter
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Juan Quintela <quintela@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429122136.rNV1_17zph_fVaiTdJLlejLbnG2UAE4k6lMFKKaXByY@z>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> The colo_do_failover no need the input parameter.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/colo.h  | 2 +-
>  migration/colo-failover.c | 2 +-
>  migration/colo.c          | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index 99ce17aca7..ddebe0ad27 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -37,7 +37,7 @@ bool migration_incoming_in_colo_state(void);
>  COLOMode get_colo_mode(void);
>  
>  /* failover */
> -void colo_do_failover(MigrationState *s);
> +void colo_do_failover(void);
>  
>  void colo_checkpoint_notify(void *opaque);
>  #endif
> diff --git a/migration/colo-failover.c b/migration/colo-failover.c
> index 4854a96c92..e9ca0b4774 100644
> --- a/migration/colo-failover.c
> +++ b/migration/colo-failover.c
> @@ -39,7 +39,7 @@ static void colo_failover_bh(void *opaque)
>          return;
>      }
>  
> -    colo_do_failover(NULL);
> +    colo_do_failover();
>  }
>  
>  void failover_request_active(Error **errp)
> diff --git a/migration/colo.c b/migration/colo.c
> index 238a6d62c7..8c1644091f 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -193,7 +193,7 @@ COLOMode get_colo_mode(void)
>      }
>  }
>  
> -void colo_do_failover(MigrationState *s)
> +void colo_do_failover(void)
>  {
>      /* Make sure VM stopped while failover happened. */
>      if (!colo_runstate_is_stopped()) {
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

