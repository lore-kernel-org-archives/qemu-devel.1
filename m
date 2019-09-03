Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECFDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FEC21881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FEC21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5CRq-00042N-6W
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5CRA-0003Yl-RF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5CR9-0001BA-Ry
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:17:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5CR9-0001AY-Ln
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:17:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10B5A8553F
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 17:17:47 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8E9A1001956;
 Tue,  3 Sep 2019 17:17:36 +0000 (UTC)
Date: Tue, 3 Sep 2019 18:17:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190903171733.GR2744@work-vm>
References: <20190827095437.18819-1-stefanha@redhat.com>
 <20190827095437.18819-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827095437.18819-2-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 03 Sep 2019 17:17:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] virtiofsd: make -f (foreground) the
 default
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> According to vhost-user.rst "Backend program conventions", backend
> programs should run in the foregound by default.  Follow the
> conventions so libvirt and other management tools can control virtiofsd
> in a standard way.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  contrib/virtiofsd/helper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
> index 4c71452080..8d8bca889b 100644
> --- a/contrib/virtiofsd/helper.c
> +++ b/contrib/virtiofsd/helper.c
> @@ -42,6 +42,7 @@ static const struct fuse_opt fuse_helper_opts[] = {
>  	FUSE_OPT_KEY("-d",		FUSE_OPT_KEY_KEEP),
>  	FUSE_OPT_KEY("debug",		FUSE_OPT_KEY_KEEP),
>  	FUSE_HELPER_OPT("-f",		foreground),
> +	FUSE_HELPER_OPT_VALUE("--daemonize", foreground, 0),
>  	FUSE_HELPER_OPT("-s",		singlethread),
>  	FUSE_HELPER_OPT("fsname=",	nodefault_subtype),
>  	FUSE_OPT_KEY("fsname=",		FUSE_OPT_KEY_KEEP),
> @@ -139,6 +140,7 @@ void fuse_cmdline_help(void)
>  	       "    -d   -o debug              enable debug output (implies -f)\n"
>  	       "    --syslog                   log to syslog (default stderr)\n"
>  	       "    -f                         foreground operation\n"
> +	       "    --daemonize                run in background\n"
>  	       "    -s                         disable multi-threaded operation\n"
>  	       "    -o clone_fd                use separate fuse device fd for each thread\n"
>  	       "                               (may improve performance)\n"
> @@ -171,6 +173,7 @@ int fuse_parse_cmdline(struct fuse_args *args,
>  	memset(opts, 0, sizeof(struct fuse_cmdline_opts));
>  
>  	opts->max_idle_threads = 10;
> +	opts->foreground = 1;
>  
>  	if (fuse_opt_parse(args, opts, fuse_helper_opts,
>  			   fuse_helper_opt_proc) == -1)
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

