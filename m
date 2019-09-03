Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5ACC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49CB21897
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49CB21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5CcR-00011r-08
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5Ca5-0006vE-5T
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5Ca3-0004ho-2p
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5Ca2-0004hS-Qk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:26:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9D0B3082133
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 17:26:57 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CD315C220;
 Tue,  3 Sep 2019 17:26:46 +0000 (UTC)
Date: Tue, 3 Sep 2019 18:26:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190903172644.GS2744@work-vm>
References: <20190827095437.18819-1-stefanha@redhat.com>
 <20190827095437.18819-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827095437.18819-3-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 03 Sep 2019 17:26:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] virtiofsd: add --print-capabilities
 option
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
> Add the --print-capabilities option as per vhost-user.rst "Backend
> programs conventions".  Currently there are no advertised features.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

That looks OK to me, but can someone who understands the json
requirement explain what says whether a 'features' entry is optional?

Dave

> ---
>  docs/interop/vhost-user.json       |  4 +++-
>  contrib/virtiofsd/fuse_lowlevel.h  |  1 +
>  contrib/virtiofsd/helper.c         |  2 ++
>  contrib/virtiofsd/passthrough_ll.c | 12 ++++++++++++
>  4 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
> index da6aaf51c8..d4ea1f7ac5 100644
> --- a/docs/interop/vhost-user.json
> +++ b/docs/interop/vhost-user.json
> @@ -31,6 +31,7 @@
>  # @rproc-serial: virtio remoteproc serial link
>  # @scsi: virtio scsi
>  # @vsock: virtio vsock transport
> +# @fs: virtio fs (since 4.2)
>  #
>  # Since: 4.0
>  ##
> @@ -50,7 +51,8 @@
>        'rpmsg',
>        'rproc-serial',
>        'scsi',
> -      'vsock'
> +      'vsock',
> +      'fs'
>    ]
>  }
>  
> diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_lowlevel.h
> index b441d3dfed..e3d8747571 100644
> --- a/contrib/virtiofsd/fuse_lowlevel.h
> +++ b/contrib/virtiofsd/fuse_lowlevel.h
> @@ -1796,6 +1796,7 @@ struct fuse_cmdline_opts {
>  	int nodefault_subtype;
>  	int show_version;
>  	int show_help;
> +	int print_capabilities;
>  	int clone_fd;
>  	int syslog;
>  	int log_level;
> diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
> index 8d8bca889b..84bf1c834d 100644
> --- a/contrib/virtiofsd/helper.c
> +++ b/contrib/virtiofsd/helper.c
> @@ -35,6 +35,7 @@ static const struct fuse_opt fuse_helper_opts[] = {
>  	FUSE_HELPER_OPT("--help",	show_help),
>  	FUSE_HELPER_OPT("-V",		show_version),
>  	FUSE_HELPER_OPT("--version",	show_version),
> +	FUSE_HELPER_OPT("--print-capabilities", print_capabilities),
>  	FUSE_HELPER_OPT("-d",		debug),
>  	FUSE_HELPER_OPT("debug",	debug),
>  	FUSE_HELPER_OPT("-d",		foreground),
> @@ -137,6 +138,7 @@ void fuse_cmdline_help(void)
>  {
>  	printf("    -h   --help                print help\n"
>  	       "    -V   --version             print version\n"
> +	       "    --print-capabilities       print vhost-user.json\n"
>  	       "    -d   -o debug              enable debug output (implies -f)\n"
>  	       "    --syslog                   log to syslog (default stderr)\n"
>  	       "    -f                         foreground operation\n"
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> index 0ef01b7e3f..e2e20f22cd 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -2879,6 +2879,14 @@ static void fuse_lo_data_cleanup(struct lo_data *lo)
>          free((char *)lo->source);
>  }
>  
> +/* Print vhost-user.json backend program capabilities */
> +static void print_capabilities(void)
> +{
> +	printf("{\n");
> +	printf("  \"type\": \"fs\"\n");
> +	printf("}\n");
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
> @@ -2931,6 +2939,10 @@ int main(int argc, char *argv[])
>  		fuse_lowlevel_version();
>  		ret = 0;
>  		goto err_out1;
> +	} else if (opts.print_capabilities) {
> +		print_capabilities();
> +		ret = 0;
> +		goto err_out1;
>  	}
>  
>  	if (fuse_opt_parse(&args, &lo, lo_opts, NULL)== -1)
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

