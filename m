Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2334C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D3B21855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D3B21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEw4b-0008W2-SK
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEw0d-0006Ac-PR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEw0c-000158-FA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEw0W-000120-DZ; Mon, 30 Sep 2019 09:46:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7063C3086272;
 Mon, 30 Sep 2019 13:46:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 374C860624;
 Mon, 30 Sep 2019 13:46:29 +0000 (UTC)
Message-ID: <4067372d453e08515b079cff564f9d56fba2a21b.camel@redhat.com>
Subject: Re: [PATCH 15/18] iotests: Make 137 work with data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Mon, 30 Sep 2019 16:46:28 +0300
In-Reply-To: <5dff56b6-dca2-a28a-4a6a-2a6638300ff3@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-16-mreitz@redhat.com>
 <7e9c44bc0ca4b195939b0723db11eebc3fe11e2e.camel@redhat.com>
 <5dff56b6-dca2-a28a-4a6a-2a6638300ff3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 30 Sep 2019 13:46:30 +0000 (UTC)
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

On Mon, 2019-09-30 at 15:38 +0200, Max Reitz wrote:
> On 29.09.19 18:38, Maxim Levitsky wrote:
> > On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
> > > When using an external data file, there are no refcounts for data
> > > clusters.  We thus have to adjust the corruption test in this patch=
 to
> > > not be based around a data cluster allocation, but the L2 table
> > > allocation (L2 tables are still refcounted with external data files=
).
> > >=20
> > > Doing so means this test works both with and without external data
> > > files.
> > >=20
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tests/qemu-iotests/137     | 10 ++++++----
> > >  tests/qemu-iotests/137.out |  4 +---
> > >  2 files changed, 7 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
> > > index 6cf2997577..dd3484205e 100755
> > > --- a/tests/qemu-iotests/137
> > > +++ b/tests/qemu-iotests/137
> > > @@ -138,14 +138,16 @@ $QEMU_IO \
> > >      "$TEST_IMG" 2>&1 | _filter_qemu_io
> > > =20
> > >  # The dirty bit must not be set
> > > -$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_featu=
res
> > > +# (Filter the external data file bit)
> > > +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_featu=
res \
> > > +    | sed -e 's/0x4/0x0/'
> >=20
> > Maybe it is better to filter all the feature bits, but the dirty bit,
> > since only it is needed here, so that when we start running tests wit=
h
> > more features, we won't need to do this again?
>=20
> I=E2=80=99d hate a filter s/[02468ace]$/no dirty bit/ though.
Nothing a helper function can't solve IMHO, I would convert this to a num=
ber,
and then check bitwise the bit 2, assuming that is the dirty bit)
Again, note that my approach to code is to make it as easy as possible fo=
r the
next guy to change, so I am noticing such places. Eventually someone of u=
s,
will be that next guy. Then again, I don't mind leaving this as is, just =
noting this.
>=20
> > > =20
> > >  # Similarly we can test whether corruption detection has been enab=
led:
> > > -# Create L1/L2, overwrite first entry in refcount block, allocate =
something.
> > > +# Create L1, overwrite refcounts, force allocation of L2 by writin=
g
> > > +# data.
> > >  # Disabling the checks should fail, so the corruption must be dete=
cted.
> > >  _make_test_img 64M
> > > -$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
> > > -poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00"
> > > +poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00\x00\x00\x00\x00\x00=
\x00"
> >=20
> > I am wondering if there is any better way to do this (regardless of t=
his patch),
> > Basically the above code pokes into the 3rd cluster on the disk I *th=
ink*, and I don't
> > understand why it has to contain refcounts. Hmm...
> > First cluster I can guess will have the header, 2nd cluster probably =
L1 table, and 3rd, refcounts?
> > If so, the test should specify that it needs 64K clusters, because th=
e day will come when
> > we will need to test this as well, but I guess in a separate patch,
>=20
> When that day comes, a whole lot of other stuff will break, too.
I guess so, won't argue about this one.

Best regards,
	Maxim Levitsky


>=20
> Max
>=20



