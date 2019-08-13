Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB21C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89CF20679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89CF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxTDH-0005UI-8d
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 05:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54185)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hxTCT-0003ha-H1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hxTCS-0006sE-Gy
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:34:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hxTCQ-0006qp-1u; Tue, 13 Aug 2019 05:34:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37B94308A98C;
 Tue, 13 Aug 2019 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-18.ams2.redhat.com
 [10.36.117.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9EE91001DC2;
 Tue, 13 Aug 2019 09:34:35 +0000 (UTC)
Date: Tue, 13 Aug 2019 11:34:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190813093434.GB4663@localhost.localdomain>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 13 Aug 2019 09:34:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.08.2019 um 21:46 hat Max Reitz geschrieben:
> On 12.08.19 20:11, Vladimir Sementsov-Ogievskiy wrote:
> > Hi all!
> >=20
> > I'm not sure, is it a bug or a feature, but using qcow2 under raw is
> > broken. It should be either fixed like I propose (by Max's suggestion)
> > or somehow forbidden (just forbid backing-file supporting node to be
> > file child of raw-format node).
>=20
> I agree, I think only filters should return BDRV_BLOCK_RAW.

If BDRV_BLOCK_RAW isn't suitable for raw, something went wrong. :-)

But anyway, raw is essentially a filter, at least if you don't use
the offset option. And BDRV_BLOCK_RAW shouldn't even depend on an
unchanged offset because the .bdrv_co_block_status implementation
returns the right offset.

And indeed, you can replace raw with blkdebug and it still fails (the
testcase from patch 2 fails, too, but it's obvious enough this way):

    $ ./qemu-img map --output=3Djson --image-opts driver=3Dqcow2,file.drive=
r=3Dfile,file.filename=3D/tmp/test.qcow2=20
    [{ "start": 0, "length": 1048576, "depth": 1, "zero": true, "data": fal=
se},
    { "start": 1048576, "length": 1048576, "depth": 1, "zero": false, "data=
": true, "offset": 327680},
    { "start": 2097152, "length": 65011712, "depth": 1, "zero": true, "data=
": false}]

    $ ./qemu-img map --output=3Djson --image-opts driver=3Draw,file.driver=
=3Dqcow2,file.file.driver=3Dfile,file.file.filename=3D/tmp/test.qcow2=20
    [{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": f=
alse}]

    $ ./qemu-img map --output=3Djson --image-opts driver=3Dblkdebug,image.d=
river=3Dqcow2,image.file.driver=3Dfile,image.file.filename=3D/tmp/test.qcow=
2=20
    [{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": f=
alse}]

After applying your "deal with filters" series, blkdebug actually prints
the expected result and passes the iotests case, but raw still doesn't.
So you must have fixed something for filters that declare themselves
filters, even though that semantics should probably be coupled to
BDRV_BLOCK_RAW instead so that the raw format can benefit from it, too.

Kevin

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdUoQqAAoJEH8JsnLIjy/Wch8QAK+EftRmrkLEQOmXcwFlEAyy
LweBLdhSKmYSg043rrFfQJq/1pShz1EVRFKMCvoa6TDpPt4z2h1sK8knw1MAviKG
8ClP9+z5h3nvotBwU8aWtOTyRhPuXJFX4BUhOZdlZkCrhVLJbcYL5whlX0088Sy/
DDoN04N+sQLjJ/WOQunyvCd7v1e2f5FL67IpawskSUx5QOUSu/kB5+JVtxm0yvAu
+DWHABNgyxbxkdnEiMyAb8vG+9IA0cS5JaKMsMoRPZpibstTaE9nwDgVljWWDBXm
RydwnTj962xUOzJTbV2wvSxsZyfw4CAv+Kw1CjsAXvJSfFmYxEeVskK1M9QmgDQB
QKRrJnRgkEr1wYpHMsc6FoePVScfsQqai7hH1OcMTv1GiySKRYu11YLtF4hGsNIZ
9bIAtm/TtFWFZC+5/iTxBdJ/kOd3gOnhPvMmVtpir64ct0gL21VydiE4xErgnSZV
sx6cFT6LGNPuZNNk9EMj/zHXezcEiScEyX9BDrsINxzApEl+33mAUK200ZEhhSAl
tqct8OkEkCbzdNWYc6WS46KevUaicmetav82xejyXIeTrUd/iAELR+OtTgVTP1dL
lMoJ8CABFzx8k7hdWJX/+zBmEiCimFGkfwDI0SK+soIuMzGtSVWOfleVNv7Pvwk4
rdqp91y2Ncasgp5jUl6c
=qiRo
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

