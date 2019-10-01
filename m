Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B233EC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0BE21783
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0BE21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLSm-0000DT-Bs
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iFKlt-0004Pr-BH
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iFKlr-00020j-IP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:13:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iFKll-0001wI-HO; Tue, 01 Oct 2019 12:12:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6FC8018CB8EC;
 Tue,  1 Oct 2019 16:12:55 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D09E65C1D4;
 Tue,  1 Oct 2019 16:12:51 +0000 (UTC)
Date: Tue, 1 Oct 2019 18:12:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191001161250.GF4688@linux.fritz.box>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <6dd4e735-47e7-45d1-98e9-2131746d470c@redhat.com>
 <dfc26b72-4795-09f8-9c50-07d4eabd971a@virtuozzo.com>
 <ef32215d-35e2-14dd-1b43-26f09a88f2dc@redhat.com>
 <20191001150950.GD4688@linux.fritz.box>
 <d32d21c0-6f18-39ba-6da3-060c865f701a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <d32d21c0-6f18-39ba-6da3-060c865f701a@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 01 Oct 2019 16:12:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.10.2019 um 17:27 hat Max Reitz geschrieben:
> On 01.10.19 17:09, Kevin Wolf wrote:
> > Am 01.10.2019 um 16:34 hat Max Reitz geschrieben:
> >> On 01.10.19 16:27, Vladimir Sementsov-Ogievskiy wrote:
> >>> 01.10.2019 17:13, Max Reitz wrote:
> >>>> On 01.10.19 16:00, Vladimir Sementsov-Ogievskiy wrote:
> >>>>> 01.10.2019 3:09, John Snow wrote:
> >>>>>> Hi folks, I identified a problem with the migration code that Red =
Hat QE
> >>>>>> found and thought you'd like to see it:
> >>>>>>
> >>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1652424#c20
> >>>>>>
> >>>>>> Very, very briefly: drive-mirror inserts a filter node that change=
s what
> >>>>>> bdrv_get_device_or_node_name() returns, which causes a migration p=
roblem.
> >>>>>>
> >>>>>>
> >>>>>> Ignorant question #1: Can we multi-parent the filter node and
> >>>>>> source-node? It looks like at the moment both consider their only =
parent
> >>>>>> to be the block-job and don't have a link back to their parents ot=
herwise.
> >>>>>>
> >>>>>>
> >>>>>> Otherwise: I have a lot of cloudy ideas on how to solve this, but
> >>>>>> ultimately what we want is to be able to find the "addressable" na=
me for
> >>>>>> the node the bitmap is attached to, which would be the name of the=
 first
> >>>>>> ancestor node that isn't a filter. (OR, the name of the block-back=
end
> >>>>>> above that node.)
> >>>>>
> >>>>> Not the name of ancestor node, it will break mapping: it must be na=
me of the
> >>>>> node itself or name of parent (may be through several filters) bloc=
k-backend
> >>>>>
> >>>>>>
> >>>>>> A simple way to do this might be a "child_unfiltered" BdrvChild ro=
le
> >>>>>> that simply bypasses the filter that was inserted and serves no re=
al
> >>>>>> purpose other than to allow the child to have a parent link and fi=
nd who
> >>>>>> it's """real""" parent is.
> >>>>>>
> >>>>>> Because of flushing, reopen, sync, drain &c &c &c I'm not sure how
> >>>>>> feasible this quick idea might be, though.
> >>>>>>
> >>>>>>
> >>>>>> - Corollary fix #1: call error_setg if the bitmap node name that's=
 about
> >>>>>> to go over the wire is an autogenerated node: this is never correc=
t!
> >>>>>>
> >>>>>> (Why not? because the target is incapable of matching the node-name
> >>>>>> because they are randomly generated AND you cannot specify node-na=
mes
> >>>>>> with # prefixes as they are especially reserved!
> >>>>>>
> >>>>>> (This raises a related problem: if you explicitly add bitmaps to n=
odes
> >>>>>> with autogenerated names, you will be unable to migrate them.))
> >>>>>>
> >>>>>> --js
> >>>>>>
> >>>>>
> >>>>> What about the following:
> >>>>>
> >>>>> diff --git a/block.c b/block.c
> >>>>> index 5944124845..6739c19be9 100644
> >>>>> --- a/block.c
> >>>>> +++ b/block.c
> >>>>> @@ -1009,8 +1009,20 @@ static void bdrv_inherited_options(int *chil=
d_flags, QDict *child_options,
> >>>>>        *child_flags =3D flags;
> >>>>>    }
> >>>>>
> >>>>> +static const char *bdrv_child_get_name(BdrvChild *child)
> >>>>> +{
> >>>>> +    BlockDriverState *parent =3D child->opaque;
> >>>>> +
> >>>>> +    if (parent->drv && parent->drv->is_filter) {
> >>>>> +        return bdrv_get_parent_name(parent);
> >>>>> +    }
> >>>>> +
> >>>>> +    return NULL;
> >>>>> +}
> >>>>> +
> >>>>
> >>>> Why would we skip filters explicitly added by the user?
> >>>>
> >>>
> >>> Why not? Otherwise migration of bitmaps will not work: we may have di=
fferent set
> >>> of filters on source and destination, and we still should map nodes w=
ith bitmaps
> >>> automatically.
> >>
> >> Why would we have a different set of explicitly added filters on source
> >> and destination and allow them to be automatically changed during
> >> migration?  Shouldn=E2=80=99t users only change them pre or post migra=
tion?
> >=20
> > We never made a requirement that the backend must be the same on the
> > source and the destination. Basically, migration copies the state of
> > frontends and the user is responsible for having these frontends created
> > and connected to the right backends on the destination.
> >=20
> > Using different paths on the destination is a very obvious requirement
> > for block devices. It's less obvious for the graph structure, but I
> > don't see a reason why it couldn't change on migration. Say we were
> > using local storage on the source, but now we did storage migration to
> > some network storage, access to which should be throttled.
>=20
> I don=E2=80=99t quite see why we couldn=E2=80=99t add such filters before=
 or after
> migration.

Possibly. But why would we when the source doesn't need the filter? We
don't change the image path before migration either.

I think the tricky part is coming up with rules and "keep the frontend
the same, the backend can change arbitrarily" is a very easy rule.

> And it was my impression that bitmap migration was a problem now
> precisely because it is bound to the graph structure.

So apparently I wasn't completely wrong when I preferred just writing
bitmaps back to the image instead of transferring them in the migration
stream...

It's not really bound to the graph structure per se, but to node names
and for non-anonymous BlockBackends to the link between the BB and its
root node. The latter is part of the graph structure, but only a very
small part, and it exists only for legacy (non-blockdev) configurations.

> But anyway.  I=E2=80=99ll gladly remove myself from this discussion becau=
se I
> don=E2=80=99t know much about migration and actually I=E2=80=99d prefer t=
o keep it that
> way.  (Sorry.)

Good idea, let's have the migration maintainers handle this.

Kevin

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdk3sCAAoJEH8JsnLIjy/WRYoQAJZ4t6RmY0qnKgINSXvXWttN
Jumcryy+yKXMs+tFJBQNGymlStjIpHixfh01rqB0pxFR7kfHi1B790Xy0lsMmpb1
sLfG89DkE1AaxNh7A48hifbA/RmBaYahymITXiNog3B1g2nN+HDe6E7mymMVNIH7
ygH71JI8Br9RbHWwSbxv3nimHnewDMSLmEJxW03HYV9957u8Eui4cig4+LbCsys6
Inz2S+uM1JKs5EE7+VPiE0wCAw33ygaJ6bdJ8NR8avcNa4YTQj0CBNhDhHL/Jg5q
iUpFOIQP9AsXUGQCcWOYyE3+bhnxI40oL7XzLe/A+whDVOwuG+QzkLxzQcNwLqDC
j47kZGtac90uIbE0uNek07WCVNZXMhtdTdO65VU307Eyt2P3gonwcgFe+BE3AWI7
Xlj+xYaxbx6bg/O+gq+N3+DUKdEFg+DbThdy7sLkKX33rQ9e8iKWQb02x+8KZU74
jfmVokYm17azrxHzb9zJgz1e4DFsfA3uMjKs3bun4K3iy6uA0f5vR+PSUMB8iCxv
8EnhI7c+vkjAgPa8hHwNwu9CvBbQVKGfAHNHUmifaXhJH8ShZ8Xm7rwt1TDjxKE/
OMbM1sK/T3rw0YaSoE1UCotX1B22ngurMy4KYGKcEYdySaEHYIyPav6ikx7SFS0A
fd/cwyFXwrMaCaCIHKD8
=Y1+z
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--

