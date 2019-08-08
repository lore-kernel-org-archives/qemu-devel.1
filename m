Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2974AC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD32214C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD32214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvj56-0001wA-QF
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hvj4i-0001Qc-1a
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hvj4g-0004l0-Tm
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:07:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hvj4e-0004hD-4D; Thu, 08 Aug 2019 10:07:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64B6E50F45;
 Thu,  8 Aug 2019 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-31.ams2.redhat.com
 [10.36.116.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9018760A9D;
 Thu,  8 Aug 2019 14:07:20 +0000 (UTC)
Date: Thu, 8 Aug 2019 16:07:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190808140719.GC10611@localhost.localdomain>
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-2-dplotnikov@virtuozzo.com>
 <325bf443-64fb-ecde-f08a-978e9bede31b@redhat.com>
 <82193040-c2ac-93fc-4230-8bbe136aef3c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <82193040-c2ac-93fc-4230-8bbe136aef3c@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 08 Aug 2019 14:07:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qcow2: introduce compression type
 feature
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.08.2019 um 14:50 hat Max Reitz geschrieben:
> On 08.08.19 02:18, Eric Blake wrote:
> > On 7/4/19 8:09 AM, Denis Plotnikov wrote:
> >> The patch adds some preparation parts for incompatible compression type
> >> feature to QCOW2 header that indicates that *all* compressed clusters
> >> must be (de)compressed using a certain compression type.
> >>
> >> It is implied that the compression type is set on the image creation a=
nd
> >> can be changed only later by image conversion, thus compression type
> >> defines the only compression algorithm used for the image.
> >>
> >> The goal of the feature is to add support of other compression algorit=
hms
> >> to qcow2. For example, ZSTD which is more effective on compression tha=
n ZLIB.
> >> It works roughly 2x faster than ZLIB providing a comparable compressio=
n ratio
> >> and therefore provide a performance advantage in backup scenarios.
> >=20
> > provides
> >=20
> >>
> >> The default compression is ZLIB. Images created with ZLIB compression =
type
> >> are backward compatible with older qemu versions.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >=20
> >> +++ b/docs/interop/qcow2.txt
> >> @@ -109,7 +109,12 @@ in the description of a field.
> >>                                  An External Data File Name header ext=
ension may
> >>                                  be present if this bit is set.
> >> =20
> >> -                    Bits 3-63:  Reserved (set to 0)
> >> +                    Bit 3:      Compression type bit. The bit must be=
 set if
> >> +                                the compression type differs from def=
ault: zlib.
> >=20
> > I'd word this 'from the default of zlib.'
> >=20
> >> +                                If the compression type is default th=
e bit must
> >> +                                be unset.
> >=20
> > Why? I see no reason to forbid a qcow2 image that has the incompatible
> > bit set but still uses zlib compression.  True, such an image is not as
> > friendly to older clients, but it is not technically wrong, and newer
> > clients would still be able to use the image if not for this sentence
> > telling them they must not.
>=20
> Just because an image doesn=E2=80=99t adhere to the specification doesn=
=E2=80=99t mean
> you have to reject it, if the intention is clear.
>=20
> > I'd drop this sentence.
>=20
> I wouldn=E2=80=99t, I like it (in essence).  Though maybe the =E2=80=9Cmu=
st=E2=80=9D is indeed
> too strong and it should be a =E2=80=9Cshould=E2=80=9D instead.

I'd agree that "should" is the best way for the spec.

In the code, I'd insist that QEMU doesn't add any extra code to verify
that this is the case (which previous versions of the series did).

Kevin

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdTCyXAAoJEH8JsnLIjy/WfUkP/jIRkkALtg/msC3Rs0YWmrGa
D3d6deM9e0ncUtYvjAWmaMG/8mUEexgOM0SvCJX1/11n3Ni8Dj4VL4FFfecshbCq
1f4gdve++3kWFoWidv1vv8fCABWZQJMGDUV/Wf77cWLvfHoKfEECSfsR9fAqzXjX
QcBSg0qT5uhfNHrOdGyUFCePoUtwcy75Umlon4/vbUbySYt2cHR7IQuryU745gYB
YW3T+FHZmVvg7/4Ez+cSslPDeA+fL0J89irdgzAbTbiN8zQiz3avclXfuWEywNdS
Omq7qx6sitmrMD7eOWVyEoIOgjDwGmfe0t9QZo9GSxsju0lRGGohhkFRDlmD9djH
4rqeJPL4HeEm2SFI7oAGK2eylyufgfUvug76D39fupJPfCYDLqoN4KGnreHJa+Rq
QTdjS+ibgD4WsLAYUpxK54llouXsmJ//GgiIrdB0UCEYACTsLU6Mm2kannvq5Jx7
Dil+534IcWctI7eSb78UgdplyyDLTkW0PPozPZSk5Q3LlDQ+PBX5tnYTyqRE+kiq
x499MykWvrjy+Of6vaR7xfPIrvJv7EC488BtuFDUz+U3srmuYDLBhSJcjoauf0Jw
gqXRIdeWBVfa5KHLTYSGyPX81kkJDf9QbrCWAB1Py78YtdMmFL9RjzRXO7IW/7+A
PDiP2QYRBHtWeQ5bfO0c
=S5BR
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

