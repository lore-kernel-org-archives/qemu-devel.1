Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5AEC47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104BB20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104BB20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OQA-0000kv-Qj
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1i8OOc-0007pr-Gq
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1i8OOa-00086f-W8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:40:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1i8OOa-00085f-On
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:40:20 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 218784DB1F
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:40:19 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id l15so14633793oti.11
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gjxUtzra2JlIOBEhCn0OZTKEKHQc4DUJNhpitxHOjSo=;
 b=sY7lF3HMRYPTNJMHm5KJ5BxdJZyLWveluou+Xo83TkUCv1nog/622jRr0x1CnU9bwR
 gVpX0dKSYxNPpQlVFtDu3iR+fsajfo7x8hDQSWQHosHIJaUcpQigRAOuHj5DRFRbijem
 uoBLAXnCMJBvbFMV2a0CkKq/8PnlrqQcOIxTNU7NaPJ/tt7m/htqDEkaBNPVvAXw9hYh
 CNCjNwa5kkX9RlHvW01BwB1iR9inB3XQ9mqjUKZMB8oBoKzYVDFruUAcotvhggGT/rST
 NdHUOdgr14kfwNTLj9r7aKxSFpi0a6mzEHvNAddG5um4jjxz0L8oDMN/RwfSshRhEzUs
 AIjA==
X-Gm-Message-State: APjAAAUNZzdocAMmpy8Na+nAFH1rMrIRAxKU5NkF/70axhPFOTKpW8cr
 fbR00gq3OsTEI/0tHjGFGRgU+pE3ITj9Kol/7COtZGsNrN1cfT+WbB/j1UWZDU30VkysiFSp/6C
 K+5dg/KrKU1t13mDjZ9Z5sfAwtOCbpo8=
X-Received: by 2002:a9d:470a:: with SMTP id a10mr36758623otf.166.1568292018657; 
 Thu, 12 Sep 2019 05:40:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUJ8qMhsxm/kX8VBMuPyJ86QB92FG+swm6ivR9cvu2gnh9DzccSDQwPpDMeWg2ojk3zH8/MEhaIDAtOD2IqLU=
X-Received: by 2002:a9d:470a:: with SMTP id a10mr36758608otf.166.1568292018439; 
 Thu, 12 Sep 2019 05:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190827095437.18819-1-stefanha@redhat.com>
 <20190827095437.18819-3-stefanha@redhat.com>
In-Reply-To: <20190827095437.18819-3-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Sep 2019 16:40:07 +0400
Message-ID: <CAMxuvay-=GokpG2xKUKM8X7oex4Bh5v9karOfeO==Whj9SdbuQ@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: virtio-fs@redhat.com, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Aug 27, 2019 at 1:55 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> Add the --print-capabilities option as per vhost-user.rst "Backend
> programs conventions".  Currently there are no advertised features.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
> diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_l=
owlevel.h
> index b441d3dfed..e3d8747571 100644
> --- a/contrib/virtiofsd/fuse_lowlevel.h
> +++ b/contrib/virtiofsd/fuse_lowlevel.h
> @@ -1796,6 +1796,7 @@ struct fuse_cmdline_opts {
>         int nodefault_subtype;
>         int show_version;
>         int show_help;
> +       int print_capabilities;
>         int clone_fd;
>         int syslog;
>         int log_level;
> diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
> index 8d8bca889b..84bf1c834d 100644
> --- a/contrib/virtiofsd/helper.c
> +++ b/contrib/virtiofsd/helper.c
> @@ -35,6 +35,7 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
>         FUSE_HELPER_OPT("--help",       show_help),
>         FUSE_HELPER_OPT("-V",           show_version),
>         FUSE_HELPER_OPT("--version",    show_version),
> +       FUSE_HELPER_OPT("--print-capabilities", print_capabilities),
>         FUSE_HELPER_OPT("-d",           debug),
>         FUSE_HELPER_OPT("debug",        debug),
>         FUSE_HELPER_OPT("-d",           foreground),
> @@ -137,6 +138,7 @@ void fuse_cmdline_help(void)
>  {
>         printf("    -h   --help                print help\n"
>                "    -V   --version             print version\n"
> +              "    --print-capabilities       print vhost-user.json\n"
>                "    -d   -o debug              enable debug output (impli=
es -f)\n"
>                "    --syslog                   log to syslog (default std=
err)\n"
>                "    -f                         foreground operation\n"
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
> index 0ef01b7e3f..e2e20f22cd 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -2879,6 +2879,14 @@ static void fuse_lo_data_cleanup(struct lo_data *l=
o)
>          free((char *)lo->source);
>  }
>
> +/* Print vhost-user.json backend program capabilities */
> +static void print_capabilities(void)
> +{
> +       printf("{\n");
> +       printf("  \"type\": \"fs\"\n");
> +       printf("}\n");
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
> @@ -2931,6 +2939,10 @@ int main(int argc, char *argv[])
>                 fuse_lowlevel_version();
>                 ret =3D 0;
>                 goto err_out1;
> +       } else if (opts.print_capabilities) {
> +               print_capabilities();
> +               ret =3D 0;
> +               goto err_out1;
>         }
>
>         if (fuse_opt_parse(&args, &lo, lo_opts, NULL)=3D=3D -1)
> --
> 2.21.0
>

