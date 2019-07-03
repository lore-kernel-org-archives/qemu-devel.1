Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2287C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC132187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC132187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hii4A-0008OA-SO
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57058)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hihms-0003LH-Vc
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hihmq-0000Rf-Tn
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:07:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hihmo-0000NO-BN; Wed, 03 Jul 2019 12:07:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5AE5E81127;
 Wed,  3 Jul 2019 16:07:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-252.ams2.redhat.com [10.36.116.252])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A136784E7;
 Wed,  3 Jul 2019 16:07:04 +0000 (UTC)
Date: Wed, 3 Jul 2019 18:07:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190703160703.GB7764@linux.fritz.box>
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-4-dplotnikov@virtuozzo.com>
 <e61d7afc-09ce-d52d-3987-df1d5ba6977f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <e61d7afc-09ce-d52d-3987-df1d5ba6977f@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 03 Jul 2019 16:07:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 3/3] qcow2: add zstd cluster compression
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
 qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.07.2019 um 16:36 hat Eric Blake geschrieben:
> On 7/3/19 6:00 AM, Denis Plotnikov wrote:
> > zstd significantly reduces cluster compression time.
> > It provides better compression performance maintaining
> > the same level of compression ratio in comparison with
> > zlib, which, by the moment, has been the only compression
> > method available.
> >=20
>=20
> > ---
> >  block/qcow2.c        | 96 ++++++++++++++++++++++++++++++++++++++++++++
> >  configure            | 32 +++++++++++++++
> >  qapi/block-core.json |  3 +-
> >  3 files changed, 130 insertions(+), 1 deletion(-)
>=20
> Where is the change to docs/interop/qcow2.txt to describe this new
> compression format?
>=20
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 37a563a671..caa04b0beb 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -27,6 +27,11 @@
> >  #define ZLIB_CONST
> >  #include <zlib.h>
> > =20
>=20
> > +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> > +                                   const void *src, size_t src_size)
> > +{
> > +    ssize_t ret;
> > +    uint32_t *c_size =3D dest;
> > +    /* steal some bytes to store compressed chunk size */
> > +    char *d_buf =3D ((char *) dest) + sizeof(*c_size);
> > +
>=20
> Do you always want exactly 4 bytes for the compressed size? Or is it
> worth some sort of variable-length encoding, since we're already dealing
> with non-cacheline-aligned data? You can represent all sizes up to 4M
> using a maximum of 3 bytes (set the high bit if the integer continues,
> then sizes 0-127 take 1 byte [7 bits], 128-32767 take 2 bytes [15 bits],
> and 32768-4194303 take 3 bytes [22 bits]).

I don't think the additional complexity is worth it. The combination of
endianness conversions (which are missing here, this is a bug!) and
variable lengths is almost guaranteed to not only give us headaches, but
also to result in corner case bugs.

Also, are we sure that we will always keep 2M as the maximum cluster
size?

Kevin

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdHNKnAAoJEH8JsnLIjy/WagcP/2kQ+U7a9rGgDL9DnnPRvtpa
57s/Yz965YK1JY53ExgxX2MV2oebbVqn0yHOeetnLNvtAvzZpfWtt4Um/QdUHHPf
E9IeCX/wrOeEWxDsXZYdMFWxm7DPCReqtznVG9lXWmmlbs3ubV8sfzlRSEaly4FA
Pb6gSinGtqOYbwOwkamblAhAKZLtMRA1Gew9cj1taHN0sAoY5ieaOISRReMQBzlp
r0fdRZPSEDPTTYAK6FZtOgGCC5wMQMgXsEgjAOpOtP1jYICGhnyZB5BbwXVl0GZs
fLWd/ZPk+y2nlN/AgozQrAvok/A3naFk5FP8zxSFilsOBj0noqvKHeBAJJomNd8A
QNW9o9y4pWzW7QlERZBFeZNZTBL9ZnC3caVyll6TmOY0KBLV+juXD44d0UPuVGiI
dcuHTXL42+YKHcIW6bNhxuIVpv5OfXfp7SV20lTE8K3QIzBQm3fvkTDLHrQGDuKb
H5q3CJShA66ttqAaGRGFDQAKOLtgC4pgyY0u1POv1rQjGTTHcTfmyJEVoOGxzC98
QIaN/lOVlrkMc6i5Vougm+C/SMxd4Plsjm/O52vnF/eOHLZpP457e1CGGJp7UvEX
EFt1bviKqsWG2lqUC0QMJwMsZbkdkPmIKGBy21/pYQHcjsJoDnMdLZJ5KDA4sXQ1
G0OAmd6SFtnnhJhTXcEd
=Z5Bu
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

