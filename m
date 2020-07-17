Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57996204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPFkrh4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57996204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOjA-0008W8-GE
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jwOiU-00082j-RG
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:39:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jwOiT-000650-82
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594985987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2kwjHNkBDl6dYE4D/mrtrHnD3NR2uPV3G9K2mrWMLZo=;
 b=aPFkrh4NqWsAFa7bgJtAFiPNKOJlc5by0ZfgIaDkZvqCjObXbrIlCzJlNqI3BwKehyBvVk
 f5EIZ8rC+QRihL1x6xdWszcwb0lQ1/ocRp+dvXDQF1j2N4jRDdJ1D/kkttA7WInhnn5CqF
 TnzX7QDEKgzDfPWTWb5PPBP5eyhNhdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-6QvxQCFqNTiEYQZED4TKiw-1; Fri, 17 Jul 2020 07:39:45 -0400
X-MC-Unique: 6QvxQCFqNTiEYQZED4TKiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4454218A1DE7
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 11:39:44 +0000 (UTC)
Received: from localhost (ovpn-112-29.rdu2.redhat.com [10.10.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E0DE5C1D3;
 Fri, 17 Jul 2020 11:39:41 +0000 (UTC)
Date: Fri, 17 Jul 2020 13:39:40 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] virtiofsd: Remove "norace" from cmdline help
Message-ID: <20200717113940.b77kjptryyjszll7@mhamilton>
References: <20200716101442.48057-1-slp@redhat.com>
 <20200717091414.lhi4ho6xqol2tixi@steredhat.lan>
MIME-Version: 1.0
In-Reply-To: <20200717091414.lhi4ho6xqol2tixi@steredhat.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pociqooz4nsrhin4"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Miklos Szeredi <mszeredi@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pociqooz4nsrhin4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 11:14:14AM +0200, Stefano Garzarella wrote:
> On Thu, Jul 16, 2020 at 12:14:42PM +0200, Sergio Lopez wrote:
> > Commit 93bb3d8d4cda ("virtiofsd: remove symlink fallbacks") removed
> > the implementation of the "norace" option, so remove it from the
> > cmdline help too.
> >=20
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > ---
> >  tools/virtiofsd/helper.c | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > index 3105b6c23a..7bc5d7dc5a 100644
> > --- a/tools/virtiofsd/helper.c
> > +++ b/tools/virtiofsd/helper.c
> > @@ -159,8 +159,6 @@ void fuse_cmdline_help(void)
> >             "    -o max_idle_threads        the maximum number of idle =
worker "
> >             "threads\n"
> >             "                               allowed (default: 10)\n"
> > -           "    -o norace                  disable racy fallback\n"
> > -           "                               default: false\n"
> >             "    -o posix_lock|no_posix_lock\n"
> >             "                               enable/disable remote posix=
 lock\n"
> >             "                               default: posix_lock\n"
> > --=20
> > 2.26.2
> >=20
> >=20
>=20
> I noticed that 'norace' is also described in docs/tools/virtiofsd.rst,
> so I think we need to remove it there too:
>=20
>     diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
>     index 824e713491..58666a4495 100644
>     --- a/docs/tools/virtiofsd.rst
>     +++ b/docs/tools/virtiofsd.rst
>     @@ -63,9 +63,6 @@ Options
>          Print only log messages matching LEVEL or more severe.  LEVEL is=
 one of
>          ``err``, ``warn``, ``info``, or ``debug``.  The default is ``inf=
o``.
>=20
>     -  * norace -
>     -    Disable racy fallback.  The default is false.
>     -
>        * posix_lock|no_posix_lock -
>          Enable/disable remote POSIX locks.  The default is ``posix_lock`=
`.

Good catch, thanks. I'll send a v2.

Sergio.

> With that fixed:
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
> Thanks,
> Stefano
>=20

--pociqooz4nsrhin4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl8RjfsACgkQ9GknjS8M
AjW3Tw//TERZvnR0A8Yu2XOMICgAPXX3ynneVgpGbJUI2unAAGUOgjwxjP6IveF4
qnoOWvNaz6ck4/4PMuqe3vdVFRiRoXtd2JYABrgShZYdZc/fsSaKWNAMMhCAEkZy
BPjtiKWAe08VCTONkfHlqdwYZuO+OKtl9FgEZaC0DNXlAYUM1s06vyeaTmwngko6
Z38qZKjOiQKvrt1b/62RPXKTBtDLJHrL/+fuSV0U6Xu5DxI1CaiIMOhwgwqx0Gj/
7+7RpSEZxnbO4DYflL6qLbA9utGL84kvzd5LQDDjzKuBc+4BN9GZqV5uI84l5ioe
QXWppNr4vu0a8DATRma4BI08tCl2+h2OzbDh7a8MFely8K48uyE0VuXwwLjXbmDx
mg9zVfd4wMus6l77+vQ3zMxXvo9WKMLaxkeirRiqh5vr99ZzI/Q3gfcLb8AsDLOZ
3WGFqhbAae/GKZU/6tGP7eQet2h5EsKHpuGlxlVc4iIxZuOJueZObvf+h5Ra+3Js
xrDfKbRVh0blUJ542+Ux7+GFvOvyMkJBWjDDDOaDAGUwo9dFXtsDDQTjFnEMK/Mh
BRdNnjXAeKp4VqdwYS62Io+tWRm6vMBWfKuvFiEXABSm7WsEvufLJgsc2EUJvTAE
VJb120CKNki0kC13lJtHndeOHIAI9VTVtZbxPFAdk7RzAfj5ji4=
=yMWs
-----END PGP SIGNATURE-----

--pociqooz4nsrhin4--


