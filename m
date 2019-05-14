Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC25C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3306D20675
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3306D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQa8G-0000Li-CC
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:18:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQa6G-0007Mw-Vw
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQa6F-0007fY-0V
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:16:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQa6A-0007Y8-QQ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:16:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BAD289C3B;
	Tue, 14 May 2019 16:16:12 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C3146608A6;
	Tue, 14 May 2019 16:16:11 +0000 (UTC)
Date: Tue, 14 May 2019 17:16:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190514161608.GP2753@work-vm>
References: <20190510233729.15554-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510233729.15554-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 14 May 2019 16:16:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration/ram.c: fix typos in comments
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/ram.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued.

> diff --git a/migration/ram.c b/migration/ram.c
> index 1def8122e9..720c2b73ca 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -888,7 +888,7 @@ struct {
>   *    - to make easier to know what to free at the end of migration
>   *
>   * This way we always know who is the owner of each "pages" struct,
> - * and we don't need any loocking.  It belongs to the migration thread
> + * and we don't need any locking.  It belongs to the migration thread
>   * or to the channel thread.  Switching is safe because the migration
>   * thread is using the channel mutex when changing it, and the channel
>   * have to had finish with its own, otherwise pending_job can't be
> @@ -1594,7 +1594,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>   *
>   * Called with rcu_read_lock() to protect migration_bitmap
>   *
> - * Returns the byte offset within memory region of the start of a dirty page
> + * Returns the page offset within memory region of the start of a dirty page
>   *
>   * @rs: current RAM state
>   * @rb: RAMBlock where to search for dirty pages
> @@ -2108,7 +2108,7 @@ retry:
>   * find_dirty_block: find the next dirty page and update any state
>   * associated with the search process.
>   *
> - * Returns if a page is found
> + * Returns true if a page is found
>   *
>   * @rs: current RAM state
>   * @pss: data about the state of the current dirty page scan
> @@ -2204,7 +2204,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
>   *
>   * Skips pages that are already sent (!dirty)
>   *
> - * Returns if a queued page is found
> + * Returns true if a queued page is found
>   *
>   * @rs: current RAM state
>   * @pss: data about the state of the current dirty page scan
> @@ -3411,7 +3411,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>  
>          /* we want to check in the 1st loop, just in case it was the 1st time
>             and we had to sync the dirty bitmap.
> -           qemu_get_clock_ns() is a bit expensive, so we only check each some
> +           qemu_clock_get_ns() is a bit expensive, so we only check each some
>             iterations
>          */
>          if ((i & 63) == 0) {
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

