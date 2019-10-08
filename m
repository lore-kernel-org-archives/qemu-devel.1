Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4451C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BC420673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BC420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqLB-0001Ho-Ak
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iHqJ8-00084L-7n
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iHqJ6-0001Cs-Ll
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:17:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iHqJ6-0001BA-By
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:17:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 963B03086218;
 Tue,  8 Oct 2019 14:17:43 +0000 (UTC)
Received: from work-vm (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC76260BE2;
 Tue,  8 Oct 2019 14:17:42 +0000 (UTC)
Date: Tue, 8 Oct 2019 15:17:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 1/3] migration/postcopy: rename
 postcopy_ram_enable_notify to postcopy_ram_incoming_setup
Message-ID: <20191008141740.GD3441@work-vm>
References: <20191001100122.17730-1-richardw.yang@linux.intel.com>
 <20191001100122.17730-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001100122.17730-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 08 Oct 2019 14:17:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
> Function postcopy_ram_incoming_setup and postcopy_ram_incoming_cleanup
> is a pair. Rename to make it clear for audience.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Yes OK.
It really initially just setup the userfault, but it also kicks off the
fault thread as well so it has got a bit more hairy.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/postcopy-ram.c | 4 ++--
>  migration/postcopy-ram.h | 2 +-
>  migration/savevm.c       | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 1f63e65ed7..b24c4a10c2 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1094,7 +1094,7 @@ retry:
>      return NULL;
>  }
>  
> -int postcopy_ram_enable_notify(MigrationIncomingState *mis)
> +int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>  {
>      /* Open the fd for the kernel to give us userfaults */
>      mis->userfault_fd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> @@ -1321,7 +1321,7 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
>      return -1;
>  }
>  
> -int postcopy_ram_enable_notify(MigrationIncomingState *mis)
> +int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>  {
>      assert(0);
>      return -1;
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 9c8bd2bae0..d2668cc820 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -20,7 +20,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis);
>   * Make all of RAM sensitive to accesses to areas that haven't yet been written
>   * and wire up anything necessary to deal with it.
>   */
> -int postcopy_ram_enable_notify(MigrationIncomingState *mis);
> +int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
>  
>  /*
>   * Initialise postcopy-ram, setting the RAM to a state where we can go into
> diff --git a/migration/savevm.c b/migration/savevm.c
> index adad938f57..f3292eb003 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1865,7 +1865,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>       * shouldn't be doing anything yet so don't actually expect requests
>       */
>      if (migrate_postcopy_ram()) {
> -        if (postcopy_ram_enable_notify(mis)) {
> +        if (postcopy_ram_incoming_setup(mis)) {
>              postcopy_ram_incoming_cleanup(mis);
>              return -1;
>          }
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

