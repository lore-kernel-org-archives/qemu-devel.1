Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC65C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6F2206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6F2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFJo6-0001pw-A8
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:11:18 -0400
Received: from [2001:470:142:3::10] (port=43878 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iFJmu-0000UU-17
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iFJmq-0003rY-Nj
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:10:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iFJmn-0003mX-MD; Tue, 01 Oct 2019 11:09:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27AD318C4279;
 Tue,  1 Oct 2019 15:09:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 398EA60BE0;
 Tue,  1 Oct 2019 15:09:52 +0000 (UTC)
Date: Tue, 1 Oct 2019 17:09:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191001150950.GD4688@linux.fritz.box>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <6dd4e735-47e7-45d1-98e9-2131746d470c@redhat.com>
 <dfc26b72-4795-09f8-9c50-07d4eabd971a@virtuozzo.com>
 <ef32215d-35e2-14dd-1b43-26f09a88f2dc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <ef32215d-35e2-14dd-1b43-26f09a88f2dc@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 01 Oct 2019 15:09:56 +0000 (UTC)
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


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.10.2019 um 16:34 hat Max Reitz geschrieben:
> On 01.10.19 16:27, Vladimir Sementsov-Ogievskiy wrote:
> > 01.10.2019 17:13, Max Reitz wrote:
> >> On 01.10.19 16:00, Vladimir Sementsov-Ogievskiy wrote:
> >>> 01.10.2019 3:09, John Snow wrote:
> >>>> Hi folks, I identified a problem with the migration code that Red Ha=
t QE
> >>>> found and thought you'd like to see it:
> >>>>
> >>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1652424#c20
> >>>>
> >>>> Very, very briefly: drive-mirror inserts a filter node that changes =
what
> >>>> bdrv_get_device_or_node_name() returns, which causes a migration pro=
blem.
> >>>>
> >>>>
> >>>> Ignorant question #1: Can we multi-parent the filter node and
> >>>> source-node? It looks like at the moment both consider their only pa=
rent
> >>>> to be the block-job and don't have a link back to their parents othe=
rwise.
> >>>>
> >>>>
> >>>> Otherwise: I have a lot of cloudy ideas on how to solve this, but
> >>>> ultimately what we want is to be able to find the "addressable" name=
 for
> >>>> the node the bitmap is attached to, which would be the name of the f=
irst
> >>>> ancestor node that isn't a filter. (OR, the name of the block-backend
> >>>> above that node.)
> >>>
> >>> Not the name of ancestor node, it will break mapping: it must be name=
 of the
> >>> node itself or name of parent (may be through several filters) block-=
backend
> >>>
> >>>>
> >>>> A simple way to do this might be a "child_unfiltered" BdrvChild role
> >>>> that simply bypasses the filter that was inserted and serves no real
> >>>> purpose other than to allow the child to have a parent link and find=
 who
> >>>> it's """real""" parent is.
> >>>>
> >>>> Because of flushing, reopen, sync, drain &c &c &c I'm not sure how
> >>>> feasible this quick idea might be, though.
> >>>>
> >>>>
> >>>> - Corollary fix #1: call error_setg if the bitmap node name that's a=
bout
> >>>> to go over the wire is an autogenerated node: this is never correct!
> >>>>
> >>>> (Why not? because the target is incapable of matching the node-name
> >>>> because they are randomly generated AND you cannot specify node-names
> >>>> with # prefixes as they are especially reserved!
> >>>>
> >>>> (This raises a related problem: if you explicitly add bitmaps to nod=
es
> >>>> with autogenerated names, you will be unable to migrate them.))
> >>>>
> >>>> --js
> >>>>
> >>>
> >>> What about the following:
> >>>
> >>> diff --git a/block.c b/block.c
> >>> index 5944124845..6739c19be9 100644
> >>> --- a/block.c
> >>> +++ b/block.c
> >>> @@ -1009,8 +1009,20 @@ static void bdrv_inherited_options(int *child_=
flags, QDict *child_options,
> >>>        *child_flags =3D flags;
> >>>    }
> >>>
> >>> +static const char *bdrv_child_get_name(BdrvChild *child)
> >>> +{
> >>> +    BlockDriverState *parent =3D child->opaque;
> >>> +
> >>> +    if (parent->drv && parent->drv->is_filter) {
> >>> +        return bdrv_get_parent_name(parent);
> >>> +    }
> >>> +
> >>> +    return NULL;
> >>> +}
> >>> +
> >>
> >> Why would we skip filters explicitly added by the user?
> >>
> >=20
> > Why not? Otherwise migration of bitmaps will not work: we may have diff=
erent set
> > of filters on source and destination, and we still should map nodes wit=
h bitmaps
> > automatically.
>=20
> Why would we have a different set of explicitly added filters on source
> and destination and allow them to be automatically changed during
> migration?  Shouldn=E2=80=99t users only change them pre or post migratio=
n?

We never made a requirement that the backend must be the same on the
source and the destination. Basically, migration copies the state of
frontends and the user is responsible for having these frontends created
and connected to the right backends on the destination.

Using different paths on the destination is a very obvious requirement
for block devices. It's less obvious for the graph structure, but I
don't see a reason why it couldn't change on migration. Say we were
using local storage on the source, but now we did storage migration to
some network storage, access to which should be throttled.

Kevin

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdk2w+AAoJEH8JsnLIjy/WgTUQAKUHb111O3ePeTjMM5rW3hm1
Q5iARxBdRC9bBTjpEi3AraRZ82Kj4BMO0wTiwQIESNwJmQqwJxSM0OI/ff6VilIU
rNJGMEhTqFai1CG3YRMhHHrwPQATqG1Y7Jv3ieeDzoTCSYswP/w4yZid2mKzAccy
khaXfp3rUYv5j7vIJADof1XSqupu1ddJzmH7Kfxp+DVnnfLTrRTAqw75kzhGDkrK
pFwjpyk81GxAEI35gszhE63ITPf1jRg/Bstpk1BmdHIuANC7kOjjvC9fKTXP9w+1
JbmoXRT1Mz1QBRUfocdMCbpPP7fU2EYNYE4CDDMXzuPZOsRCHK/XFi9EF2j4lErc
hsoBU/cA92xc/8gGwG1FuoZjB02tptFi0jvrg4fYistnP1/6xcbSAvwdpK9dHynf
rBF55S54O9qS6iyDSzD65ODazoDe2tiMki+IyMKyTi/GamweQrIUVBR5YYTkXzc6
t2H5WwP+yYT5jlOHD0Rfi4BYfx9ZUUZnHI3cvJiQRtAhs0RgIg1lwSZjYnNgExZF
OMlELjhxq/sy54ETHBScsrOKoBSRM2w6ppfTB0qlHJfkOPJqpnaFWfrH/BolVGdV
cyY349o1ME/MSbz+e7edsi19LZwGdISsMAqVNLeN4gzgvb7odW6sCNReKiILJ7K2
EDGj/m8P5AgMpOTko5ru
=wFbC
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

