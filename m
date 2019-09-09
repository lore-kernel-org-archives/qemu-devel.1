Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8E2C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033BC2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033BC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7G6e-0006T4-3D
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7G5q-0005t4-7X
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7G5o-0002wh-Mt
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7G5g-0002qm-RQ; Mon, 09 Sep 2019 05:36:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D333C10C697A;
 Mon,  9 Sep 2019 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 980C910018FF;
 Mon,  9 Sep 2019 09:36:05 +0000 (UTC)
Date: Mon, 9 Sep 2019 11:36:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190909093604.GB13841@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 09 Sep 2019 09:36:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 04/42] block: Add child access functions
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
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.09.2019 um 09:56 hat Max Reitz geschrieben:
> On 04.09.19 18:16, Kevin Wolf wrote:
> > Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> >> There are BDS children that the general block layer code can access,
> >> namely bs->file and bs->backing.  Since the introduction of filters and
> >> external data files, their meaning is not quite clear.  bs->backing can
> >> be a COW source, or it can be an R/W-filtered child; bs->file can be an
> >> R/W-filtered child, it can be data and metadata storage, or it can be
> >> just metadata storage.
> >>
> >> This overloading really is not helpful.  This patch adds function that
> >> retrieve the correct child for each exact purpose.  Later patches in
> >> this series will make use of them.  Doing so will allow us to handle
> >> filter nodes and external data files in a meaningful way.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >=20
> > Each time I look at this patch, I'm confused by the function names.
> > Maybe I should just ask what the idea there was, or more specifically:
> > What does the "filtered" in "filtered child" really mean?
> >=20
> > Apparently any child of a filter node is "filtered" (which makes sense),
>=20
> It isn=E2=80=99t, filters can have non-filter children.  For example, bac=
kup-top
> could have the source as a filtered child and the target as a non-filter
> child.

Hm, okay, makes sense. I had a definition in mind that says that filter
nodes only have a single child node. Is it that a filter may have only a
single _filtered_ child node?

> > but also bs->backing of a qcow2 image, while bs->file of qcow2 isn't.
> > raw doesn't have any "filtered" child. What's the system behind this?
>=20
> =E2=80=9Cfiltered=E2=80=9D means: If the parent node returns data from th=
is child, it
> won=E2=80=99t modify it, neither its content nor its position.  COW and R=
/W
> filters differ in how they handle writes; R/W filters pass them through
> to the filtered child, COW filters copy them off to some other child
> node (and then the filtered child=E2=80=99s data will no longer be visibl=
e at
> that location).

But there is no reason why a node couldn't fulfill this condition for
more than one child node. bdrv_filtered_child() isn't well-defined then.
Technically, the description "Return any filtered child" is correct
because "any" can be interpreted as "an arbitrary", but obviously that
makes the function useless.

Specficially, according to your definition, qcow2 filters both the
backing file (COW filter) and the external data file (R/W filter).

> The main reason behind the common =E2=80=9Cfiltered=E2=80=9D name is for =
the generic
> functions that work on both COW and true filter (R/W filters) chains.
> We need such functionality sometimes.  I personally felt like the
> concept of true (R/W) filters and COW children was similar enough to
> share a common name base.

We generally call this concept a "backing chain".

> qcow2 has a COW child.  As such, it acts as a COW filter in the sense of
> the function names.
>=20
> raw has neither a COW child nor acts as an R/W filter.  As such, it has
> no filtered child.  My opinion on this hasn=E2=80=99t changed.
>=20
> (To reiterate, in practice I see no way anyone would ever use raw as an
> R/W filter.
> Either you use it without offset/size, in which case you simply use it
> in lieu of a format node, so you precisely don=E2=80=99t want it to act a=
s a
> filter when it comes to allocation information and so on (even though it
> can be classified a filter here).
> Or you use it as kind of a filter with offset/size, but then it no
> longer is a filter.

Agreed with offset, but with only size, it matches your definition of a
filter.

> Filters are defined by =E2=80=9CEvery filter must fulfill these condition=
s: ...=E2=80=9D
> =E2=80=93 not by =E2=80=9CEverything that fulfills these conditions is a =
filter=E2=80=9D.
> Marking a driver as a filter has consequences, and I don=E2=80=99t see wh=
y we
> would want those consequences for raw.)
>=20
> > It looks like bdrv_filtered_child() is the right function to iterate
> > along a backing file chain, but I just still fail to connect that and
> > the name of the function in a meaningful way.
>=20
> It=E2=80=98s the right function to iterate along a filter chain.  This in=
cludes
> COW backing children and R/W filtered children.

qcow2 doesn't fulfill the conditions for begin a filter driver. Two of
its possible children fulfill the conditions for being a filtered child.
You can pick either approach, talking about a "filter chain" just
doesn't make sense there. Either the chain is broken by a non-filter
driver like qcow2, or it must become a filter tree.

What we're really interested in is iterating the backing chain even
across filter nodes, so your implementation achieves the right result.
It just feels completely arbitrary, counterintuitive and confusing to
call this a (or actually "the") "filter chain" and to pretend that the
name tells anyone what it really is.

Kevin

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJddh0EAAoJEH8JsnLIjy/WyUsP/igVi1AwnsDIHYMELHCsCe9v
vcighcXCVzsznediSTtSIMFqT45z/dqs4Vu78KtcaDNUeSIi1UXo3faikt6q87ZF
9nK0EgcDozx+shnmJtr0MTyItBeEjKIFMurOUJnUHu1vZi//qQrx4AzzVMhS4NrF
inQ51jwt8K8emuiMeB9J5Dh3m507/l5xcwzLcfjqK59Gb1qQpWRif7Z0daeNHRlF
PZZY3K6+2/FksinqpdqWMyXlXMjzNTp+z8zD/L25MxlZGY+qH7HUtAsRiwemAll+
EdFX/KpDtNgkzIosUARHehStQOZ3Z6XGNPQ3f965M336jIjVhFwNUf95+MFlaffW
GOQddpuN099QARE83avajdvUnlAZwjRqhP3qyyOYctMhqKvVB3arr4gqN+dUMP1G
45BBbocBdEf1aqYHVgUe2skcDYQw/wrYrV/glDgQ/r6mMMvUpUm5gwk/1eWlyAVs
GOnPw3dELhhoGsm2nchJAx6zfuo48uj8qc51urSHxjIZaopQz8RZkNEnm5sFywP5
8xn2kvm2W8v0xDulFZ+mxoyH9W9Hq9B78NnxehqoeN6eJNSCraSNtq5zW/NBiXsr
Y1DRPAarPYqXhZ73gOOpSzyQOcJDfE5Ze/EfHc/WOkGqBIUgd+Eyz+QZPlnhdh4l
0L2aQSm9qru9w+Xcim40
=m2/8
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

