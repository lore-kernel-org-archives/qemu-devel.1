Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A5C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10BA2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10BA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huc5Q-0002OU-1v
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 08:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45481)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1huc4t-0001xI-O6
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1huc4s-0002Qx-M4
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1huc4s-0002QG-Ee
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:27:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 65322C04B946;
 Mon,  5 Aug 2019 12:27:01 +0000 (UTC)
Received: from work-vm (ovpn-117-168.ams2.redhat.com [10.36.117.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF56B5D6C8;
 Mon,  5 Aug 2019 12:26:55 +0000 (UTC)
Date: Mon, 5 Aug 2019 13:26:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190805122652.GM13734@work-vm>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190801165409.20121-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801165409.20121-3-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 05 Aug 2019 12:27:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] virtiofsd: prevent
 FUSE_INIT/FUSE_DESTROY races
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
> When running with multiple threads it can be tricky to handle
> FUSE_INIT/FUSE_DESTROY in parallel with other request types or in
> parallel with themselves.  Serialize FUSE_INIT and FUSE_DESTROY so that
> malicious clients cannot trigger race conditions.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

(It took me a few minutes getting my head around the different _destroy
functions)

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  contrib/virtiofsd/fuse_i.h        |  1 +
>  contrib/virtiofsd/fuse_lowlevel.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
> index ff6e1b75ba..dcde9feb97 100644
> --- a/contrib/virtiofsd/fuse_i.h
> +++ b/contrib/virtiofsd/fuse_i.h
> @@ -63,6 +63,7 @@ struct fuse_session {
>  	struct fuse_req list;
>  	struct fuse_req interrupts;
>  	pthread_mutex_t lock;
> +	pthread_rwlock_t init_rwlock;
>  	int got_destroy;
>  	int broken_splice_nonblock;
>  	uint64_t notify_ctr;
> diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_lowlevel.c
> index 6ebf237baa..483a1bc9be 100644
> --- a/contrib/virtiofsd/fuse_lowlevel.c
> +++ b/contrib/virtiofsd/fuse_lowlevel.c
> @@ -2473,6 +2473,18 @@ void fuse_session_process_buf_int(struct fuse_session *se,
>  	req->ctx.pid = in->pid;
>  	req->ch = ch ? fuse_chan_get(ch) : NULL;
>  
> +	/* INIT and DESTROY requests are serialized, all other request types
> +	 * run in parallel.  This prevents races between FUSE_INIT and ordinary
> +	 * requests, FUSE_INIT and FUSE_INIT, FUSE_INIT and FUSE_DESTROY, and
> +	 * FUSE_DESTROY and FUSE_DESTROY.
> +	 */
> +	if (in->opcode == FUSE_INIT || in->opcode == CUSE_INIT ||
> +	    in->opcode == FUSE_DESTROY) {
> +		pthread_rwlock_wrlock(&se->init_rwlock);
> +	} else {
> +		pthread_rwlock_rdlock(&se->init_rwlock);
> +	}
> +
>  	err = EIO;
>  	if (!se->got_init) {
>  		enum fuse_opcode expected;
> @@ -2524,10 +2536,13 @@ void fuse_session_process_buf_int(struct fuse_session *se,
>  		do_write_buf(req, in->nodeid, &iter, bufv);
>  	else
>  		fuse_ll_ops[in->opcode].func(req, in->nodeid, &iter);
> +
> +	pthread_rwlock_unlock(&se->init_rwlock);
>  	return;
>  
>  reply_err:
>  	fuse_reply_err(req, err);
> +	pthread_rwlock_unlock(&se->init_rwlock);
>  }
>  
>  #define LL_OPTION(n,o,v) \
> @@ -2569,6 +2584,7 @@ void fuse_session_destroy(struct fuse_session *se)
>  		if (se->op.destroy)
>  			se->op.destroy(se->userdata, se);
>  	}
> +	pthread_rwlock_destroy(&se->init_rwlock);
>  	pthread_mutex_destroy(&se->lock);
>  	free(se->cuse_data);
>  	if (se->fd != -1)
> @@ -2656,6 +2672,7 @@ struct fuse_session *fuse_session_new(struct fuse_args *args,
>  	list_init_req(&se->list);
>  	list_init_req(&se->interrupts);
>  	fuse_mutex_init(&se->lock);
> +	pthread_rwlock_init(&se->init_rwlock, NULL);
>  
>  	memcpy(&se->op, op, op_size);
>  	se->owner = getuid();
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

