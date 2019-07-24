Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9ABC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA792190F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA792190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqBr0-0007Dm-5w
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 03:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45329)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hqBqq-0006oO-M7
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hqBqo-0003AX-J1
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:38:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hqBqk-00038M-2b; Wed, 24 Jul 2019 03:38:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E555EA3B7C;
 Wed, 24 Jul 2019 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-99.ams2.redhat.com
 [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF815C230;
 Wed, 24 Jul 2019 07:38:07 +0000 (UTC)
Date: Wed, 24 Jul 2019 09:38:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <20190724073805.GA4873@localhost.localdomain>
References: <20190719134345.23526-1-kwolf@redhat.com>
 <20190719134345.23526-2-kwolf@redhat.com>
 <42945b0e-8583-ba6e-16c5-2cdb7595206a@de.ibm.com>
 <351d4790-3ea3-9cd2-1c4d-6042ea35507c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <351d4790-3ea3-9cd2-1c4d-6042ea35507c@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 24 Jul 2019 07:38:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 01/13] iotests: Set read-zeroes on in null
 block driver for Valgrind
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.07.2019 um 09:30 hat Andrey Shinkevich geschrieben:
>=20
>=20
> On 24/07/2019 10:18, Christian Borntraeger wrote:
> >=20
> > On 19.07.19 15:43, Kevin Wolf wrote:
> >> From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> >>
> >> The Valgrind tool reports about the uninitialised buffer 'buf'
> >> instantiated on the stack of the function guess_disk_lchs().
> >> Pass 'read-zeroes=3Don' to the null block driver to make it determinis=
tic.
> >> The output of the tests 051, 186 and 227 now includes the parameter
> >> 'read-zeroes'. So, the benchmark output files are being changed too.
> >>
> >> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> >> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> >> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> ---
> >>   tests/qemu-iotests/051        |  10 +--
> >>   tests/qemu-iotests/051.pc.out |  10 +--
> >>   tests/qemu-iotests/093        |   9 +-
> > [...9
> >=20
> >=20
> > I now get the following on s390.
> > Seems that you only fixed 051.pc.out but not 051.out
> >=20
> >      051      ...        [09:01:49]             ...              051   =
   =1B[1m=1B[31mfail      =1B[0m [09:01:49] [09:01:50]                    o=
utput mismatch (see 051.out.bad)
> >      --- tests/qemu-iotests/051.out	2019-07-09 18:34:26.734654933 +0200
> >      +++ build/tests/qemu-iotests/051.out.bad	2019-07-24 09:01:50.01502=
4901 +0200
> >      @@ -149,23 +149,23 @@
> >      =20
> >       =3D=3D=3D Cache modes =3D=3D=3D
> >      =20
> >      -Testing: -drive driver=3Dnull-co,cache=3Dnone
> >      +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dnone
> >       QEMU X.Y.Z monitor - type 'help' for more information
> >       (qemu) quit
> >      =20
> >      -Testing: -drive driver=3Dnull-co,cache=3Ddirectsync
> >      +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Ddirects=
ync
> >       QEMU X.Y.Z monitor - type 'help' for more information
> >       (qemu) quit
> >      =20
> >      -Testing: -drive driver=3Dnull-co,cache=3Dwriteback
> >      +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwriteba=
ck
> >       QEMU X.Y.Z monitor - type 'help' for more information
> >       (qemu) quit
> >      =20
> >      -Testing: -drive driver=3Dnull-co,cache=3Dwritethrough
> >      +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwriteth=
rough
> >       QEMU X.Y.Z monitor - type 'help' for more information
> >       (qemu) quit
> >      =20
> >      -Testing: -drive driver=3Dnull-co,cache=3Dunsafe
> >      +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dunsafe
> >       QEMU X.Y.Z monitor - type 'help' for more information
> >       (qemu) quit
> >      =20
> >=20
>=20
> Thank you Christian for your report.
> Would you please send the command line you ran the 051 test with?
>=20
> Kevin,
> How do add the 051.out file to the patch? New version?

No, we need a follow-up patch. This one is already merged, so we can't
change it any more.

Kevin

