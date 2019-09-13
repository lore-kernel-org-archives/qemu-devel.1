Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAEFC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A340B20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A340B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jsG-0004y9-Ma
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8jr6-0003z6-8N
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8jr5-0005HU-3p
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:35:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8jqz-0005AR-EC; Fri, 13 Sep 2019 07:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8665D3084037;
 Fri, 13 Sep 2019 11:35:04 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0C05608C2;
 Fri, 13 Sep 2019 11:35:00 +0000 (UTC)
Date: Fri, 13 Sep 2019 13:34:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190913113459.GE8312@dhcp-200-226.str.redhat.com>
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
 <20190816153015.447957-4-vsementsov@virtuozzo.com>
 <20190913100146.GC8312@dhcp-200-226.str.redhat.com>
 <d6ca4ea6-2939-4d0f-c6f6-ff32a337de01@virtuozzo.com>
 <40620e71-a5e0-b955-d310-eef14ad3871c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <40620e71-a5e0-b955-d310-eef14ad3871c@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 13 Sep 2019 11:35:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/5] block/qcow2: refactor
 qcow2_co_preadv_part
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.09.2019 um 13:06 hat Max Reitz geschrieben:
> On 13.09.19 12:53, Vladimir Sementsov-Ogievskiy wrote:
> > 13.09.2019 13:01, Kevin Wolf wrote:
> >> Am 16.08.2019 um 17:30 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>> Further patch will run partial requests of iterations of
> >>> qcow2_co_preadv in parallel for performance reasons. To prepare for
> >>> this, separate part which may be parallelized into separate function
> >>> (qcow2_co_preadv_task).
> >>>
> >>> While being here, also separate encrypted clusters reading to own
> >>> function, like it is done for compressed reading.
> >>>
> >>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>> ---
> >>>   qapi/block-core.json |   2 +-
> >>>   block/qcow2.c        | 205 +++++++++++++++++++++++-----------------=
---
> >>>   2 files changed, 111 insertions(+), 96 deletions(-)
> >>>
> >>> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >>> index 0d43d4f37c..dd80aa11db 100644
> >>> --- a/qapi/block-core.json
> >>> +++ b/qapi/block-core.json
> >>> @@ -3266,7 +3266,7 @@
> >>>               'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
> >>>               'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
> >>>               'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
> >>> -            'cor_write', 'cluster_alloc_space', 'none'] }
> >>> +            'cor_write', 'cluster_alloc_space', 'none', 'read_encryp=
ted'] }
> >>
> >> What's the point of this new blkdebug event?
> >>
> >> Obviously, read_aio for an encrypted image must mean a read of encrypt=
ed
> >> data. The same image can never trigger both read_aio and
> >> read_encrypted, so why do we need to distinguish them as two different
> >> events?
> >>
> >=20
> > Seems I just done it looking at qcow2_co_preadv_compressed..
> >=20
> > Anyway, I think you are right, so, I don't mind if Max drops this new e=
vent
> > and use read_aio in his branch, or I can resend the series or send a fo=
llow-up,
> > whichever you prefer.
>=20
> Should I squash this in?

Looks good to me.


--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJde37jAAoJEH8JsnLIjy/W4kAP/i/WKjJ7dTsmT5i4gDes/Rv2
yV9nhkKy9t2VWhlVGO5kl8ddsMRrxmD1QODsuQApJX3mphaZ5Mg56DpRGPBp32LL
x6zxMcN0iHNILhq4E+79Z/mdPNYkYm3V7nZZmnQBiszajUuNYXObzP85+OOBVpDG
6V2i5PXMmyB7hxPz5qXEqyTTIP3km2y8uNjuSUZcOLByMxVeIpQBWFGQYifPe18O
xJ4yp7QakiaJ2KQpAO23n8eGsdBi5O2Bxfw7QbJKJ7XA4pQcxqLBhmCcG9JM5cnA
MRrvajQcQmwKl/A7QHsL32+nvCPKdUaKm/33eHz/ZKJUC/Xmax74XSdNGRO8/hj0
D+tbseGxGbZrBs1dfAu5q831hHlvuP/tqSAuz/41BdC/dp1xN592yssurhIfULON
wShejz5lAUjry31WRrkrdBWsQyrRy8YxA/M0RYY7cL3uxf17UovQ+QaAFHMdTrJP
1j1FcWVJfA5hl/pYv3uJE0s+G94CPNjRGJ4xtEzMTHOzBPk0DJ+HlsPQN71eA9If
lvrX1xQiwv/U+3PG9emMUYQmOxMfljvAswAdcBR/EFRnSZJGJx8XbKjtj19Nf49V
rsfFCqb5UPgFyCE7R+tNo5HMwm/OKLanjcOImd5pVvc/0W4kSGTQDHsawkarhx4f
pjWIOK+GrInqJKGjCP9g
=IZmg
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--

