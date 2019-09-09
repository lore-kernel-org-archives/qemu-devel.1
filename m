Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F725C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535A720640
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535A720640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7MJV-0008C1-HG
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7MIE-0006ms-Fv
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7MIC-0003UU-Hr
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:13:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7MI3-0003Le-Ve; Mon, 09 Sep 2019 12:13:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 961B8A37672;
 Mon,  9 Sep 2019 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 343155C1D8;
 Mon,  9 Sep 2019 16:13:16 +0000 (UTC)
Date: Mon, 9 Sep 2019 18:13:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190909161314.GJ17606@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
 <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 09 Sep 2019 16:13:17 +0000 (UTC)
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


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.09.2019 um 16:04 hat Max Reitz geschrieben:
> On 09.09.19 11:36, Kevin Wolf wrote:
> > Am 09.09.2019 um 09:56 hat Max Reitz geschrieben:
> >> On 04.09.19 18:16, Kevin Wolf wrote:
> >>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> >>>> There are BDS children that the general block layer code can access,
> >>>> namely bs->file and bs->backing.  Since the introduction of filters =
and
> >>>> external data files, their meaning is not quite clear.  bs->backing =
can
> >>>> be a COW source, or it can be an R/W-filtered child; bs->file can be=
 an
> >>>> R/W-filtered child, it can be data and metadata storage, or it can be
> >>>> just metadata storage.
> >>>>
> >>>> This overloading really is not helpful.  This patch adds function th=
at
> >>>> retrieve the correct child for each exact purpose.  Later patches in
> >>>> this series will make use of them.  Doing so will allow us to handle
> >>>> filter nodes and external data files in a meaningful way.
> >>>>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>
> >>> Each time I look at this patch, I'm confused by the function names.
> >>> Maybe I should just ask what the idea there was, or more specifically:
> >>> What does the "filtered" in "filtered child" really mean?
> >>>
> >>> Apparently any child of a filter node is "filtered" (which makes sens=
e),
> >>
> >> It isn=E2=80=99t, filters can have non-filter children.  For example, =
backup-top
> >> could have the source as a filtered child and the target as a non-filt=
er
> >> child.
> >=20
> > Hm, okay, makes sense. I had a definition in mind that says that filter
> > nodes only have a single child node. Is it that a filter may have only a
> > single _filtered_ child node?
>=20
> Well, there=E2=80=99s Quorum...

Ah, nice, quorum sets is_filter =3D true even though it neither fulfulls
the conditions for it before this series, nor the changed conditions
after this series.

So either quorum lies and isn't actually a filter driver, or our
definition in the documentation of is_filter is wrong.

> >>> but also bs->backing of a qcow2 image, while bs->file of qcow2 isn't.
> >>> raw doesn't have any "filtered" child. What's the system behind this?
> >>
> >> =E2=80=9Cfiltered=E2=80=9D means: If the parent node returns data from=
 this child, it
> >> won=E2=80=99t modify it, neither its content nor its position.  COW an=
d R/W
> >> filters differ in how they handle writes; R/W filters pass them through
> >> to the filtered child, COW filters copy them off to some other child
> >> node (and then the filtered child=E2=80=99s data will no longer be vis=
ible at
> >> that location).
> >=20
> > But there is no reason why a node couldn't fulfill this condition for
> > more than one child node. bdrv_filtered_child() isn't well-defined then.
> > Technically, the description "Return any filtered child" is correct
> > because "any" can be interpreted as "an arbitrary", but obviously that
> > makes the function useless.
>=20
> Which is why it currently returns NULL for Quorum.

Which is about the only possible choice that breaks the contract...

 * Return any filtered child, independently of how it reacts to write
 * accesses and whether data is copied onto this BDS through COR.

Maybe the documentation of bdrv_filtered_child() needs to be rephrased?

Going back to qcow2, it's really not much different as it has multiple
(two) filtered children, too. So if quorum returns NULL to mean "no
unambiguous result", why does it return bs->backing instead of NULL for
a qcow2 node?

(Yes, I know, because it's useful. But I'm trying to get some basic
consistency into these interfaces.)

> > Specficially, according to your definition, qcow2 filters both the
> > backing file (COW filter) and the external data file (R/W filter).
>=20
> Not wrong.  But the same question as for raw arises: Is there any use to
> declaring qcow2 an R/W filter driver just because it fits the definition?

Wait, where is there even a place where this could be declared?

The once thing I see that a driver even can declare is drv->is_filter,
which is about the whole driver and not about nodes. It is false for
qcow2.

Then you made some criteria above that tell us whether a specific child
of a node is a filtered child or not. As it happens, qcow2 (which is not
a filter driver) can have two children that match the criteria for being
filtered children.

I already think this is a bit inconsistent, because why should a driver
that declares itself a non-filter be considered to filter children?
Okay, you say a broader definition of a filtered child is useful because
you can then include all BdrvChild links in a backing/filter chain. Fair
enough, it's not intuitive, but use a broader definition then.

But the point where you say that even though two of the children
are filtered children under your broader definition, for the purpose of
the API only one of them should be considered because the other one
isn't that useful, that's really one inconsistency too much for me. You
can't use a broad definition and then arbitrarily restrict the
definition again so that it matches the special case you're currently
interested in.

Either use a narrow definition, or use a broad one. But use only one and
use it consistently.

> >> The main reason behind the common =E2=80=9Cfiltered=E2=80=9D name is f=
or the generic
> >> functions that work on both COW and true filter (R/W filters) chains.
> >> We need such functionality sometimes.  I personally felt like the
> >> concept of true (R/W) filters and COW children was similar enough to
> >> share a common name base.
> >=20
> > We generally call this concept a "backing chain".
>=20
> I suppose that=E2=80=99s an exclusive =E2=80=9Cwe=E2=80=9D?  Because I us=
e =E2=80=9Dbacking chain=E2=80=9D to
> refer to COW chains exclusively.
>=20
> Such a chain may or may not include filters, but they are not really
> load-bearing nodes of the chain.  As such, I generally want to skip them
> when looking at a backing chain (hence e.g. bdrv_backing_chain_next()).
>=20
> From what I can tell nobody has ever formalized any terms regarding COW
> backing chains or R/W filter chains.  This series is an attempt.

Well, as you can see, this attempt feels confusing to me.

I agree with your naming of bdrv_backing_chain_next(), it's clear enough
what path it will follow down the graph. I just disagree that "filter
chain" is a good term for something that prefers backing file links when
it has a choice.

> >> qcow2 has a COW child.  As such, it acts as a COW filter in the sense =
of
> >> the function names.
> >>
> >> raw has neither a COW child nor acts as an R/W filter.  As such, it has
> >> no filtered child.  My opinion on this hasn=E2=80=99t changed.
> >>
> >> (To reiterate, in practice I see no way anyone would ever use raw as an
> >> R/W filter.
> >> Either you use it without offset/size, in which case you simply use it
> >> in lieu of a format node, so you precisely don=E2=80=99t want it to ac=
t as a
> >> filter when it comes to allocation information and so on (even though =
it
> >> can be classified a filter here).
> >> Or you use it as kind of a filter with offset/size, but then it no
> >> longer is a filter.
> >=20
> > Agreed with offset, but with only size, it matches your definition of a
> > filter.
>=20
> So?
>=20
> Should we treat it as a filter when @offset is 0 but otherwise not?
> That totally wouldn=E2=80=99t be confusing to users.

No, I'm just applying your definitions to see if the contradictions
between them and your explanations are of any importance. *shrug*

> >> Filters are defined by =E2=80=9CEvery filter must fulfill these condit=
ions: ...=E2=80=9D
> >> =E2=80=93 not by =E2=80=9CEverything that fulfills these conditions is=
 a filter=E2=80=9D.
> >> Marking a driver as a filter has consequences, and I don=E2=80=99t see=
 why we
> >> would want those consequences for raw.)
> >>
> >>> It looks like bdrv_filtered_child() is the right function to iterate
> >>> along a backing file chain, but I just still fail to connect that and
> >>> the name of the function in a meaningful way.
> >>
> >> It=E2=80=98s the right function to iterate along a filter chain.  This=
 includes
> >> COW backing children and R/W filtered children.
> >=20
> > qcow2 doesn't fulfill the conditions for begin a filter driver. Two of
> > its possible children fulfill the conditions for being a filtered child.
> > You can pick either approach, talking about a "filter chain" just
> > doesn't make sense there. Either the chain is broken by a non-filter
> > driver like qcow2, or it must become a filter tree.
>=20
> I have no idea what your point is.  There is no point in making it a
> filter tree at this point, just as we never had a backing tree.
>=20
> And the good example is Quorum.  qcow2 is a bad example because there is
> no benefit in marking it an R/W filter for its external data file,
> exactly like is the case for raw.

My point is not about changing the logic in the code, but about using
names that actually describe accurately what the logic does.

And as I said above, neither is "not useful" a convincing argument for
ignoring filtered children (as I think we're trying to build something
rather generic, not something that works only for what we consider
useful today) nor do I see how qcow2 could be marked or not marked an
R/W filter (as mentioned above).

> > What we're really interested in is iterating the backing chain even
> > across filter nodes, so your implementation achieves the right result.
> > It just feels completely arbitrary, counterintuitive and confusing to
> > call this a (or actually "the") "filter chain" and to pretend that the
> > name tells anyone what it really is.
>=20
> So exactly the same as =E2=80=9Cbs->backing=E2=80=9D or =E2=80=9Cbacking =
chain=E2=80=9D for me.
>=20
> You disagreeing with me on these terms to me shows that there is a need
> to formalize.  This is precisely what I want to do in this series.
>=20
> The fact that we don=E2=80=99t use the term =E2=80=9Cfilter chain=E2=80=
=9D so far is the reason
> why I introduce it.  Because it comes as a clean slate.  =E2=80=9Cbacking=
 chain=E2=80=9D
> already means something to me, and it means something different.

Well, if "backing chain" is too narrow, "filter chain" is both too
unspecific and inconsistent with the various definitions of "filter" and
"filtered" we're using, and we can't think of anything more concise, we
might have to use names that just mention both.

bdrv_cow_child() // don't call COW a filter, because .is_filter =3D false
bdrv_filter_child() // your R/W filter, only for .is_filter =3D true nodes
bdrv_filter_or_cow_child()

Or something like that. This would bring some more consistency into the
way we use the words filter/filtered at least.

Kevin

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJddnoaAAoJEH8JsnLIjy/WgBYP/js8ACYBWWij/REdhreYvAN2
9AaqNct4GGbH4+WTCcTT5Or83JhXud47whLa+BxXP2rtIFp7bppd5I5LEmmbSzm+
y38B9Fv6Ou0ypbbfPtos+FJdutHZFBrXYmahwg0DwcPzNdIMif9v9zbDOfAhHVTv
PizliEBIGRxsQ2ON44x4wPYz/H/yAZNcST9ryxhG1GMv3ijQhpwvbdGF2t0Y12Nh
1oPsfW2vStepNfRK/XodW8nWon9/ug1UGDTPrfuf8nnlLAsQwFUXIrnTlrxnFtui
ehrh/XZRLfBhB5hF5B5YWUeaMyUEjkXxlzaQ2RbVygW8kRXK0HVGrW7AES1D4t+M
kF+GGEms5fiWswmEKB9/VBKRbA733q7bwoiDvpmD9rtLZOSDEVMdZ9BDAwt9FpDN
1tPdKcC+GzZxzrnIAMlWxM8D0krv1Yt9nkUyBI7tLSoNkhJcsk22XZURWhVMrubS
Q5aeCGKxiEnrNU8DWXU+hWCwXao0vt+OkSBomZZX5q4Wi695kYSmeWdpraGNh1pD
AgoSziyC920xbVsVLdtolOvUn+a090MLVviKhsIEIDpX5ss3YvJP/bVBQks7lcjp
L8zRwIiMcYqn/PBMqCdOWAqxiUev9/WIUM9tvtoA90aFKq9VDtxRcL3Keg+ZNYV8
y+myXjMA4SEuS/l6SdAQ
=mFk+
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--

