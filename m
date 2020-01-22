Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F50C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7A72465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCpS4F3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7A72465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuKUC-0000pz-Gz
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 13:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuKTU-0000Nr-Uz
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuKTR-0002Gd-Bh
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:11:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42566
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuKTR-0002Fj-7f
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579716688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jC83L89yNK6jT0NJcxZF+nRgSUPF01iGRViL2/wrVnE=;
 b=YCpS4F3MV/W2eGG97WW1trLftgw7blPFW54naZkhD2WWHsUInrL1/sktyQGI3dGWUSnbB5
 LKyvmplg+nX/Nw72lIJqMsQQbgnCzSyjhy3SWIBjOTxaoT79opOV6aWzTNcwnEp0oPKGCB
 tJOxgCuoiON0ifVKQYb3o2m0rN1pi84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-J_bzlYbKNZeoWG6ra_aRAA-1; Wed, 22 Jan 2020 13:11:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F3651882CC2;
 Wed, 22 Jan 2020 18:11:25 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 068DB5C1BB;
 Wed, 22 Jan 2020 18:11:16 +0000 (UTC)
Date: Wed, 22 Jan 2020 18:11:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH v2 109/109] virtiofsd: add some options to the help message
Message-ID: <20200122181114.GP3263@work-vm>
References: <20200121122433.50803-110-dgilbert@redhat.com>
 <20200122063532.18649-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200122063532.18649-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: J_bzlYbKNZeoWG6ra_aRAA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, stefanha@redhat.com, philmd@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >=20
> > Add following options to the help message:
> > - cache
> > - flock|no_flock
> > - norace
> > - posix_lock|no_posix_lock
> > - readdirplus|no_readdirplus
> > - timeout
> > - writeback|no_writeback
> > - xattr|no_xattr
> >=20
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >=20
> > dgilbert: Split cache, norace, posix_lock, readdirplus off
> >   into our own earlier patches that added the options
> >=20
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com><Paste>
>=20
> Hello,
>=20
> I think we also need to remove unused options from help message as well.
> Could you please review following patch and add or fold to this patch
> if it is ok.
>=20
> Thanks,
> Misono

Thanks, I've merged that into the 'Trim down imported files'

> =3D=3D=3D=3D=3D
> [PATCH] virtiofsd: Remove unused options
>=20
> Following options came from libfuse but not used in virtiofs:
>  - allow_other (always set to 1 in guest kernel)
>  - auto_unmount
>  - -s (singlethread)
>=20
> Let's remove unused options from help in order not to confuse users.
>=20
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> ---
>  tools/virtiofsd/fuse_lowlevel.c | 12 +++---------
>  tools/virtiofsd/fuse_lowlevel.h |  1 -
>  tools/virtiofsd/helper.c        |  2 --
>  3 files changed, 3 insertions(+), 12 deletions(-)
>=20
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index 2ce3e739fd..00554c6aa7 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2539,11 +2539,9 @@ void fuse_lowlevel_help(void)
>       * potentially of interest to an end-user
>       */
>      printf(
> -        "    -o allow_other             allow access by all users\n"
>          "    -o allow_root              allow access by root\n"
>          "    --socket-path=3DPATH         path for the vhost-user socket=
\n"
>          "    --fd=3DFDNUM                 fd number of vhost-user socket=
\n"
> -        "    -o auto_unmount            auto unmount on process terminat=
ion\n"
>          "    --thread-pool-size=3DNUM     thread pool size limit (defaul=
t %d)\n",
>          THREAD_POOL_SIZE);
>  }
> @@ -2612,14 +2610,10 @@ struct fuse_session *fuse_session_new(struct fuse=
_args *args,
>           * Allowing access only by root is done by instructing
>           * kernel to allow access by everyone, and then restricting
>           * access to root and mountpoint owner in libfuse.
> +         *
> +         * Note: allow_other is set to 1 in guest kernel for virtiofs
> +         * so nothing needs to be done here
>           */
> -        /*
> -         * We may be adding the option a second time, but
> -         * that doesn't hurt.
> -         */
> -        if (fuse_opt_add_arg(args, "-oallow_other") =3D=3D -1) {
> -            goto out2;
> -        }
>      }

I took out the surrounding 'if' as well because there was nothing left
except for the comment.

Dave

>      if (args->argc =3D=3D 1 && args->argv[0][0] =3D=3D '-') {
>          fuse_log(FUSE_LOG_ERR,
> diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowle=
vel.h
> index 3a7213f42f..aa5f62c846 100644
> --- a/tools/virtiofsd/fuse_lowlevel.h
> +++ b/tools/virtiofsd/fuse_lowlevel.h
> @@ -1820,7 +1820,6 @@ void fuse_cmdline_help(void);
>   */
> =20
>  struct fuse_cmdline_opts {
> -    int singlethread;
>      int foreground;
>      int debug;
>      int nodefault_subtype;
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 8f00737b1a..9dd4199800 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -47,7 +47,6 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
>      FUSE_OPT_KEY("debug", FUSE_OPT_KEY_KEEP),
>      FUSE_HELPER_OPT("-f", foreground),
>      FUSE_HELPER_OPT_VALUE("--daemonize", foreground, 0),
> -    FUSE_HELPER_OPT("-s", singlethread),
>      FUSE_HELPER_OPT("fsname=3D", nodefault_subtype),
>      FUSE_OPT_KEY("fsname=3D", FUSE_OPT_KEY_KEEP),
>      FUSE_HELPER_OPT("subtype=3D", nodefault_subtype),
> @@ -145,7 +144,6 @@ void fuse_cmdline_help(void)
>             "    --syslog                   log to syslog (default stderr=
)\n"
>             "    -f                         foreground operation\n"
>             "    --daemonize                run in background\n"
> -           "    -s                         disable multi-threaded operat=
ion\n"
>             "    -o cache=3D<mode>            cache mode. could be one of=
 \"auto, "
>             "always, none\"\n"
>             "                               default: auto\n"
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


