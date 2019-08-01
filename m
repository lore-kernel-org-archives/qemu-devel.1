Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71110C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CDE20B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CDE20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht9XA-000131-JD
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 07:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1ht9WN-0000AY-Cn
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ht9WM-0003X1-GP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:45:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ht9WM-0003Wk-AM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:45:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A51133082E10;
 Thu,  1 Aug 2019 11:45:21 +0000 (UTC)
Received: from work-vm (ovpn-117-184.ams2.redhat.com [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3387C60605;
 Thu,  1 Aug 2019 11:45:15 +0000 (UTC)
Date: Thu, 1 Aug 2019 12:45:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190801114513.GE2773@work-vm>
References: <20190731161006.9447-1-stefanha@redhat.com>
 <20190731161006.9447-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731161006.9447-3-stefanha@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 01 Aug 2019 11:45:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/5] virtiofsd: take lo->mutex around
 lo_add_dirp_mapping()
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
Cc: virtio-fs@redhat.com, Liu Bo <bo.liu@linux.alibaba.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> The lo_add_dirp_mapping() function assumes lo->mutex is held, so we
> should acquire it.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Squashed into:
passthrough_ll: add dirp_map to hide lo_dirp pointers
> ---
>  contrib/virtiofsd/passthrough_ll.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> index 417a104218..e1d729d26b 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -1357,7 +1357,9 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi
>  
>  	g_atomic_int_set(&d->refcount, 1); /* paired with lo_releasedir() */
>  
> +	pthread_mutex_lock(&lo->mutex);
>  	fh = lo_add_dirp_mapping(req, d);
> +	pthread_mutex_unlock(&lo->mutex);
>  	if (fh == -1)
>  		goto out_err;
>  
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

