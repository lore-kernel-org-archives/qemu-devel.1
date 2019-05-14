Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E69C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6604D2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6604D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQYYr-0002Se-IQ
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 10:37:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQYXD-0001Z3-Ah
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQYX9-0006Yz-Ek
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:36:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQYX7-0006X0-IJ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:35:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B3E2DD9F4;
	Tue, 14 May 2019 14:35:49 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 82C245C553;
	Tue, 14 May 2019 14:35:48 +0000 (UTC)
Date: Tue, 14 May 2019 15:35:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yi Wang <wang.yi59@zte.com.cn>
Message-ID: <20190514143545.GJ2753@work-vm>
References: <1555311089-18610-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555311089-18610-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 14 May 2019 14:35:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: update comments of migration
 bitmap
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

* Yi Wang (wang.yi59@zte.com.cn) wrote:
> Since the ram bitmap and the unsent bitmap are split by RAMBlock
> in commit 6b6712e, it's better to update the comments about them.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Queued

> ---
>  migration/ram.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 1ca9ba7..24ab23d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1630,8 +1630,6 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>  /**
>   * migration_bitmap_find_dirty: find the next dirty page from start
>   *
> - * Called with rcu_read_lock() to protect migration_bitmap
> - *
>   * Returns the byte offset within memory region of the start of a dirty page
>   *
>   * @rs: current RAM state
> @@ -2681,7 +2679,7 @@ static void ram_save_cleanup(void *opaque)
>      RAMBlock *block;
>  
>      /* caller have hold iothread lock or is in a bh, so there is
> -     * no writing race against this migration_bitmap
> +     * no writing race against the migration bitmap
>       */
>      memory_global_dirty_log_stop();
>  
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

