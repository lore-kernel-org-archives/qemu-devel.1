Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA9C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8976E21897
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8976E21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWJe-0006Yc-Ks
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iAWHc-0005D9-6U
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iAWHa-0001kP-6B
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:29:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iAWHW-0001jP-Dp; Wed, 18 Sep 2019 05:29:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAE1286662;
 Wed, 18 Sep 2019 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-230.ams2.redhat.com
 [10.36.116.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2F17600CC;
 Wed, 18 Sep 2019 09:29:45 +0000 (UTC)
Date: Wed, 18 Sep 2019 11:29:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190918092944.GE5207@localhost.localdomain>
References: <20190918085519.17290-1-kwolf@redhat.com>
 <726ed3db-fe67-98ff-5829-344dc6e04278@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <726ed3db-fe67-98ff-5829-344dc6e04278@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 18 Sep 2019 09:29:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Require Python 3.5 or later
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
Cc: jsnow@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.09.2019 um 11:20 hat Max Reitz geschrieben:
> On 18.09.19 10:55, Kevin Wolf wrote:
> > Running iotests is not required to build QEMU, so we can have stricter
> > version requirements for Python here and can make use of new features
> > and drop compatibility code earlier.
> >=20
> > This makes qemu-iotests skip all Python tests if a Python version before
> > 3.5 is used for the build.
> >=20
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/check | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> > index 875399d79f..a68f414d6c 100755
> > --- a/tests/qemu-iotests/check
> > +++ b/tests/qemu-iotests/check
> > @@ -633,6 +633,13 @@ then
> >      export SOCKET_SCM_HELPER=3D"$build_iotests/socket_scm_helper"
> >  fi
> > =20
> > +# Note that if the Python conditional here evaluates True we will exit
> > +# with status 1 which is a shell 'false' value.
>=20
> I=E2=80=99d expect everything to exit with 1 if something does not work. =
 Thus,
> I find the short script confusing (I think you do, too, or you wouldn=E2=
=80=99t
> have written this comment).  Why not make it =E2=80=9Csys.exit(0 if
> sys.version_info >=3D (3, 5) else 1)=E2=80=9D?

I just copied it from configure, actually. :-)

But we can use your way, too. I don't really mind.

Kevin

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdgfkIAAoJEH8JsnLIjy/WRFkP/0OM2dLeJV6X7cCrWkGcyj6f
O7otjp5RmGnir2Mckw9u/EzgctaTydsTgWQib4cGnqh7hmFibAT12QBm5xXRrxNh
9XMc0pYCAG+oczT28LnWDZqBE7+39FCpYN/sDEAmzSxLwijNgYAEbcYbMAP7dmW2
1Il0mx+mJIwkPKFTKq1y59drTzdhif2SyESiM+ryyzTQOA0LcD7/88RFYASWK8XH
FPMUV2wASt9BB7+d8XJPMTnbDdBuSm2ngUWEwI/ve6e9upvhD53jkitPLG4pPyC9
JMCy+HUONZMBC2T5bzN0ec6cXDzv8gV8u4UkLeYpugWHGGo+YSlj1Z2JzsDpExEx
NdHELg5ZpH2aGT9MFcN28O8vuvj+FRwMaxZeXK6UbXZNvGXlUjpR8myVqmN0Bx6W
wNPvcTMAfwVt8AMqGSW9wbkHANvkLlfXERu2evd9QXQ240R58mt1mOosNGuY8K5r
q1zy9K0BGzd2QtErB3F5Nloey3en+2hdEsKrbqcn+JQ4tEZGw3u3SUq60StDJia6
o397zD118el+5sx7+lUQ9xLkLm4svcf/F5GXQAGmn9P0dcJzP7jpitVKszXh0u+s
Us2IrtJIn5HkRfrdbAybbUaKGE9voFqJZ0VeJhkEVvR2gjr5h6BxduncjNVrrBjM
pxl7/fxTt9xyTXpDnpGa
=86/f
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

