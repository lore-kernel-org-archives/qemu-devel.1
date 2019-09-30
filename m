Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F37AC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F322086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F322086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvx8-0003aG-9r
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEvvj-0002g4-BY
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEvvh-0006r5-3I
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:41:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEvve-0006pg-9N; Mon, 30 Sep 2019 09:41:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69FB03066F49;
 Mon, 30 Sep 2019 13:41:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CD8860CDA;
 Mon, 30 Sep 2019 13:41:27 +0000 (UTC)
Message-ID: <2c498ae9fb8e7796d00dce6db2d3cbc2c3d3be42.camel@redhat.com>
Subject: Re: [PATCH 14/18] iotests: Make 110 work with data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Mon, 30 Sep 2019 16:41:27 +0300
In-Reply-To: <80d3ceb9-37f6-9b20-ee04-2376ed66e0f8@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-15-mreitz@redhat.com>
 <037a6ded4b29435dec32fe71f12613315915aeca.camel@redhat.com>
 <80d3ceb9-37f6-9b20-ee04-2376ed66e0f8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 30 Sep 2019 13:41:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-09-30 at 15:34 +0200, Max Reitz wrote:
> On 29.09.19 18:34, Maxim Levitsky wrote:
> > On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
> > > The only difference is that the json:{} filename of the image looks
> > > different.  We actually do not care about that filename in this tes=
t, we
> > > are only interested in (1) that there is a json:{} filename, and (2=
)
> > > whether the backing filename can be constructed.
> > >=20
> > > So just filter out the json:{} data, thus making this test pass bot=
h
> > > with and without data_file.
> > >=20
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tests/qemu-iotests/110     | 7 +++++--
> > >  tests/qemu-iotests/110.out | 4 ++--
> > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
> > > index f78df0e6e1..34459dcd60 100755
> > > --- a/tests/qemu-iotests/110
> > > +++ b/tests/qemu-iotests/110
> > > @@ -67,6 +67,7 @@ echo
> > >  # Across blkdebug without a config file, you cannot reconstruct fi=
lenames, so
> > >  # qemu is incapable of knowing the directory of the top image from=
 the filename
> > >  # alone. However, using bdrv_dirname(), it should still work.
> > > +# (Filter out the json:{} filename so this test works with externa=
l data files)
> > >  TEST_IMG=3D"json:{
> > >      'driver': '$IMGFMT',
> > >      'file': {
> > > @@ -82,7 +83,8 @@ TEST_IMG=3D"json:{
> > >              }
> > >          ]
> > >      }
> > > -}" _img_info | _filter_img_info | grep -v 'backing file format'
> > > +}" _img_info | _filter_img_info | grep -v 'backing file format' \
> > > +    | sed -e 's#^image: json:.*#image: json:{ /* filtered */ }#'
> > > =20
> > >  echo
> > >  echo '=3D=3D=3D Backing name is always relative to the backed imag=
e =3D=3D=3D'
> > > @@ -114,7 +116,8 @@ TEST_IMG=3D"json:{
> > >              }
> > >          ]
> > >      }
> > > -}" _img_info | _filter_img_info | grep -v 'backing file format'
> > > +}" _img_info | _filter_img_info | grep -v 'backing file format' \
> > > +    | sed -e 's#^image: json:.*#image: json:{ /* filtered */ }#'
> > > =20
> > > =20
> > >  # success, all done
> > > diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.ou=
t
> > > index f60b26390e..f835553a99 100644
> > > --- a/tests/qemu-iotests/110.out
> > > +++ b/tests/qemu-iotests/110.out
> > > @@ -11,7 +11,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DI=
R/t.IMGFMT.base)
> > > =20
> > >  =3D=3D=3D Non-reconstructable filename =3D=3D=3D
> > > =20
> > > -image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "re=
ad_aio", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "d=
river": "blkdebug", "set-state.0.new_state": 42}}
> > > +image: json:{ /* filtered */ }
> > >  file format: IMGFMT
> > >  virtual size: 64 MiB (67108864 bytes)
> > >  backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
> > > @@ -22,7 +22,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=
=3D67108864 backing_file=3Dt.IMGFMT.b
> > > =20
> > >  =3D=3D=3D Nodes without a common directory =3D=3D=3D
> > > =20
> > > -image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": =
"file", "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": =
"TEST_DIR/t.IMGFMT.copy"}], "driver": "quorum", "vote-
> > > threshold": 1}}
> > > +image: json:{ /* filtered */ }
> > >  file format: IMGFMT
> > >  virtual size: 64 MiB (67108864 bytes)
> > >  backing file: t.IMGFMT.base (cannot determine actual path)
> >=20
> > Again, maybe put that into the common.filter, so new tests won't need=
 to copy&paste this?
>=20
> Good idea.
>=20
> > Also maybe remove the image name completely from output, thus not nee=
ding the more complex regex?
>=20
> I=E2=80=99d prefer to still see that there is a json:{} filename instea=
d of a
> plain one.  (This is important in this test because for plain filenames=
,
> it=E2=80=99s generally easy to reconstruct the backing file path; it=E2=
=80=99s only
> difficult for json:{} filenames.)

All right, seems good.


Best regards,
	Maxim Levitsky
>=20
> Max
>=20



