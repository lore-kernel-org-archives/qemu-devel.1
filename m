Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11B0C742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF99020863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF99020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltYf-00086p-T1
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hltYT-0007dV-8d
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hltYS-0007nj-4X
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hltYN-0007kx-0e; Fri, 12 Jul 2019 07:17:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83CF159441;
 Fri, 12 Jul 2019 11:17:25 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA5F65DD8D;
 Fri, 12 Jul 2019 11:17:21 +0000 (UTC)
Date: Fri, 12 Jul 2019 13:17:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190712111720.GF4514@dhcp-200-226.str.redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-3-mreitz@redhat.com>
 <20190712094919.GC4514@dhcp-200-226.str.redhat.com>
 <e0d93b2b-21c2-3eaa-bf27-0a1c7f19f4e4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <e0d93b2b-21c2-3eaa-bf27-0a1c7f19f4e4@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 12 Jul 2019 11:17:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 2/5] block: Generic truncation fallback
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.07.2019 um 12:58 hat Max Reitz geschrieben:
> On 12.07.19 11:49, Kevin Wolf wrote:
> > Am 11.07.2019 um 21:58 hat Max Reitz geschrieben:
> >> If a protocol driver does not support truncation, we call fall back to
> >> effectively not doing anything if the new size is less than the actual
> >> file size.  This is what we have been doing for some host device drive=
rs
> >> already.
> >=20
> > Specifically, we're doing it for drivers that access a fixed-size image,
> > i.e. block devices rather than regular files. We don't want to do this
> > for drivers where the file size could be changed, but just didn't
> > implement it.
> >=20
> > So I would suggest calling the function more specifically something like
> > bdrv_co_truncate_blockdev(), and not using it as an automatic fallback
> > in bdrv_co_truncate(), but just make it the BlockDriver.bdrv_co_truncate
> > implementation for those drivers where it makes sense.
>=20
> I was thinking about this, but the problem is that .bdrv_co_truncate()
> does not get a BdrvChild, so an implementation for it cannot generically
> zero the first sector (without bypassing the permission system, which
> would be wrong).

Hm, I see. The next best thing would then probably having a bool in
BlockDriver that enables the fallback.

> So the function pointer would actually need to be set to something like
> (int (*)(BlockDriverState *, int64_t, PreallocMode, Error **))42ul, or a
> dummy function that just aborts, and then bdrv_co_truncate() would
> recognize this magic constant.  But that seemed so weird to me that I
> decided just not to do it, mostly because I was wondering what would be
> so bad about treating images whose size we cannot change because we
> haven=E2=80=99t implemented it exactly like fixed-size images.
>=20
> (Also, =E2=80=9Cfixed-size=E2=80=9D is up to interpretation.  You can cha=
nge an LVM
> volume=E2=80=99s size.  qemu doesn=E2=80=99t do it, obviously.  But that =
is the reason
> for the warning qemu-img resize emits when it sees that the file size
> did not change.)
>=20
> > And of course, we only need these fake implementations because qemu-img
> > (or .bdrv_co_create_opts) always wants to create the protocol level. If
> > we could avoid this, then we wouldn't need any of this.
>=20
> It=E2=80=99s trivial to avoid this.  I mean, patch 4 does exactly that.
>=20
> So it isn=E2=80=99t about avoiding creating the protocol level, it=E2=80=
=99s about
> avoiding the truncation there.  But why would you do that?

Because we can't actually truncate there. We can only do the fake thing
and claim we have truncated even though the size didn't change.

But actually, while avoiding the fake truncate outside of image creation
would avoid confusing situations where the user requested image
shrinking, gets success, but nothing happened, it would also break
actual resizes where the volume is resized externally and block_resize
is only called to notify qemu to pick up the size change.

So after all, we probably do need to keep the hack in bdrv_co_truncate()
instead of moving it to image creation only.

Kevin

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdKGxAAAoJEH8JsnLIjy/W2u8QAKp0U8XUrw5GSI+ilMrpKqEK
59zmPoTDZsqWlh8FrEY5ZPS9wg6Fl0/WIuEdGUoFAquL1gObGE5VL4g8iwAiER0v
Ot6Q9Oujmj0WWTOJyFhkirOAEtWhQwRKbUNVRgO8uMVa0seyLgzRQbnQHAa996fk
1q0MkyPNNlV+137/TZgJJdXsv3BJDiuHyP6Aq1FrVVD8w45r/f1Cum7GXkUcuIWU
iXhRTAQWvp0Z0mwoybinA/UzKdxJqrvW/cgqZWNyfB2AZ505SCQLlMaD9jzktRbw
wT2lOsN3/GUz9qEIB2r/WoTuMdZk7dNI3/qHfnDvRDLyRy0o4ChjGRvt8yBtz0ia
cllfryfZY6WERqupzJfAzerBVBnkOZQlze/pXWBwcEUVPxX7a1IAaKxWqnyMGx4T
BmVbjkw2R/S5Y+vmv5pAKGmg8N4W28hYAzF89DcnDSIKB2iea7rcw8kJMyP8VSZW
SyYxSzuD9HyuZrD3EbT79o8SJzhqUw7C9MKJjBwOkAiPZdgCONs2ERB9RoWznwKe
gUXMyy9i1ZlGUtRGO3zwt4rvhzQD+GXlRBYAsPOpN4yqY42PG3ieOQui3oWm0Z+V
xjqOBRrEvsfNiD96txWk+CMRsuNE9og6ZMtb+oh0LaS+B+fbA4V4tru9zYYKszeL
WglEY8Ep+tXL4uYqchtV
=wtez
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

