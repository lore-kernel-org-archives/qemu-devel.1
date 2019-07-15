Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A210EC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7737C20868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7737C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmwsc-0000Z0-OC
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45543)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hmwsQ-0000AN-Bt
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hmwsP-0007Au-AD
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:02:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hmwsP-00077s-3m
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:02:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B819307CDD1;
 Mon, 15 Jul 2019 09:02:27 +0000 (UTC)
Received: from work-vm (ovpn-117-181.ams2.redhat.com [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F4126013B;
 Mon, 15 Jul 2019 09:02:24 +0000 (UTC)
Date: Mon, 15 Jul 2019 10:02:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190715090222.GC2689@work-vm>
References: <20190715020549.15018-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715020549.15018-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 09:02:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] migration/postcopy: fix document of
 postcopy_send_discard_bm_ram()
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
> Commit 6b6712efccd3 ('ram: Split dirty bitmap by RAMBlock') changes the
> parameter of postcopy_send_discard_bm_ram(), while left the document
> part untouched.
> 
> This patch correct the document and fix two typo by hand.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> v2: fix typo in function name, pointed by Dave
> ---
>  migration/ram.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 246efe6939..e019c925b2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2763,8 +2763,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
>   *
>   * @ms: current migration state
>   * @pds: state for postcopy
> - * @start: RAMBlock starting page
> - * @length: RAMBlock size
> + * @block: RAMBlock to discard
>   */
>  static int postcopy_send_discard_bm_ram(MigrationState *ms,
>                                          PostcopyDiscardState *pds,
> @@ -2961,7 +2960,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>  }
>  
>  /**
> - * postcopy_chuck_hostpages: discrad any partially sent host page
> + * postcopy_chunk_hostpages: discard any partially sent host page
>   *
>   * Utility for the outgoing postcopy code.
>   *
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

