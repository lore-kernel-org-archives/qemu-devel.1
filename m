Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA04C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93954205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93954205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYKz-0006i5-Os
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45229)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hxYKN-0005jB-CK
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hxYKM-0005TH-BI
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:03:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hxYKJ-0005R9-V0; Tue, 13 Aug 2019 11:03:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B41730EA1BB;
 Tue, 13 Aug 2019 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-18.ams2.redhat.com
 [10.36.117.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BE7F794BE;
 Tue, 13 Aug 2019 15:03:05 +0000 (UTC)
Date: Tue, 13 Aug 2019 17:03:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190813150303.GK4663@localhost.localdomain>
References: <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
 <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
 <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
 <20190813115115.GG4663@localhost.localdomain>
 <b0c32bfc-f4cf-0d46-beb8-ba4cf79b76c5@redhat.com>
 <48fa03d6-259d-9ded-dacb-a4975f8d24e4@virtuozzo.com>
 <fcad59bc-0190-004f-3aee-20dfb3fc3a89@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <fcad59bc-0190-004f-3aee-20dfb3fc3a89@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 13 Aug 2019 15:03:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.08.2019 um 16:53 hat Max Reitz geschrieben:
> On 13.08.19 16:46, Vladimir Sementsov-Ogievskiy wrote:
> > 13.08.2019 17:31, Max Reitz wrote:
> >> On 13.08.19 13:51, Kevin Wolf wrote:
> >>
> >> [...]
> >>
> >>> Hm... This is a mess. :-)
> >>
> >> Just out of curiosity: Why?
> >>
> >> Aren=E2=80=99t there only two things we really need from the block_sta=
tus
> >> infrastructure?
> >>
> >> (1) Whether something is allocated in the given layer of the backing c=
hain,
> >>
> >> (2) Whether we know that a given range reads as zeroes.
> >>
> >> Do we really need anything else?
> >>
> >=20
> > qemu-img map?
>=20
> Which is a debugging tool.  So it doesn=E2=80=99t fall under =E2=80=9Crea=
lly=E2=80=9D in my
> book.  If removing everything but allocation+zero information would make
> the code a lot simpler, I think that would be worth it.
>=20
> > 1. We need to fix the bug somehow
> > 2. We need to fix comment about different block-status flags, as it rea=
lly
> > lacks information of what actually "DATA" means (together with *file).
> > And what finally means "allocated", can you define it precisely?
>=20
> As I wrote in my other mails, I think the problem is that it=E2=80=99s ju=
st
> unexpected that block_status automatically skips through for filters.
> It shouldn=E2=80=99t, that=E2=80=99s just black magic that the caller sho=
uld not rely on.
>=20
> (We see precisely here that it=E2=80=99s wrong, because the callers are n=
ot
> prepared for the allocation information returned to be associated with a
> different node than what they passed.)
>=20
> So my definition is just =E2=80=9CIf the node has a COW backing file and
> block_status returns =E2=80=98not allocated=E2=80=99, the data will be th=
ere.
> Otherwise, the data is in the current node.=E2=80=9D  Yes, that means that
> filters should appear as fully allocated.

You can do that, but then the callers need to learn to do the recursion
instead. After all, just copying everything if a filter is in the
subtree isn't the desired behaviour.

Kevin

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdUtEnAAoJEH8JsnLIjy/WD+IQAIojObeJy1OPK/6jCNc5/2mc
iAw8X9Dl0ePSThy55MdadYca2OSZI7pOnBgCrkj6uTaQC5yhD8GjhYdvX95rVkiv
BW2lH0krCNkjNzbKKh0MQ5eliYnorAwdgcZU/sNynFHOnBDzjDE4j2OES8KWhEMy
VHxRDI31H6sKxLf7OSbaT/vCowCaoIecWC7i+WcXZV2BXi9B0LSdiywCjU95Mkuc
sbh2n6sMs/FTXo+WkBTBPKJZfPYcbf5Ni8PZ02EGlSAnWh7BzuyguCisPS90ZwcJ
ny+X+URdm6oRVkqZJBKQhDC0WvK0fwtb6DdOiFsUskIpjUNIz5vYyhKyFF8s3Gur
u875g7wISIPI5I5uOl+GoQ+DwtsRZIY6QF1GX0SuYBdv+Na2w4tmpG83FUVkPD8c
nFoYT1Ff6cZ/XxNCGwyBNzMZw42X/LsB8XsXMWi2/OWGirIqK7bp6LZn38lvtTMM
noLpx1Km3auXV8Cyq8mWEOmG8WKOaMjYh5AR37BlrAPoOpgrLuPwIAkEvltarZA5
OjrANJ2hv2tK/vrUJU7ALGsIAgudANw+n7SMyGhPxwYciaTL/s4Zhu2YLcsj6pyl
5SiA7KrYZ5tgQOHTBmaoamTiiQdlpn8OCA+XKojSexGn9V6mpdRmhTAWnJ6coaxU
rBygwYO47TVABcmS3dGL
=ndAo
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--

