Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF75DC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 14:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB9020644
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 14:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB9020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3LhY-0007Tz-3o
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 10:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1i3LfZ-0006E9-Cz
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 10:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1i3LfX-0004lM-7r
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 10:45:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1i3LfU-0004hl-Ls; Thu, 29 Aug 2019 10:44:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0A9E875225;
 Thu, 29 Aug 2019 14:44:55 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96BA5600C1;
 Thu, 29 Aug 2019 14:44:48 +0000 (UTC)
Date: Thu, 29 Aug 2019 16:44:46 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190829144446.GL13714@angien.pipo.sk>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <de4667c2-7fd7-932d-6ce3-9844f284a0b4@virtuozzo.com>
 <d2bf50f1-e441-4cdb-291f-119a3ed93f51@redhat.com>
 <ba0e7e98-d02f-3514-b435-71923a483c6e@virtuozzo.com>
 <5b8dc9fa-6778-add9-01ae-7259d6bf633c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tDYGg60iReQ7u8wj"
Content-Disposition: inline
In-Reply-To: <5b8dc9fa-6778-add9-01ae-7259d6bf633c@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 29 Aug 2019 14:44:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tDYGg60iReQ7u8wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 13:48:10 -0400, John Snow wrote:
> (Peter: search for "pkrempa" down below.)
>=20
> On 8/28/19 5:20 AM, Vladimir Sementsov-Ogievskiy wrote:

[....]


> So that's a bit of a change, but only visually. The "reality" is still
> the same, we just report it more "accurately." libvirt MIGHT need a
> heads up here. I'm looping pkrempa back in for comment.
>=20
> <pkrempa>
> Would libvirt be negatively impacted by the revelation of formerly
> internal ("implicit") nodes created by mirror and commit via query block
> commands? At the moment, QEMU hides them from you if you do not name them.

Currently we would not be able to handle that properly at least
definitely in the pre-blockdev case. In blockdev case I must make sure
that it will work.

The thing is that I didn't really want to touch the pre-blockdev case
code any more, but if you decide that we should do it I'm willing to
investigate this case also for the old commands.

> </pkrempa>
>=20
> > 3. bdrv_refresh_filename, bdrv_reopen_parse_backing, bdrv_drop_intermed=
iate:
> >    I think it's not a problem, just drop special case for implicit fitl=
ers
> >
>=20
> I'm much less certain about what the impact of this would be and would
> need to audit it (and don't have the time to, personally.)
>=20
> Do you have a POC or RFC patch that demonstrates dropping these special
> cases? It might be nice to see as proof that it's safe to deprecate.
>=20
> > So, seems the only real change is query-block and query-blockstats outp=
ut when mirror or commit is started
> > without specifying filter-node-name (filter would be on top)
> >=20
> > So, how should we deprecate this, or can we just change it?
> >=20
>=20
> I'm not sure if it's worth it yet, what does dropping the implicit field
> buy us? Conceptually I understand that it's simpler without the notion
> of implicit fields, but I imagine there's some cleanup in particular
> that motivated this.
>=20
> I'd say to just change the behavior, we should:
>=20
> - Give a standard three-release warning that the behavior will change in
> an incompatible way
> - Demonstrate with an RFC patch that special cases around ->implicit in
> block.c can be removed and do not make the code more complex,
> - Get blessings from Peter Krempa.
>=20
> As always: Libvirt is not the end-all be-all of QEMU management, but if
> libvirt is capable of working around design changes then I believe any
> project out there today also could, so it's a good litmus test.

For libvirt we really care more whether a node is format/protocol
related or not rather than whether it's implicit or not.

In this case we could filter it by the known protocol and format driver
types and filter out the rest in cases when we e.g. detect the node
names for the pre-blockdev era cases.

(Note that even with new qemu, if an SD card is used blockdev will be
disabled).


--tDYGg60iReQ7u8wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl1n5NsACgkQHGwCByjY
1GoCKA//QDNBN/X1cCTysSKkx8IbCKjgrK0vIaiJM1uWCZOjEZPLb0a50w0V3hsr
PzcaQz5cgM3Oq4Zpgbhz9Dv77G3Q5JRSG/CI3meRlYwYMIe+6/eq7JeNbgyisyY9
RKdNYRW//1Vw3Ur8pZZD8IfZLuUxG0Cc7DEvfCHK0dwBTjvaTgYspIqvBQwiMhoj
huLYr+0vHhEIuP9dMlw5Gz7xOvgbWKaqgpVEMyB8m2Q4Q0MVhlby1/im/esZonFo
w0Z1MBPsCvyMEY2HY/1UXF7e/JpTpSl1wrJbf1PxPMbwmarEhsT+9kBR3Fi9HSTh
Sb4FXqE94KOFwTjfbMFkk+BzA/G146RGspQGif5ovCneW2aEXTtFIeyNPOZvYZWN
S9/O2lv9zR27Y3yhBhPeczUbECbizRyoZVB4Umza7SRW54FI/VlXt3U7gd1+vo2S
YPBVKLkJ1puSpa/UuNDcGrXYum3DDlVf2AUHKFEarrBkzMmLgzIw+TkwKugnTYSH
hzM4wBOREkrLjfvF+DpoUuIKCu7Ud/HzbuPVIXtdl09vWl7ap2Vi9qQeWqZsmxZV
BX5PLd5ikL07Ow5vHLrLlHrgbRjUZCwQsVkuc3F/wWv2KJ6OmZL3vUZIl12PlfzT
KbzbMFanc53imqUDIUeVesOd+XLEYX1BrLrW8EH4YwKrc6NODpI=
=6upw
-----END PGP SIGNATURE-----

--tDYGg60iReQ7u8wj--

