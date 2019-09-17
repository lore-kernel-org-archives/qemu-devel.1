Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8DEC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E4B21852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E4B21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAtM-0005gu-8i
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iAAnL-0000mX-Bk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iAAnK-00040l-6i
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:33:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iAAnJ-00040N-Ub
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:33:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB5B6308FBAC;
 Tue, 17 Sep 2019 10:33:12 +0000 (UTC)
Received: from work-vm (ovpn-116-53.ams2.redhat.com [10.36.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB1725D6A9;
 Tue, 17 Sep 2019 10:32:49 +0000 (UTC)
Date: Tue, 17 Sep 2019 11:32:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190917103247.GE3370@work-vm>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871570663.196432.7147178510220437381.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156871570663.196432.7147178510220437381.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 17 Sep 2019 10:33:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 12/17] migration: Pass local error object
 pointer to error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Greg Kurz (groug@kaod.org) wrote:
> Ensure that hints are added even if errp is &error_fatal or &error_abort.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

A bit painful, but if it solves the problem,


Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 01863a95f5fe..6724173ce34e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -983,18 +983,24 @@ static bool migrate_caps_check(bool *cap_list,
>  
>  #ifndef CONFIG_LIVE_BLOCK_MIGRATION
>      if (cap_list[MIGRATION_CAPABILITY_BLOCK]) {
> -        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
> +        Error *local_err = NULL;
> +
> +        error_setg(&local_err, "QEMU compiled without old-style (blk/-b, inc/-i) "
>                     "block migration");
> -        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
> +        error_append_hint(&local_err, "Use drive_mirror+NBD instead.\n");
> +        error_propagate(errp, local_err);
>          return false;
>      }
>  #endif
>  
>  #ifndef CONFIG_REPLICATION
>      if (cap_list[MIGRATION_CAPABILITY_X_COLO]) {
> -        error_setg(errp, "QEMU compiled without replication module"
> +        Error *local_err = NULL;
> +
> +        error_setg(&local_err, "QEMU compiled without replication module"
>                     " can't enable COLO");
> -        error_append_hint(errp, "Please enable replication before COLO.\n");
> +        error_append_hint(&local_err, "Please enable replication before COLO.\n");
> +        error_propagate(errp, local_err);
>          return false;
>      }
>  #endif
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

