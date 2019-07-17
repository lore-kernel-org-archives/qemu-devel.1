Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F8C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE412077C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE412077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnf7q-0007VV-FF
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41699)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnf7e-00072i-0p
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnf7c-0000go-Oq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:17:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnf7Z-0000d0-TE; Wed, 17 Jul 2019 04:17:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1642F335C4;
 Wed, 17 Jul 2019 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-47.ams2.redhat.com
 [10.36.117.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34AA460C4C;
 Wed, 17 Jul 2019 08:17:04 +0000 (UTC)
Date: Wed, 17 Jul 2019 10:17:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190717081702.GA6471@localhost.localdomain>
References: <20190703172813.6868-1-mreitz@redhat.com>
 <20190703172813.6868-7-mreitz@redhat.com>
 <20190716170156.GJ7297@linux.fritz.box>
 <22745e99-6b6e-53d5-91b7-e1156782e55e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <22745e99-6b6e-53d5-91b7-e1156782e55e@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 17 Jul 2019 08:17:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/12] block: Deep-clear inherits_from
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.07.2019 um 09:47 hat Max Reitz geschrieben:
> On 16.07.19 19:01, Kevin Wolf wrote:
> > Am 03.07.2019 um 19:28 hat Max Reitz geschrieben:
> >> BDS.inherits_from does not always point to an immediate parent node.
> >> When launching a block job with a filter node, for example, the node
> >> directly below the filter will not point to the filter, but keep its o=
ld
> >> pointee (above the filter).
> >>
> >> If that pointee goes away while the job is still running, the node's
> >> inherits_from will not be updated and thus point to garbage.  To fix
> >> this, bdrv_unref_child() has to check not only the parent node's
> >> immediate children for nodes whose inherits_from needs to be cleared,
> >> but its whole subtree.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >=20
> > Isn't the real bug that we keep pointing to a node that isn't a parent
> > of the node any more? I think this will effectively disable option
> > inheritance in bdrv_reopen() as long as the filter node is present,
> > which is certainly not what we intended.
>=20
> Well, it breaks it while a block job is running.  I don=E2=80=99t know wh=
ether I
> would advise doing a reopen across a block job filter.  It=E2=80=99s a ca=
se of
> =E2=80=9CWhy wouldn=E2=80=99t it work?=E2=80=9D, but I=E2=80=99m sure the=
re=E2=80=99s something that doesn=E2=80=99t.
> (Like this here, for example, but it at least has the decency of just
> letting the reopen fail.)

Why would it let the reopen fail? Failing would be justifiable, but I
expect it just succeeds without updating the options of the child node.

> > The intuitive thing would be that after inserting a filter, the image
> > now inherits from the filter node, and when the filter is removed, it
> > inherits from the filter's bs->inherit_from if that becomes a parent of
> > the node. (Though I'm not necessarily saying that my intuition is to be
> > trusted here.)
>=20
> I tried that first, but I couldn=E2=80=99t get it to work.  I don=E2=80=
=99t remember
> why, though.  I suppose my problem was that removing the filter node
> make inherits_from NULL.  I guess I stopped at that point and went this
> route instead.
>=20
> I suppose we could add a flag to the BDS that says whether an heir
> node=E2=80=99s inherits_from should be cleared or set to the bequeather=
=E2=80=99s
> inherits_from, like so:
>=20
>     if (parent->inherit_inherits_from) {
>         child->bs->inherits_from =3D parent->inherits_from;
>     } else {
>         child->bs->inherits_from =3D NULL;
>     }
>=20
> And then, if you insert a node between a child and its inherits_from
> parent, that node copies inherits_from from the child and gets its
> inherit_inherits_from set to true.
>=20
> The problem I see is that it doesn=E2=80=99t always appear clear to me th=
at this
> intermediate node should actually copy its inherits_from from the child.
>=20
> So the same question applies here, too, I guess; should the filter node
> even inherit its options from the parent?

An explicitly created filter node that is inserted with blockdev-reopen
certainly doesn't inherit from its parent. An automatically created
filter node where you didn't have control of its options - hm... good
question.

If we want to keep it simple, maybe it would be defensible if we just
break the inheritance relationship as soon as the parent is detached
(i.e. when inserting the filter). At least that would be more consistent
than silently disabling option inheritance while a filter is present and
then suddenly reenabling it when the filter goes away.


The other option would be making it actually work, i.e. the child node
keeps inheriting from its original parent node. This would not only
require modifications to bdrv_reopen(), but also to the data structures
so that the parent has a list of nodes that inherit from it: Nobody can
even guarantee that the child node always stays in the subtree of the
original parent.

This is in fact a reason why this patch isn't only ugly, but actually
wrong - you may still miss some inherits_from references.

Kevin

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdLtl+AAoJEH8JsnLIjy/WV5cP/3p08QmVpLA0IALNibiCYHy9
4xxKr04Q9LD44qnjgnH5MisWGhsQFqEfvpQ1Mk8q1Am33hQ4eWb93XaDnitahczk
vGM22TN0EE/giw3uCAv3398+eRnLtosMCTO4IyAEWaa04lOp+IVgmhbum48lVoFB
nSkX+9aQKtJuDJcWECdcRC/SmHCDvE2152Z2usfE+xXbadVKX7V38pAF47ek/EU9
kYyMHiIovgd1JpgDweIxTangiCE6CRpa2gf71/uV9DZ88rKfX3tH7D/BNr1/h2N6
UIvrBXudjhL7VV5U5S1ECd3055ClXJ3sKcQ9EiruEQS4tm3znc8oRLUOPSNglTR/
7qbOfSmiLEAuWIWZjUBhBF1ybceqY7tqsIYJZo8ilVxkQTa4hV998mh5QyMBovzc
ZqDje3PScC41X1ybhA6mzKtkZFolJsbGY4QH5HuIPSf60y4dvdt8MUVY+w/Jl8Jf
SkxEpEHIZL4Q7nxiPLK7mDG0UctfX/L7glvIYZB92XEsrXIbt5c5zI/gmU/OqDct
CGKhB1ukDD9LbCtHfWUM5vCcnrYqumKGi1z9PhkgInK5g5f3uiOVhrosuZJfbcRM
J9vnyOop0vBjyGpePcVamzeYWvRp8Jf6OVTUDqCPnaAXMcqxcVR2yz2QxpWgY64p
HxKIiZYAcF/nYBVyH++u
=plYQ
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

