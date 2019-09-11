Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C9AC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79392082C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79392082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7zwi-000814-Tc
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 06:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7zuP-0006Ps-Jn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7zuO-00089N-9J
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:31:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7zuK-000880-04; Wed, 11 Sep 2019 06:31:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9AFB530A699C;
 Wed, 11 Sep 2019 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-182.ams2.redhat.com
 [10.36.116.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 696555DA5B;
 Wed, 11 Sep 2019 10:31:25 +0000 (UTC)
Date: Wed, 11 Sep 2019 12:31:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190911103123.GE4907@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
 <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
 <20190911082743.GC4907@localhost.localdomain>
 <aa9a6a3d-73ae-c7d4-78c9-a9c6c18fcfa4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <aa9a6a3d-73ae-c7d4-78c9-a9c6c18fcfa4@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 11 Sep 2019 10:31:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 22/42] block: Fix
 bdrv_get_allocated_file_size's fallback
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


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.09.2019 um 12:00 hat Max Reitz geschrieben:
> On 11.09.19 10:27, Kevin Wolf wrote:
> > Am 11.09.2019 um 09:37 hat Max Reitz geschrieben:
> >> On 11.09.19 08:55, Kevin Wolf wrote:
> >>> Well, by default the primary child, which should cover like 90% of the
> >>> drivers?
> >>
> >> Hm, yes.
> >>
> >> But I still think that the drivers that do not want to count every
> >> single non-COW child are the exception.
> >=20
> > They are, but drivers that want to count more than their primary node
> > are exceptions, too. And I think you're more likely to remember adding
> > the callback when you want to have a certain feature, not when you don't
> > want to have it.
> >=20
> > I really think we're likely to forget adding the callback where we need
> > to disable the feature.
>=20
> Well, I mean, we did forget adding it for qcow2.

I'm afraid I have to agree. So the conclusion is that we won't get it
right anyway?

> > I can see two options that should address both of our views:
> >=20
> > 1. Just don't have a fallback at all, make the callback mandatory and
> >    provide implementations in block.c that can be referred to in
> >    BlockDriver. Not specifying the callback causes an assertion failure,
> >    so we'd hopefully notice it quite early (assuming that we run either
> >    'qemu-img info' or 'query-block' on a configuration with the block
> >    driver, but I think that's faily safe to assume).
>=20
> Hm.  Seems a bit much, but if we can=E2=80=99t agree on what=E2=80=99s a =
good general
> implementation that works for everything, this is probably the only
> thing that would actually keep us from forgetting to add special cases.
>=20
> Though I actually don=E2=80=99t know.  I=E2=80=99d probably add two globa=
lly available
> helpers, one that returns the sum of everything but the backing node,
> and one that just returns the primary node.

Yes, I think this is the same as I meant by "provide implementations in
block.c".

> Now if I were to make qcow2 use the primary node helper function, would
> we have remembered changing it once we added a data file?
>=20
> Hmm.  Maybe not, but it should be OK to just make everything use the sum
> helper, except the drivers that want the primary node.  That should work
> for all cases.  (I think that whenever a format driver suddenly gains
> more child nodes, we probably will want to count them.  OTOH, everything
> that has nodes that shouldn=E2=80=99t be counted probably always wants to=
 use
> the primary node helper function from the start.)

The job filter nodes have only one child currently, which should be
counted. We'll add other children that shouldn't be counted only later.

But we already have an idea of what possible extensions look like, so we
can probably choose the right function from the start.

> > 2. Make the 90% solution a 100% solution: Allow drivers to have multiple
> >    storage children (for vmdk) and then have the fallback add up the
> >    primary child plus all storage children. This is what I suggested as
> >    the documented semantics in my initial reply to this patch (that you
> >    chose not to answer).
>=20
> I didn=E2=80=99t answer that because I didn=E2=80=99t disagree.
>=20
> >    Adding the size of storage children covers qcow2 and vmdk.
>=20
> That=E2=80=99s of course exactly what we=E2=80=99re trying to do, but the=
 question is,
> how do we figure out that storage children?  Make it a per-BdrvChild
> attribute?  That seems rather heavy-handed, because I think we=E2=80=99d =
need it
> only here.

Well, you added bdrv_storage_child(). I'd argue this interface is wrong
because it assumes that only one storage child exists. You just didn't
implement it for vmdk so that the problem didn't become apparent. It
would have to return a list rather than a single child. So fixing the
interface and then using it is what I was thinking.

Now that you mention a per-BdrvChild attribute, however, I start to
wonder if the distinction between COW children, filter children, storage
children, metadata children, etc. isn't really what BdrvChildRole was
supposed to represent?

Maybe we want to split off child_storage from child_file, though it's
not strictly necessary for this specific case because we want to treat
both metadata and storage nodes the same. But it could be useful for
other users of bdrv_storage_child(), if there are any.

> >    As the job filter won't declare the target or any other involved
> >    nodes their storage nodes (I hope), this will do the right thing for
> >    them, too.
> >=20
> >    For quorum and blkverify both ways could be justifiable. I think they
> >    probably shouldn't declare their children as storage nodes. They are
> >    more like filters that don't have a single filtered node. So some
> >    kind of almost-filters.
>=20
> I don=E2=80=99t think quorum is a filter, and blkverify can only be justi=
fied to
> be a filter because it quits qemu when there is a mismatch.
>=20
> The better example is replication, but that has a clear filtered child
> (the primary node).
>=20
>=20
> So all in all I think it=E2=80=99s best to make the callback mandatory an=
d add
> two global helper functions.  That=E2=80=99s simple enough and should pre=
vent
> us from making mistakes by forgetting to adjust something in the
> future.

Yes, that should work.

We should probably still figure out what the relationship between the
child access functions and child roles is, even if we don't need it for
this solution. But it feels like an important part of the design.

Kevin

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdeMz7AAoJEH8JsnLIjy/WrmMP/AvRWtq/24oSGCbZNqD5kw5a
pOM8UA+lst4cs7j1RtQ3WusuOe6/nvOcg0I3nlIZiLD09zgpmc0AT3l16BAkO4nW
k6G1vggiWUnapfIYJcyrjc7O3HU46eqxBTxdz3UNMWIJ0LabR0SUemxOii9zdtJO
IFYCbTaIWN539MXpTL4JxqEaE/bIxNR7ahj9kZb79ru80y/PmQdpuL6onHK8D+j0
ffH5HjqINHvLSgpsMJ3rTdG9PlfGL1mumGH4fWOs7fuHbVpZjPyRCd7oFKvOr5Fu
OXNRT9FTGZyNkk+hkSVB8gJRPvYpP6AvrbCNxiXirN4pZzzM2j9GvatjF2JnY5L/
oMGCNZsYaUNLO21C5S8MMBpCe4fQ2kiEoYEnunP4/JhaPBaWDLZ0U5l72vGe0p2b
HGN/rzL5LGD2bz+B6iLy911QDmrMPZqLAjdnNJzo8Wu8fpHPAc9Uxs4wCb5yvW0L
ICSh9MMSqxuSmwOUk0vudp6XXNsFYvX/8Vlz7QfwjG/FwDToymOtNTL0O+R/9GYC
SBwzWhVEVSkUE3h+m/Lehbev4hqy2qJDNbgXiVLIHSzj0dTEUhPuj/VjD1XeKrYR
iOKt0ZKrTsPI58N3UN2E1MO7bcslkeRpAJ+5ajnKPWjJpTIdEvf+f0WnLWczw9yL
Mapv+oY4iDAP6V+f7uO8
=MtUY
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

