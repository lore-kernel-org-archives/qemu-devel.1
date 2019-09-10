Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869B5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174F320863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174F320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fdb-0002EX-AC
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7fZ7-0007ji-R8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7fZ6-00089k-7a
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:48:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7fZ2-000875-Fn; Tue, 10 Sep 2019 08:48:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD8F9306731B;
 Tue, 10 Sep 2019 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-217.ams2.redhat.com
 [10.36.116.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A6445C21E;
 Tue, 10 Sep 2019 12:48:06 +0000 (UTC)
Date: Tue, 10 Sep 2019 14:48:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190910124805.GF4446@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
 <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
 <20190909161314.GJ17606@localhost.localdomain>
 <89984d52-881f-a1e4-c14a-2bf05fc789d0@redhat.com>
 <20190910104748.GC4446@localhost.localdomain>
 <00aa6729-5fa0-31e0-8af5-1a91ae034f28@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <00aa6729-5fa0-31e0-8af5-1a91ae034f28@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 10 Sep 2019 12:48:07 +0000 (UTC)
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


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.09.2019 um 13:36 hat Max Reitz geschrieben:
> On 10.09.19 12:47, Kevin Wolf wrote:
> > Am 10.09.2019 um 11:14 hat Max Reitz geschrieben:
> >> Maybe we should stop declaring Quorum a filter and then rename the
> >> bdrv_recurse_is_first_non_filter() to, I don=E2=80=99t know,
> >> bdrv_recurse_can_be_replaced_by_mirror()?
> >=20
> > Why not.
>=20
> It feels difficult to do in this series because this is a whole new can
> of worms.
>=20
> In patch 35, I actually replace the mirror use case by
> is_filtered_child().  So it looks to me as if that should not be done,
> because I should instead fix bdrv_recurse_is_first_non_filter() (and
> rename it), because quorum does allow replacing its children by mirror,
> even if it does not act as a filter for them.
>=20
> OTOH, there are other users of bdrv_is_first_non_filter().  Those are
> qmp_block_resize() and external_snapshot_prepare(), who throw an error
> if that returns false.
>=20
> I think that=E2=80=99s just wrong.  First of all, I don=E2=80=99t even kn=
ow why we have
> that restriction anymore (I can imagine why it used to make sense before
> the permission system).  qmp_block_resize() should always work as long
> as it can get BLK_PERM_RESIZE; and I don=E2=80=99t know why the parents o=
f some
> node would care if you take a snapshot of their child.

Hm, doesn't it make sense in a way for qmp_block_resize() at least? It
means that you can't resize just a filter, but you need to resize the
image that actually provides the data for the filter.

Of course, there is no reason for it to be the _first_ non-filter as
long as BLK_PERM_RESIZE is shared, but just some non-filter node.

Two more random observations:

* quorum uses bdrv_filter_default_perms(), which allows BLK_PERM_RESIZE.
  I think this is wrong and quorum should make sure that all children are
  always the same size because otherwise it can't tell what its own size
  is. (Or vote on size...? :-/) Probably not a problem in practice as
  long as we check bdrv_is_first_non_filter().

* child_file and child_backing don't implement .resize. So if you resize
  a non-top-level image, parents (in particular filters) don't get their
  size adjusted. This is probably a bug, too, but one that isn't
  prevented by bdrv_is_first_non_filter() and should be visible today.

> >>> Maybe the documentation of bdrv_filtered_child() needs to be rephrase=
d?
> >>>
> >>> Going back to qcow2, it's really not much different as it has multiple
> >>> (two) filtered children, too.
> >>
> >> Well, it doesn=E2=80=99t.  It isn=E2=80=99t an R/W filter.
> >=20
> > What do I have to look at to see whether something is an R/W filter or
> > not? qcow2 matches your criteria for an R/W filter.
>=20
> No.  Some qcow2 nodes match the criteria.  But not all, which makes the
> qcow2 driver not a filter driver.
>=20
> > You say that it's not useful, so it's not an R/W filter anyway. But
> > where in the code could I get this information?
>=20
> =E2=80=9CWhere in the code=E2=80=9D?  Do you want to add a comment to eve=
ry BlockDriver
> structure on why it does or doesn=E2=80=99t set .is_filter?

Never mind, I just didn't understand that .is_filter is the thing that
defines a R/W filter. In fact, I didn't really understand what
=2Eis_filter was supposed to mean at all because I was so confused. For
some reason I was sure it had to mean any kind of filter, but that
assumption just didn't match up with its use at all.

> >>>>> Specficially, according to your definition, qcow2 filters both the
> >>>>> backing file (COW filter) and the external data file (R/W filter).
> >>>>
> >>>> Not wrong.  But the same question as for raw arises: Is there any us=
e to
> >>>> declaring qcow2 an R/W filter driver just because it fits the defini=
tion?
> >>>
> >>> Wait, where is there even a place where this could be declared?
> >>>
> >>> The once thing I see that a driver even can declare is drv->is_filter,
> >>> which is about the whole driver and not about nodes. It is false for
> >>> qcow2.
> >>
> >> That=E2=80=99s correct.  But that=E2=80=99s not a fundamental problem,=
 of course, we
> >> could make it a per-BDS attribute if that made sense.
> >=20
> > I was thinking per-child, actually, because you declare one BdrvChild
> > filtered and another not filtered.
>=20
> Why don=E2=80=99t you say so from the start then?

Yes, I wrote "nodes", thought "child nodes" and should have said
"children" because edges are not nodes. My bad, sorry.

> (Sorry, but honestly about 30 % of this discussion to me feels like
> you=E2=80=99re playing games with me.  Please don=E2=80=99t take this the=
 wrong way, I
> mean it very neutrally.  It=E2=80=99s just that I feel like I=E2=80=99m e=
xplaining
> things to you that you very much know, but you just want me to say them.
>  And that feels unproductive and sometimes indeed frustrating.)

No, certainly not. If my mails seemed confusing or pointless, it just
shows how thoroughly confused I was.

> One thing is that this wouldn=E2=80=99t make the quorum case any easier b=
ecause
> it actually doesn=E2=80=99t know for which children it acts as a filter a=
nd for
> which it doesn=E2=80=99t.
>=20
> > But by now I think most of the confusion is really just a result of COW
> > being considered a filter in some respects (mainly just the names of the
> > child access functions), but not in others (like .is_filter).
>=20
> I don=E2=80=99t quite see how it=E2=80=99s =E2=80=9Cby now=E2=80=9D when =
in your first mail you already
> basically wrote that functionally, everything works (leaving out
> quorum), but that you=E2=80=99re confused (or claim to be confused, I hav=
e no
> idea what=E2=80=99s real and what=E2=80=99s pretended anymore) by the nam=
es.

Well, I saw that the special cases in the patches that I had reviewed so
far seemed to be converted correctly, but I just didn't understand the
whole concept behind it. It's possible to both understand that a
transformation is correct and to fail to grasp the concept behind it.

And your first answer only confused me more because you gave definitions
for R/W and COW filters that honestly ended up a bit misleading,
possibly as a result of your endeavour to make R/W filters and COW
sound like the same thing. (Which made me lose sight of basic facts like
that R/W filters must forward _every_ request without exception to their
filtered child even though COW doesn't.)

> We have come to two results, as far as I can see:
>=20
> First, naming COW backing nodes =E2=80=9CCOW filtered children=E2=80=9D c=
lashes with our
> existing use of =E2=80=9Dfilter=E2=80=9D.  There is no point in forcing t=
he =E2=80=9Dfilter=E2=80=9D
> label on everything.  We can just keep calling (R/W) filters filters and
> COW backing children COW children.  The names are succinct enough.
>=20
> In some cases, we don=E2=80=99t care whether something is a COW or filter=
ed
> child, in such a case a caller can be bothered to use the slightly
> longer bdrv_cow_or_filtered_child().

Aye.

> Second, most of the time we want a filter node to have a clear and
> unique path to go down.  This is the important property of filters: That
> you can skip them and go to the node that actually has the data.
>=20
> Quorum breaks this by having multiple children, and nobody knows which
> of them has the data we will see on the next read operation.
>=20
> All =E2=80=9Cfilters=E2=80=9D who could have multiple children would have=
 this problem.
>  Hence a filter must always have a single unique data child.  I think.

I agree, and this is the condition that I mentioned somewhere above, but
failed to actually find guaranteed somewhere. We should probably make
this explicit.

Of course, quorum and similar things intend all their children to
provide the same data, but the whole point of the driver is that this is
not always guaranteed, so they aren't actually filters.

Kevin

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdd5uFAAoJEH8JsnLIjy/Wt8oP/jbPV9Fp45/XhR/yhrY18oYj
+Wh1ttrDBiOeARb/KleW8g//jAciFJl/mQbw/xBUqXGjycVvoewxxNP4ykeC40fP
35/AuWDS/0DfWR6PBjA9gatDkrlNZkZdvHAk27bxKAEALdQ2uk9ciDIhO04qxyLO
aIuLYThk5Ly+Mny56iYf9Jwv/lO3JHMi5WVSUuYTKtCm7MZDyxBM2mcfLSrIM00g
6qpERGn+lmAFPfhFPwv2pVko+Tv5qkdj+eOSwdU12C194Pbj81twaueP+yomxtiH
m2mX7LAk0A3awzZG8HvIF2tT6sH4fdErnaEagRBs7HCcmQsfQULCZZK5H4ZUsL7Q
CfG+ews0+rUbD7DdmhcrUaFTHUkq+vy8p/+QJR6vWf7wie/uXg/cxZRKk+uvsu2K
9m7jc2OdLWYcRYjc67QFH1NqvalfvTzucBXJqm0rkqYgTS1EHG0Z/dCCmMRCa2aT
0w73B+QNiC6XFiY8ulpYRl7Gkdiuw05qlYwW3xITchbCv922+VG72RK4ASweCXFx
ryGCzHOeZMKVQK6nIEf9ZyzmdkbMoDDZhPSJBYMQoq9BuVgCAw1NPBnGRvquJuti
3LzuyLGcosPXlXAD415SxEcMusWzNPrM3P06oNJjueYgMRjJlvBxkwbmeFSVBPpc
yghHY3imLwvnfXgP4jt1
=xIJU
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--

