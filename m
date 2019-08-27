Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B7FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E558214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E558214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2cFw-0005fn-84
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2cEx-0005GN-IH
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2cEw-0001yg-7a
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:14:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i2cEv-0001yT-Vd
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:14:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4208E18B3D84;
 Tue, 27 Aug 2019 14:14:29 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5A1660BFB;
 Tue, 27 Aug 2019 14:14:28 +0000 (UTC)
Date: Tue, 27 Aug 2019 15:14:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: piaojun <piaojun@huawei.com>
Message-ID: <20190827141427.GD6901@stefanha-x1.localdomain>
References: <20190823092401.11883-1-stefanha@redhat.com>
 <20190823092401.11883-2-stefanha@redhat.com>
 <b60880a6-ff0b-0137-81d4-de9626cc75c2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <b60880a6-ff0b-0137-81d4-de9626cc75c2@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 27 Aug 2019 14:14:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] virtiofsd: replace warn(3) and
 warnx(3) with fuse_warning()
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 11:09:52PM +0800, piaojun wrote:
>=20
>=20
> On 2019/8/23 17:24, Stefan Hajnoczi wrote:
> > Do not use warn(3) and warnx(3) since they print to stderr.  When
> > --syslog is used these messages must go to syslog(3) instead.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  contrib/virtiofsd/passthrough_ll.c | 36 +++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/pas=
sthrough_ll.c
> > index ca11764feb..873e0938a7 100644
> > --- a/contrib/virtiofsd/passthrough_ll.c
> > +++ b/contrib/virtiofsd/passthrough_ll.c
> > @@ -628,12 +628,12 @@ retry:
> > =20
> >  	res =3D readlinkat(lo->proc_self_fd, procname, path, PATH_MAX);
> >  	if (res < 0) {
> > -		warn("lo_parent_and_name: readlink failed");
> > +		fuse_warning("lo_parent_and_name: readlink failed: %m\n");
> >  		goto fail_noretry;
> >  	}
> > =20
> >  	if (res >=3D PATH_MAX) {
> > -		warnx("lo_parent_and_name: readlink overflowed");
> > +		fuse_warning("lo_parent_and_name: readlink overflowed\n");
> >  		goto fail_noretry;
> >  	}
> >  	path[res] =3D '\0';
> > @@ -641,7 +641,7 @@ retry:
> >  	last =3D strrchr(path, '/');
> >  	if (last =3D=3D NULL) {
> >  		/* Shouldn't happen */
> > -		warnx("lo_parent_and_name: INTERNAL ERROR: bad path read from proc");
> > +		fuse_warning("lo_parent_and_name: INTERNAL ERROR: bad path read from=
 proc\n");
> >  		goto fail_noretry;
> >  	}
> >  	if (last =3D=3D path) {
> > @@ -655,13 +655,13 @@ retry:
> >  		res =3D fstatat(AT_FDCWD, last =3D=3D path ? "/" : path, &stat, 0);
> >  		if (res =3D=3D -1) {
> >  			if (!retries)
> > -				warn("lo_parent_and_name: failed to stat parent");
> > +				fuse_warning("lo_parent_and_name: failed to stat parent: %m\n");
> >  			goto fail;
> >  		}
> >  		p =3D lo_find(lo, &stat);
> >  		if (p =3D=3D NULL) {
> >  			if (!retries)
> > -				warnx("lo_parent_and_name: failed to find parent");
> > +				fuse_warning("lo_parent_and_name: failed to find parent\n");
> >  			goto fail;
> >  		}
> >  	}
> > @@ -669,12 +669,12 @@ retry:
> >  	res =3D fstatat(p->fd, last, &stat, AT_SYMLINK_NOFOLLOW);
> >  	if (res =3D=3D -1) {
> >  		if (!retries)
> > -			warn("lo_parent_and_name: failed to stat last");
> > +			fuse_warning("lo_parent_and_name: failed to stat last: %m\n");
> >  		goto fail_unref;
> >  	}
> >  	if (stat.st_dev !=3D inode->key.dev || stat.st_ino !=3D inode->key.in=
o) {
> >  		if (!retries)
> > -			warnx("lo_parent_and_name: filed to match last");
> > +			fuse_warning("lo_parent_and_name: filed to match last\n");
>=20
> Typo *filed* -> *failed*, and others looks good to me. Feel free to add:
>=20
> Reviewed-by: Jun Piao <piaojun@huawei.com>

Thanks for pointing this out.  I will send a separate patch to fix it
since it's a pre-existing typo and not related to the
s/warnx/fuse_warning/ change in this patch.

Stefan

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1lOsMACgkQnKSrs4Gr
c8hxlgf6Ah4H+y70dIjBa2MR+GzQ8ZAh+Z+N5LncK2O66Rr/u/ota7axgYCJlVBY
zwUPKSOoqgjLYb//VYydvCa+6VM4cKBMgxuC7mEotcjnnzVmfGwacNh3KFRlCmlS
X18S5I/mNSF+q2nzj136HQssVlpGvvu+roxfuaaH6YvRckBdOXEcRT9jb2DrJebZ
aFejx7Cgf5nXKijTCazaCfg7QBAS4/9kM4doOEcT0AmCYke+qaX/su+qd09sx0lV
q8mdHQ7qouTImxTW59pVIjNNsHkDx+u+7F1s1tFM9aXxrhAJcFCiAT1AhgP2qK5G
vGkgj7hANecspOORaBuq85DTP93imQ==
=ofNh
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--

