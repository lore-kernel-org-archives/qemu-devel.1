Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D76FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EEF206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EEF206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htVCb-0007gq-4j
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 06:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45746)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1htVCE-0007GP-6l
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1htVCD-0004xy-4W
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1htVCC-0004xL-Uv
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0128B308FEC6;
 Fri,  2 Aug 2019 10:54:00 +0000 (UTC)
Received: from work-vm (ovpn-117-230.ams2.redhat.com [10.36.117.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCFFA60BE2;
 Fri,  2 Aug 2019 10:53:54 +0000 (UTC)
Date: Fri, 2 Aug 2019 11:53:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: piaojun <piaojun@huawei.com>
Message-ID: <20190802105352.GF2899@work-vm>
References: <5D43F688.8000607@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D43F688.8000607@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 02 Aug 2019 10:54:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] virtiofsd: fix compile error if
 'F_OFD_GETLK' not defined
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* piaojun (piaojun@huawei.com) wrote:
> Use F_GETLK for fcntl when F_OFD_GETLK not defined, such as kernel 3.10.
> 
> Signed-off-by: Jun Piao <piaojun@huawei.com>


> ---
> v2:
> - Use F_OFD_SETLK to replace F_OFD_GETLK in #ifdef.
> 
> ---
>  contrib/virtiofsd/passthrough_ll.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> index a81c01d..c69f2f3 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -1780,7 +1780,11 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t ino,
>  		goto out;
>  	}
> 
> +#ifdef F_OFD_GETLK
>  	ret = fcntl(plock->fd, F_OFD_GETLK, lock);
> +#else
> +	ret = fcntl(plock->fd, F_GETLK, lock);
> +#endif
>  	if (ret == -1)
>  		saverr = errno;
> 
> @@ -1831,7 +1835,11 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino,
> 
>  	/* TODO: Is it alright to modify flock? */
>  	lock->l_pid = 0;
> +#ifdef F_OFD_SETLK
>  	ret = fcntl(plock->fd, F_OFD_SETLK, lock);
> +#else
> +	ret = fcntl(plock->fd, F_GETLK, lock);
                               ^^^^^^^

Typo! You've got GETLK rather than SETLK.

But, a bigger question - does this actually work!
The manpage says:
   'If a process closes any file descriptor referring to a file, then
   all of the process's locks on that file are released, regardless of the
   file descriptor(s) on which the locks were obtained.'

the fd we're using here came from lookup_create_plock_ctx which did
a new openat to get this fd; so we've already got multiple fd's
referring to this file; and thus I worry we're going to close
one of them and lose all our locks on it.

Dave


> +#endif

>  	if (ret == -1) {
>  		saverr = errno;
>  	}
> -- 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

