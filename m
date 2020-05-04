Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CE3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61136206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKCbkbCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61136206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXVj-0002gi-CG
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVXUq-0002Dr-59
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:34:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVXUo-0004MR-1k
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588584880;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5X9y5YsW1suyts7cQATuTFCgwi7KxYxz6MYkCb2Bic8=;
 b=XKCbkbCJBtV7IODeCv3o9JF/b331UqPQuUyRWpnu5vp05EIduF6WE7VchlwCJlrnPMmjC0
 2A6X0A2PPK5QWr1394vXbTdItZ3BiqJtgzOTfe5OEcC1oJTSZiFGyaUtvJFXJ8zgbPtsMs
 gXPLsKPTpgn+UohAvkBjHOpdFaWdpGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-ARbfmnf-OIG3Nqnc_6mBaA-1; Mon, 04 May 2020 05:34:36 -0400
X-MC-Unique: ARbfmnf-OIG3Nqnc_6mBaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A88A56C93;
 Mon,  4 May 2020 09:34:35 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAA172B6FB;
 Mon,  4 May 2020 09:34:27 +0000 (UTC)
Date: Mon, 4 May 2020 10:34:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH] chardev: enable distinct input for -chardev file
Message-ID: <20200504093423.GF115875@redhat.com>
References: <20200501172559.6470-1-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200501172559.6470-1-alxndr@bu.edu>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 01, 2020 at 01:25:59PM -0400, Alexander Bulekov wrote:
> char-file already supports distinct paths for input/output but it was
> only possible to specify a distinct input through QMP. With this change,
> we can also specify a distinct input with the -chardev file argument:
>     qemu -chardev file,id=3Dchar1,path=3D/out/file,in=3D/in/file
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  chardev/char-file.c | 5 +++++
>  chardev/char.c      | 3 +++
>  qemu-options.hx     | 7 +++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
>=20
> The naming here is awkward, with path=3D really turning into "out" when
> in=3D is specified, though i'm not sure about what is a good solution.
>=20
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 2fd80707e5..cc742cc234 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -100,6 +100,7 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, C=
hardevBackend *backend,
>                                      Error **errp)
>  {
>      const char *path =3D qemu_opt_get(opts, "path");
> +    const char *in =3D qemu_opt_get(opts, "in");
>      ChardevFile *file;
> =20
>      backend->type =3D CHARDEV_BACKEND_KIND_FILE;
> @@ -110,6 +111,10 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, =
ChardevBackend *backend,
>      file =3D backend->u.file.data =3D g_new0(ChardevFile, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevFile_base(file));
>      file->out =3D g_strdup(path);
> +    if (in) {
> +        file->has_in =3D true;
> +        file->in =3D g_strdup(qemu_opt_get(opts, "in"));
> +    }
> =20
>      file->has_append =3D true;
>      file->append =3D qemu_opt_get_bool(opts, "append", false);
> diff --git a/chardev/char.c b/chardev/char.c
> index e77564060d..797574f205 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -849,6 +849,9 @@ QemuOptsList qemu_chardev_opts =3D {
>          },{
>              .name =3D "path",
>              .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "in",
> +            .type =3D QEMU_OPT_STRING,
>          },{
>              .name =3D "host",
>              .type =3D QEMU_OPT_STRING,
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 292d4e7c0c..bbb091872f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2938,7 +2938,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev vc,id=3Did[[,width=3Dwidth][,height=3Dheight]][[,cols=3Dco=
ls][,rows=3Drows]]\n"
>      "         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]\n"
>      "-chardev ringbuf,id=3Did[,size=3Dsize][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> -    "-chardev file,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n"
> +    "-chardev file,id=3Did,path=3Dpath[,in=3DPATH][,mux=3Don|off][,logfi=
le=3DPATH][,logappend=3Don|off]\n"
>      "-chardev pipe,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n"
>  #ifdef _WIN32
>      "-chardev console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> @@ -3137,13 +3137,16 @@ The available backends are:
>      Create a ring buffer with fixed size ``size``. size must be a power
>      of two and defaults to ``64K``.
> =20
> -``-chardev file,id=3Did,path=3Dpath``
> +``-chardev file,id=3Did,path=3Dpath,in=3Din``
>      Log all traffic received from the guest to a file.
> =20
>      ``path`` specifies the path of the file to be opened. This file will
>      be created if it does not already exist, and overwritten if it does.
>      ``path`` is required.
> =20
> +    ``in`` specifies a separate file as the input to the chardev. If
> +    ``in`` is omitted, ``path`` is used for both input and output

I'd suggest "pathin" rather than just "in"


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


