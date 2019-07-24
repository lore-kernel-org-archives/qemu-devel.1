Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEAAC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5999E227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5999E227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqCH9-0001Gt-Ak
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 04:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hqCGy-0000nX-5t
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hqCGx-0003LS-1U
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:05:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hqCGt-0003Is-QP; Wed, 24 Jul 2019 04:05:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 606983E2CB;
 Wed, 24 Jul 2019 08:05:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-99.ams2.redhat.com
 [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFFC35D721;
 Wed, 24 Jul 2019 08:05:08 +0000 (UTC)
Date: Wed, 24 Jul 2019 10:05:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <20190724080507.GB4873@localhost.localdomain>
References: <20190719134345.23526-1-kwolf@redhat.com>
 <20190719134345.23526-2-kwolf@redhat.com>
 <42945b0e-8583-ba6e-16c5-2cdb7595206a@de.ibm.com>
 <351d4790-3ea3-9cd2-1c4d-6042ea35507c@virtuozzo.com>
 <20190724073805.GA4873@localhost.localdomain>
 <6149d521-1b45-c2a0-5bcc-1c8fbe0c2381@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6149d521-1b45-c2a0-5bcc-1c8fbe0c2381@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 24 Jul 2019 08:05:10 +0000 (UTC)
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

Am 24.07.2019 um 09:57 hat Andrey Shinkevich geschrieben:
>=20
>=20
> On 24/07/2019 10:38, Kevin Wolf wrote:
> > Am 24.07.2019 um 09:30 hat Andrey Shinkevich geschrieben:
> >>
> >>
> >> On 24/07/2019 10:18, Christian Borntraeger wrote:
> >>>
> >>> On 19.07.19 15:43, Kevin Wolf wrote:
> >>>> From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> >>>>
> >>>> The Valgrind tool reports about the uninitialised buffer 'buf'
> >>>> instantiated on the stack of the function guess_disk_lchs().
> >>>> Pass 'read-zeroes=3Don' to the null block driver to make it determin=
istic.
> >>>> The output of the tests 051, 186 and 227 now includes the parameter
> >>>> 'read-zeroes'. So, the benchmark output files are being changed too.
> >>>>
> >>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> >>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> >>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>>> ---
> >>>>    tests/qemu-iotests/051        |  10 +--
> >>>>    tests/qemu-iotests/051.pc.out |  10 +--
> >>>>    tests/qemu-iotests/093        |   9 +-
> >>> [...9
> >>>
> >>>
> >>> I now get the following on s390.
> >>> Seems that you only fixed 051.pc.out but not 051.out
> >>>
> >>>       051      ...        [09:01:49]             ...              051=
      =1B[1m=1B[31mfail      =1B[0m [09:01:49] [09:01:50]                  =
  output mismatch (see 051.out.bad)
> >>>       --- tests/qemu-iotests/051.out	2019-07-09 18:34:26.734654933 +0=
200
> >>>       +++ build/tests/qemu-iotests/051.out.bad	2019-07-24 09:01:50.01=
5024901 +0200
> >>>       @@ -149,23 +149,23 @@
> >>>       =20
> >>>        =3D=3D=3D Cache modes =3D=3D=3D
> >>>       =20
> >>>       -Testing: -drive driver=3Dnull-co,cache=3Dnone
> >>>       +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dnone
> >>>        QEMU X.Y.Z monitor - type 'help' for more information
> >>>        (qemu) quit
> >>>       =20
> >>>       -Testing: -drive driver=3Dnull-co,cache=3Ddirectsync
> >>>       +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Ddire=
ctsync
> >>>        QEMU X.Y.Z monitor - type 'help' for more information
> >>>        (qemu) quit
> >>>       =20
> >>>       -Testing: -drive driver=3Dnull-co,cache=3Dwriteback
> >>>       +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwrit=
eback
> >>>        QEMU X.Y.Z monitor - type 'help' for more information
> >>>        (qemu) quit
> >>>       =20
> >>>       -Testing: -drive driver=3Dnull-co,cache=3Dwritethrough
> >>>       +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwrit=
ethrough
> >>>        QEMU X.Y.Z monitor - type 'help' for more information
> >>>        (qemu) quit
> >>>       =20
> >>>       -Testing: -drive driver=3Dnull-co,cache=3Dunsafe
> >>>       +Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dunsa=
fe
> >>>        QEMU X.Y.Z monitor - type 'help' for more information
> >>>        (qemu) quit
> >>>       =20
> >>>
> >>
> >> Thank you Christian for your report.
> >> Would you please send the command line you ran the 051 test with?
> >>
> >> Kevin,
> >> How do add the 051.out file to the patch? New version?
> >=20
> > No, we need a follow-up patch. This one is already merged, so we can't
> > change it any more.
> >=20
> > Kevin
> >=20
>=20
> Thank you and Christian both.
> It is my first time I have been doing the fix patch.
> Should it be named a specific way like "iotests: Fix for..."?

People sometimes use a "Fixes: <commit number>" tag in the body of the
commit message, which is probably a good idea. The subject line just
describes the change as usual.

Kevin

