Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E932C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67189215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67189215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExJk-0002Dy-Ik
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iExGG-0007Bw-Ea
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iExGF-00036B-1H
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:06:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iExGA-00032q-GF; Mon, 30 Sep 2019 11:06:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7DB0781F0E;
 Mon, 30 Sep 2019 15:06:45 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4312860C83;
 Mon, 30 Sep 2019 15:06:44 +0000 (UTC)
Message-ID: <261057584603c11edb4dd963b7e2da044e0b7a2f.camel@redhat.com>
Subject: Re: [PATCH 09/18] iotests: Drop IMGOPTS use in 267
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Mon, 30 Sep 2019 18:06:43 +0300
In-Reply-To: <c981dc5e-297d-1c7d-783e-0d9b87005448@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-10-mreitz@redhat.com>
 <1c6c86af32c3de1b473b48704cf506694c10c597.camel@redhat.com>
 <ee7488a7-9c85-1b37-0a28-d7cfee890f2d@redhat.com>
 <f7095f775cfae1b5dd7d317b16ec9deaf903435b.camel@redhat.com>
 <c981dc5e-297d-1c7d-783e-0d9b87005448@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 30 Sep 2019 15:06:45 +0000 (UTC)
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

On Mon, 2019-09-30 at 17:01 +0200, Max Reitz wrote:
> On 30.09.19 16:32, Maxim Levitsky wrote:
> > On Mon, 2019-09-30 at 15:01 +0200, Max Reitz wrote:
> > > On 29.09.19 18:33, Maxim Levitsky wrote:
> > > > On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
> > > > > Overwriting IMGOPTS means ignoring all user-supplied options, w=
hich is
> > > > > not what we want.  Replace the current IMGOPTS use by a new BAC=
KING_FILE
> > > > > variable.
> > > > >=20
> > > > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > > > ---
> > > > >  tests/qemu-iotests/267 | 12 ++++++++----
> > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
> > > > > index 95f885442f..529f5f9afe 100755
> > > > > --- a/tests/qemu-iotests/267
> > > > > +++ b/tests/qemu-iotests/267
> > > > > @@ -68,7 +68,11 @@ size=3D128M
> > > > > =20
> > > > >  run_test()
> > > > >  {
> > > > > -    _make_test_img $size
> > > > > +    if [ -n "$BACKING_FILE" ]; then
> > > > > +        _make_test_img -b "$BACKING_FILE" $size
> > > > > +    else
> > > > > +        _make_test_img $size
> > > > > +    fi
> > > > >      printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | ru=
n_qemu "$@" | _filter_date
> > > > >  }
> > > > > =20
> > > > > @@ -119,12 +123,12 @@ echo
> > > > > =20
> > > > >  TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
> > > > > =20
> > > > > -IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
> > > > > +BACKING_FILE=3D"$TEST_IMG.base" \
> > > > >  run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",n=
ode-name=3Dbacking-file \
> > > > >           -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-n=
ame=3Dfile \
> > > > >           -blockdev driver=3D$IMGFMT,file=3Dfile,backing=3Dback=
ing-file,node-name=3Dfmt
> > > > > =20
> > > > > -IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
> > > > > +BACKING_FILE=3D"$TEST_IMG.base" \
> > > > >  run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",n=
ode-name=3Dbacking-file \
> > > > >           -blockdev driver=3D$IMGFMT,file=3Dbacking-file,node-n=
ame=3Dbacking-fmt \
> > > > >           -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-n=
ame=3Dfile \
> > > > > @@ -141,7 +145,7 @@ echo
> > > > >  echo "=3D=3D=3D -blockdev with NBD server on the backing file =
=3D=3D=3D"
> > > > >  echo
> > > > > =20
> > > > > -IMGOPTS=3D"backing_file=3D$TEST_IMG.base" _make_test_img $size
> > > > > +_make_test_img -b "$TEST_IMG.base" $size
> > > > >  cat <<EOF |
> > > > >  nbd_server_start unix:$TEST_DIR/nbd
> > > > >  nbd_server_add -w backing-fmt
> > > >=20
> > > > qemu's master (pulled today), don't have iotest 267,
> > > > you probably based this on some not yet merged branch.
> > > > Or I made some mistake with pulling the master branch.
> > >=20
> > > Yep, it=E2=80=99s only in Kevin=E2=80=99s block branch (and thus mi=
ne, too).  He sent a
> > > pull request for it, which was rejected though (because this test i=
s
> > > broken on anything but x64, but that doesn=E2=80=99t stop this patc=
h).
> > >=20
> >=20
> > I figured out that it must be something like that.
> > Being lazy, I would like to ask if we have maybe a list of these=20
> > branches somewhere in the wiki?
>=20
> The MAINTAINERS file has at least Kevin=E2=80=99s branch:
>=20
> $ scripts/get_maintainer.pl --scm --no-email --no-l -f block
> git https://repo.or.cz/qemu/kevin.git block
Thank you!
I didn't knew that MAINTAINERS contain git branches these day.

Best regards,
	Maxim Levitsky




