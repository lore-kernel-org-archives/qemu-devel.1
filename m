Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E703BC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45FA2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45FA2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36571 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYx66-0000bX-2N
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:26:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1hYwYF-00006i-4U
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1hYwYC-0000uR-RC
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ptoscano@redhat.com>)
	id 1hYwY6-0000pj-5r; Thu, 06 Jun 2019 13:51:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EA73307D869;
	Thu,  6 Jun 2019 17:51:26 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (ovpn-204-97.brq.redhat.com
	[10.40.204.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 34C8A6A23E;
	Thu,  6 Jun 2019 17:51:21 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Date: Thu, 06 Jun 2019 19:51:15 +0200
Message-ID: <3631777.4JPVOlAZr6@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <20190606111232.GG14300@redhat.com>
References: <20190605213654.9785-1-ptoscano@redhat.com>
	<20190606111232.GG14300@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart59998215.3l7yhbUXgf";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 06 Jun 2019 17:51:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6] ssh: switch from libssh2 to libssh
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, rjones@redhat.com,
	qemu-devel@nongnu.org, mreitz@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart59998215.3l7yhbUXgf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, 6 June 2019 13:12:32 CEST Daniel P. Berrang=E9 wrote:
> On Wed, Jun 05, 2019 at 11:36:54PM +0200, Pino Toscano wrote:
> > Rewrite the implementation of the ssh block driver to use libssh instead
> > of libssh2.  The libssh library has various advantages over libssh2:
> > - easier API for authentication (for example for using ssh-agent)
> > - easier API for known_hosts handling
> > - supports newer types of keys in known_hosts
> >=20
> > Use APIs/features available in libssh 0.8 conditionally, to support
> > older versions (which are not recommended though).
>=20
>=20
> >=20
> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> > ---
> >=20
> > Changes from v5:
> > - adapt to newer tracing APIs
> > - disable ssh compression (mimic what libssh2 does by default)
> > - use build time checks for libssh 0.8, and use newer APIs directly
> >=20
> > Changes from v4:
> > - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
> > - fix few return code checks
> > - remove now-unused parameters in few internal functions
> > - allow authentication with "none" method
> > - switch to unsigned int for the port number
> > - enable TCP_NODELAY on the socket
> > - fix one reference error message in iotest 207
> >=20
> > Changes from v3:
> > - fix socket cleanup in connect_to_ssh()
> > - add comments about the socket cleanup
> > - improve the error reporting (closer to what was with libssh2)
> > - improve EOF detection on sftp_read()
> >=20
> > Changes from v2:
> > - used again an own fd
> > - fixed co_yield() implementation
> >=20
> > Changes from v1:
> > - fixed jumbo packets writing
> > - fixed missing 'err' assignment
> > - fixed commit message
> >=20
> >  block/Makefile.objs        |   6 +-
> >  block/ssh.c                | 610 +++++++++++++++++++------------------
> >  block/trace-events         |  14 +-
> >  configure                  |  62 ++--
> >  tests/qemu-iotests/207.out |   2 +-
> >  5 files changed, 351 insertions(+), 343 deletions(-)
>=20
>=20
> > diff --git a/configure b/configure
> > index b091b82cb3..bfdd70c40a 100755
> > --- a/configure
> > +++ b/configure
>=20
> > @@ -3914,43 +3914,17 @@ EOF
> >  fi
> > =20
> >  ##########################################
> > -# libssh2 probe
> > -min_libssh2_version=3D1.2.8
>=20
> The commit message says we're conditionally using APIs from 0.8.0,
> but doesn't say what minimum version we actually need and there's
> no check here.

When I started to work on this, the libssh version available was
0.6.x IIRC, which is very old.  This v6 uses APIs added in 0.8
conditionally, so it will still build with libssh < 0.8 -- of course,
using an older libssh results in a less performant ssh driver, although
I would think this can be considered somehow acceptable.

> In terms of our supported build platforms, the oldest libssh I
> see is RHEL-7 with 0.7.1.
>=20
> So assume it does actually compile on RHEL-7, then it is desirable
> to have a min_libssh_Version=3D0.7.1 set here & checked below.

=46or now I do not see the need to enforce a minimum version required;
it can be easily added in the future in case we need to use an API only
available starting from some version, and there is no fallback way for
older versions.

=2D-=20
Pino Toscano
--nextPart59998215.3l7yhbUXgf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAlz5UpMACgkQw9FMLZhk
N83ekw/8Cw509f6av3GwaiPkhq29iuTwSCOilNkG5kmt/tVSCBzcgY2NJ3/FDfkO
MahdztedkqFo2X4J3MZdgPNZAGLvibyXudyMd4xZ9fip4zvPJgP4xhp8aP5QnR4A
bxmLjxlH/yZDrVmspdpx8VSPsQ/6nuD75uWA9dWZrtyST2T6PnzMP5f7WZg2wZ8e
mIioGY30uPPh+Lign9dZQSMX6yM+W5zT9vhpTXc4EbL4i2QzFDerH5AAf4aL/u1V
9uZcydtA4CS0IvRrw51hYPCf260w+E5V4eg6BB3SwaTorJB5py+eZB7JKxFKgl6P
yYaYzqauJX/C/cwcVXI8/8KUvhgQB9nYirU1gWnb/Twt6DvQif7pH6RjB0E7wm3e
33MIyZPiWZceW9irg7+DSFhqBnkRcx7YSsjCmz0zq3Gf/P2fem6zpF959tg9ogjL
uPYFQQGkfaIrgcYc1cG1u5hIGKZ3mr16mYLhyPLsnZ42UMqLlyJ9PNViWqGvIGbw
bT0/rv9jFXGzqi6O5sXZEmP8+gU5JGOPP7LTry5OZH0PKExNy7Thts7IGGpfF2cw
xp64bklbNa2nbwXLSjGfPSVMSgZwbxD2AW5uqerahBodlbialmBnLr/7upB1EiXa
erQ0ORKh68JC1jJA3BE8h/nFawKBPXqj6F1hBpu8wxOgpjVmUW8=
=IeqF
-----END PGP SIGNATURE-----

--nextPart59998215.3l7yhbUXgf--




