Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CC1C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 15:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A692465E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 15:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auctws68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A692465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inOjQ-0000Xn-Nu
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 10:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1inOiY-0007ut-M6
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1inOiW-00029u-Aw
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:18:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23602
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1inOiW-00022u-4q
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578064703;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9V/GyoUyanI9yiODgAKBbPqH22y6qAolnutjYGZKf0Y=;
 b=auctws68WJnoTv/83os/9MEG3DYw65YufRS7+ZlwnZIBHOHYZvwgG7l4ZO+hgSun/s/92Y
 9pe64NNQDTJHGZd6QNs9++Cn+saJGZer0TX26qAG7HFPfEj0Dh01BSsOawzFQT31Wf6Dy8
 QchqTBHCiZO1GdpP8BgL/8I24llEGOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-c3zDldaWOm2KdaT8wEcFdw-1; Fri, 03 Jan 2020 10:18:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA80107ACC5
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 15:18:20 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CF1A10013D9;
 Fri,  3 Jan 2020 15:18:16 +0000 (UTC)
Date: Fri, 3 Jan 2020 15:18:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 014/104] virtiofsd: Add options for virtio
Message-ID: <20200103151813.GH2753983@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-15-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-15-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: c3zDldaWOm2KdaT8wEcFdw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:37:34PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Add options to specify parameters for virtio-fs paths, i.e.
>=20
>    ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/fuse_i.h        |  1 +
>  tools/virtiofsd/fuse_lowlevel.c | 17 ++++++++++++-----
>  tools/virtiofsd/helper.c        | 22 +++++++++++-----------
>  3 files changed, 24 insertions(+), 16 deletions(-)
>=20
> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> index 0b5acc8765..f58be71e4b 100644
> --- a/tools/virtiofsd/fuse_i.h
> +++ b/tools/virtiofsd/fuse_i.h
> @@ -63,6 +63,7 @@ struct fuse_session {
>      struct fuse_notify_req notify_list;
>      size_t bufsize;
>      int error;
> +    char *vu_socket_path;
>  };
> =20
>  struct fuse_chan {
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index 167701b453..da708161e1 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2118,8 +2118,12 @@ reply_err:
>      }
> =20
>  static const struct fuse_opt fuse_ll_opts[] =3D {
> -    LL_OPTION("debug", debug, 1), LL_OPTION("-d", debug, 1),
> -    LL_OPTION("--debug", debug, 1), LL_OPTION("allow_root", deny_others,=
 1),
> +    LL_OPTION("debug", debug, 1),
> +    LL_OPTION("-d", debug, 1),
> +    LL_OPTION("--debug", debug, 1),

Pre-existing, but I'm not convinced we really need 3 different
ways to enable debugging - I would think -d / --debug is sufficient,
without needing "-o debug".


> +    LL_OPTION("allow_root", deny_others, 1),
> +    LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
> +    LL_OPTION("vhost_user_socket=3D%s", vu_socket_path, 0),

Similarly here I'm not convinced we need to add both
"--socket-path PATH" and "-o vhost_user_socket=3DPATH"


IIRC, we need --socket-path for compliance with QEMU's
standard execution model for vhost helpers.

>      FUSE_OPT_END
>  };
> =20
> @@ -2135,9 +2139,12 @@ void fuse_lowlevel_help(void)
>       * These are not all options, but the ones that are
>       * potentially of interest to an end-user
>       */
> -    printf("    -o allow_other         allow access by all users\n"
> -           "    -o allow_root          allow access by root\n"
> -           "    -o auto_unmount        auto unmount on process terminati=
on\n");
> +    printf(
> +        "    -o allow_other             allow access by all users\n"
> +        "    -o allow_root              allow access by root\n"
> +        "    --socket-path=3DPATH         path for the vhost-user socket=
\n"
> +        "    -o vhost_user_socket=3DPATH  path for the vhost-user socket=
\n"
> +        "    -o auto_unmount            auto unmount on process terminat=
ion\n");
>  }
> =20
>  void fuse_session_destroy(struct fuse_session *se)
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 8afccfc15e..48e38a7963 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -128,17 +128,17 @@ static const struct fuse_opt conn_info_opt_spec[] =
=3D {
> =20
>  void fuse_cmdline_help(void)
>  {
> -    printf(
> -        "    -h   --help            print help\n"
> -        "    -V   --version         print version\n"
> -        "    -d   -o debug          enable debug output (implies -f)\n"
> -        "    -f                     foreground operation\n"
> -        "    -s                     disable multi-threaded operation\n"
> -        "    -o clone_fd            use separate fuse device fd for each=
 "
> -        "thread\n"
> -        "                           (may improve performance)\n"
> -        "    -o max_idle_threads    the maximum number of idle worker th=
reads\n"
> -        "                           allowed (default: 10)\n");
> +    printf("    -h   --help                print help\n"
> +           "    -V   --version             print version\n"
> +           "    -d   -o debug              enable debug output (implies =
-f)\n"
> +           "    -f                         foreground operation\n"
> +           "    -s                         disable multi-threaded operat=
ion\n"
> +           "    -o clone_fd                use separate fuse device fd f=
or "
> +           "each thread\n"
> +           "                               (may improve performance)\n"
> +           "    -o max_idle_threads        the maximum number of idle wo=
rker "
> +           "threads\n"
> +           "                               allowed (default: 10)\n");
>  }
> =20
>  static int fuse_helper_opt_proc(void *data, const char *arg, int key,
> --=20
> 2.23.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


