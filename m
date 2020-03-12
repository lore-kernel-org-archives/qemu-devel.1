Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A6320716
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEwuVi+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A6320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCLPn-0004PU-UY
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 06:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jCLPB-0003zT-L8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jCLP9-0006xU-A2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:49:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jCLP8-0006v2-VX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584010169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nrau/a8CpOJiQjBDEkLcm3OGCMw4PIWlTNYbzmINaw=;
 b=EEwuVi+T7GmbD4J30fJ+DMaZT5GLTgkqdVtXRA+xBjE5owAl3NpZ8LpWghOAFEansmgaEN
 33JrHuMF0+5pfJUXCEeiEqzRr0/eR9X2nUwxKTsnG4I4Xf023cqr9SQ3lKUKpZh4wOstQ1
 k85w8B6BxYNErOh9UKxNQVB3GOzOG7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-YSuI4F_HPEesfQPWmOOgdA-1; Thu, 12 Mar 2020 06:49:23 -0400
X-MC-Unique: YSuI4F_HPEesfQPWmOOgdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6305DBE5;
 Thu, 12 Mar 2020 10:49:22 +0000 (UTC)
Received: from redhat.com (ovpn-112-64.ams2.redhat.com [10.36.112.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4B0192D30;
 Thu, 12 Mar 2020 10:49:16 +0000 (UTC)
Date: Thu, 12 Mar 2020 10:49:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] tools/virtiofsd: add support for --socket-group
Message-ID: <20200312104913.GB4089516@redhat.com>
References: <20200312104142.21259-1-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200312104142.21259-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 10:41:42AM +0000, Alex Benn=C3=A9e wrote:
> If you like running QEMU as a normal user (very common for TCG runs)
> but you have to run virtiofsd as a root user you run into connection
> problems. Adding support for an optional --socket-group allows the
> users to keep using the command line.

If we're going to support this, then I think we need to put it in
the vhost-user.rst specification so we standardize across backends.=20



> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>=20
> ---
> v1
>   - tweak documentation and commentary
> ---
>  docs/tools/virtiofsd.rst        |  4 ++++
>  tools/virtiofsd/fuse_i.h        |  1 +
>  tools/virtiofsd/fuse_lowlevel.c |  6 ++++++
>  tools/virtiofsd/fuse_virtio.c   | 20 ++++++++++++++++++--
>  4 files changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> index 378594c422a..5a8246b74f8 100644
> --- a/docs/tools/virtiofsd.rst
> +++ b/docs/tools/virtiofsd.rst
> @@ -85,6 +85,10 @@ Options
> =20
>    Listen on vhost-user UNIX domain socket at PATH.
> =20
> +.. option:: --socket-group=3DGROUP
> +
> +  Set the vhost-user UNIX domain socket gid to GROUP.
> +
>  .. option:: --fd=3DFDNUM
> =20
>    Accept connections from vhost-user UNIX domain socket file descriptor =
FDNUM.
> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> index 1240828208a..492e002181e 100644
> --- a/tools/virtiofsd/fuse_i.h
> +++ b/tools/virtiofsd/fuse_i.h
> @@ -68,6 +68,7 @@ struct fuse_session {
>      size_t bufsize;
>      int error;
>      char *vu_socket_path;
> +    char *vu_socket_group;
>      int   vu_listen_fd;
>      int   vu_socketfd;
>      struct fv_VuDev *virtio_dev;
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index 2dd36ec03b6..4d1ba2925d1 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2523,6 +2523,7 @@ static const struct fuse_opt fuse_ll_opts[] =3D {
>      LL_OPTION("--debug", debug, 1),
>      LL_OPTION("allow_root", deny_others, 1),
>      LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
> +    LL_OPTION("--socket-group=3D%s", vu_socket_group, 0),
>      LL_OPTION("--fd=3D%d", vu_listen_fd, 0),
>      LL_OPTION("--thread-pool-size=3D%d", thread_pool_size, 0),
>      FUSE_OPT_END
> @@ -2630,6 +2631,11 @@ struct fuse_session *fuse_session_new(struct fuse_=
args *args,
>                   "fuse: --socket-path and --fd cannot be given together\=
n");
>          goto out4;
>      }
> +    if (se->vu_socket_group && !se->vu_socket_path) {
> +        fuse_log(FUSE_LOG_ERR,
> +                 "fuse: --socket-group can only be used with --socket-pa=
th\n");
> +        goto out4;
> +    }
> =20
>      se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() + FUSE_BUFFER_HEA=
DER_SIZE;
> =20
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.=
c
> index 3b6d16a0417..331f9fc65c5 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -31,6 +31,8 @@
>  #include <sys/socket.h>
>  #include <sys/types.h>
>  #include <sys/un.h>
> +#include <sys/types.h>
> +#include <grp.h>
>  #include <unistd.h>
> =20
>  #include "contrib/libvhost-user/libvhost-user.h"
> @@ -924,15 +926,29 @@ static int fv_create_listen_socket(struct fuse_sess=
ion *se)
> =20
>      /*
>       * Unfortunately bind doesn't let you set the mask on the socket,
> -     * so set umask to 077 and restore it later.
> +     * so set umask appropriately and restore it later.
>       */
> -    old_umask =3D umask(0077);
> +    if (se->vu_socket_group) {
> +        old_umask =3D umask(S_IROTH | S_IWOTH | S_IXOTH);
> +    } else {
> +        old_umask =3D umask(S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IW=
OTH | S_IXOTH);
> +    }
>      if (bind(listen_sock, (struct sockaddr *)&un, addr_len) =3D=3D -1) {
>          fuse_log(FUSE_LOG_ERR, "vhost socket bind: %m\n");
>          close(listen_sock);
>          umask(old_umask);
>          return -1;
>      }
> +    if (se->vu_socket_group) {
> +        struct group *g =3D getgrnam(se->vu_socket_group);
> +        if (g) {
> +            if (!chown(se->vu_socket_path, -1, g->gr_gid)) {
> +                fuse_log(FUSE_LOG_WARNING,
> +                         "vhost socket failed to set group to %s (%d)\n"=
,
> +                         se->vu_socket_group, g->gr_gid);
> +            }
> +        }
> +    }
>      umask(old_umask);
> =20
>      if (listen(listen_sock, 1) =3D=3D -1) {
> --=20
> 2.20.1
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


