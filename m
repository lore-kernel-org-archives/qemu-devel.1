Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86791C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDA821855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDA821855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEwSW-0004sa-4m
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 10:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEwRS-00049w-MF
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEwRR-000821-7z
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:14:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEwRO-00080Q-5g; Mon, 30 Sep 2019 10:14:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DEFE20F4;
 Mon, 30 Sep 2019 14:14:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4DBA5C219;
 Mon, 30 Sep 2019 14:14:15 +0000 (UTC)
Message-ID: <a9ac9b3afa41a4595d3ed0dee4648a78650ac573.camel@redhat.com>
Subject: Re: [PATCH 01/18] iotests: Filter refcount_order in 036
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Mon, 30 Sep 2019 17:14:14 +0300
In-Reply-To: <5f8b9dd4-ba2e-0dbb-3216-3baa73a769c4@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-2-mreitz@redhat.com>
 <f8db846b4dba5cd8febc09e871a932c7999f5403.camel@redhat.com>
 <d10fef7d-502a-d8c9-c548-bb6088d16c69@redhat.com>
 <4b3bea45194528716499d1624cdefa6cd3a56806.camel@redhat.com>
 <5e39c90a-1e78-6c07-e03b-cef23f566227@redhat.com>
 <97bc2bcdd0ba3582d8b937cd0de32e8419a5d104.camel@redhat.com>
 <5f8b9dd4-ba2e-0dbb-3216-3baa73a769c4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 30 Sep 2019 14:14:17 +0000 (UTC)
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

On Mon, 2019-09-30 at 16:04 +0200, Max Reitz wrote:
> On 30.09.19 15:58, Maxim Levitsky wrote:
> > On Mon, 2019-09-30 at 15:44 +0200, Max Reitz wrote:
> > > On 30.09.19 15:40, Maxim Levitsky wrote:
> > > > On Mon, 2019-09-30 at 14:43 +0200, Max Reitz wrote:
> > > > > On 29.09.19 18:31, Maxim Levitsky wrote:
> > > > > > On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
> > > > > > > This test can run just fine with other values for refcount_=
bits, so we
> > > > > > > should filter the value from qcow2.py's dump-header.
> > > > > > >=20
> > > > > > > (036 currently ignores user-specified image options, but th=
at will be
> > > > > > > fixed in the next patch.)
> > > > > > >=20
> > > > > > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > > > > > ---
> > > > > > >  tests/qemu-iotests/036     | 9 ++++++---
> > > > > > >  tests/qemu-iotests/036.out | 6 +++---
> > > > > > >  2 files changed, 9 insertions(+), 6 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/03=
6
> > > > > > > index f06ff67408..69d0f9f903 100755
> > > > > > > --- a/tests/qemu-iotests/036
> > > > > > > +++ b/tests/qemu-iotests/036
> > > > > > > @@ -55,7 +55,8 @@ $PYTHON qcow2.py "$TEST_IMG" set-feature-=
bit incompatible 63
> > > > > > > =20
> > > > > > >  # Without feature table
> > > > > > >  $PYTHON qcow2.py "$TEST_IMG" del-header-ext 0x6803f857
> > > > > > > -$PYTHON qcow2.py "$TEST_IMG" dump-header
> > > > > > > +$PYTHON qcow2.py "$TEST_IMG" dump-header \
> > > > > > > +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
> > > > > > >  _img_info
> > > > > > > =20
> > > > > > >  # With feature table containing bit 63
> > > > > > > @@ -103,14 +104,16 @@ echo =3D=3D=3D Create image with unkn=
own autoclear feature bit =3D=3D=3D
> > > > > > >  echo
> > > > > > >  _make_test_img 64M
> > > > > > >  $PYTHON qcow2.py "$TEST_IMG" set-feature-bit autoclear 63
> > > > > > > -$PYTHON qcow2.py "$TEST_IMG" dump-header
> > > > > > > +$PYTHON qcow2.py "$TEST_IMG" dump-header \
> > > > > > > +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
> > > > > > > =20
> > > > > > >  echo
> > > > > > >  echo =3D=3D=3D Repair image =3D=3D=3D
> > > > > > >  echo
> > > > > > >  _check_test_img -r all
> > > > > > > =20
> > > > > > > -$PYTHON qcow2.py "$TEST_IMG" dump-header
> > > > > > > +$PYTHON qcow2.py "$TEST_IMG" dump-header \
> > > > > > > +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
> > > > > > > =20
> > > > > > >  # success, all done
> > > > > > >  echo "*** done"
> > > > > > > diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotest=
s/036.out
> > > > > > > index e489b44386..998c2a8a35 100644
> > > > > > > --- a/tests/qemu-iotests/036.out
> > > > > > > +++ b/tests/qemu-iotests/036.out
> > > > > > > @@ -19,7 +19,7 @@ snapshot_offset           0x0
> > > > > > >  incompatible_features     0x8000000000000000
> > > > > > >  compatible_features       0x0
> > > > > > >  autoclear_features        0x0
> > > > > > > -refcount_order            4
> > > > > > > +refcount_order            (filtered)
> > > > > > >  header_length             104
> > > > > > > =20
> > > > > > >  qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported =
IMGFMT feature(s): Unknown incompatible feature: 8000000000000000
> > > > > > > @@ -53,7 +53,7 @@ snapshot_offset           0x0
> > > > > > >  incompatible_features     0x0
> > > > > > >  compatible_features       0x0
> > > > > > >  autoclear_features        0x8000000000000000
> > > > > > > -refcount_order            4
> > > > > > > +refcount_order            (filtered)
> > > > > > >  header_length             104
> > > > > > > =20
> > > > > > >  Header extension:
> > > > > > > @@ -81,7 +81,7 @@ snapshot_offset           0x0
> > > > > > >  incompatible_features     0x0
> > > > > > >  compatible_features       0x0
> > > > > > >  autoclear_features        0x0
> > > > > > > -refcount_order            4
> > > > > > > +refcount_order            (filtered)
> > > > > > >  header_length             104
> > > > > > > =20
> > > > > > >  Header extension:
> > > > > >=20
> > > > > > Minor notes:
> > > > > >=20
> > > > > > 1. Maybe put the sed command into a function to avoid duplica=
tion?
> > > > >=20
> > > > > Hm, maybe, but that would increase the LoC, so I=E2=80=99m not =
sure whether it
> > > > > really would be a simplification.
> > > >=20
> > > > IMHO, in my opinion, regardless of LOC, duplicated code is almost=
 always
> > > > bad. Common functions are mostly for the next guy that will be ab=
le to use
> > > > them instead of searching through code to see how this is done th=
ere and there.
> > >=20
> > > In my experience, people write tests without scanning common.filter=
 for
> > > whether anyone has written the same code already.  See the
> > > _filter_qemu_img_check example in this series.
> >=20
> > Fair enough, but this can change.
>=20
> It won=E2=80=99t.
>=20
> It only changes when people use standardized functions that filter
> automatically.  And writing that made me look into common.rc, and ah
> yes, we have a _check_test_img.  So the correct thing to do is not to
> use _filter_qemu_img_check (or to expect people to scan the filter file
> for filters), but to use _check_test_img there.
>=20
> > > > > > 2. As I understand the test, it only checks the feature bits.
> > > > > >    So maybe instead of blacklisting some of the values, white=
 list
> > > > > >    only the feature bits in the output?
> > > > >=20
> > > > > Hm.  Seems reasonable, but then again I=E2=80=99d prefer a mini=
mal change, and
> > > > > changing it to a whitelist would be more change...
> > > >=20
> > > > I don't think this is bad, again in my eyes, the code should be a=
s friendly
> > > > as possible for the next guy that will have to change it, so addi=
ng
> > > > some more extra changes don't seem a problem to me.
> > >=20
> > > In my eyes tests aren=E2=80=99t code.
> >=20
> > And yet, writing tests is commonly known as a task=20
> > that developers don't really like to do, so making that even a tinies=
t bit
> > easier, is a good thing IMHO,
>=20
> My problem is precisely that I don=E2=80=99t see how such a suggestion =
makes it
> easier to write test code.
>=20
> The easiest way to write a test is to just dump ad-hoc code into a bash
> file.  Sometimes that doesn=E2=80=99t work because what you want to tes=
t is more
> complex, so then you use Python.
>=20
>=20
> What I felt you were arguing about is changing existing test code, whic=
h
> is a completely different thing.  In my experience, that happens much
> more rarely and is thus a thing we don=E2=80=99t need to optimize for. =
 (And I=E2=80=99m
> saying this as the one who wrote this series which is just about
> changing existing test code.)


I won't argue on this! It all depends on lot and lot of things.

Best regards,
	Maxim Levitsky



