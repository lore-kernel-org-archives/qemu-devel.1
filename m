Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751BAC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B75720644
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B75720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8k9V-0004Z9-E7
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8k8m-0003yM-2I
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8k8k-0007ZU-Of
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8k8h-0007YI-QS; Fri, 13 Sep 2019 07:53:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BED973064FD1;
 Fri, 13 Sep 2019 11:53:22 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CEA010016EA;
 Fri, 13 Sep 2019 11:53:19 +0000 (UTC)
Message-ID: <2f309fc967aed1c15f2e68bd4a51d7180d6ea301.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 14:53:18 +0300
In-Reply-To: <f47ffd82-91e3-cc29-fb86-34de6a1b6ae8@redhat.com>
References: <20190912223754.875-1-mlevitsk@redhat.com>
 <20190912223754.875-4-mlevitsk@redhat.com>
 <f47ffd82-91e3-cc29-fb86-34de6a1b6ae8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 13 Sep 2019 11:53:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] qemu-iotests: Add test for bz
 #1745922
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-13 at 13:01 +0200, Max Reitz wrote:
> On 13.09.19 00:37, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  tests/qemu-iotests/263     | 91 ++++++++++++++++++++++++++++++++++++=
++
> >  tests/qemu-iotests/263.out | 40 +++++++++++++++++
> >  tests/qemu-iotests/group   |  1 +
> >  3 files changed, 132 insertions(+)
> >  create mode 100755 tests/qemu-iotests/263
> >  create mode 100644 tests/qemu-iotests/263.out
> >=20
> > diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
> > new file mode 100755
> > index 0000000000..afbd668cda
> > --- /dev/null
> > +++ b/tests/qemu-iotests/263
> > @@ -0,0 +1,91 @@
> > +#!/usr/bin/env bash
> > +#
> > +# Test encrypted write that crosses cluster boundary of two unalloca=
ted clusters
> > +# Based on 188
> > +#
> > +# Copyright (C) 2019 Red Hat, Inc.
> > +#
> > +# This program is free software; you can redistribute it and/or modi=
fy
> > +# it under the terms of the GNU General Public License as published =
by
> > +# the Free Software Foundation; either version 2 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
> > +#
> > +
> > +# creator
> > +owner=3Dmlevitsk@redhat.com
> > +
> > +seq=3D`basename $0`
> > +echo "QA output created by $seq"
> > +
> > +status=3D1	# failure is the default!
> > +
> > +_cleanup()
> > +{
> > +	_cleanup_test_img
> > +}
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +# get standard environment, filters and checks
> > +. ./common.rc
> > +. ./common.filter
> > +
> > +_supported_fmt qcow2
> > +_supported_proto generic
> > +_supported_os Linux
> > +
> > +
> > +size=3D1M
> > +
> > +SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"
> > +QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
> > +
> > +
> > +_run_test()
> > +{
> > +	echo "=3D=3D reading the whole image =3D=3D"
> > +	$QEMU_IO --object $SECRET -c "read -P 0 0 $size" --image-opts $1 | =
_filter_qemu_io | _filter_testdir
> > +
> > +	echo
> > +	echo "=3D=3D write two 512 byte sectors on a cluster boundary =3D=3D=
"
> > +	$QEMU_IO --object $SECRET -c "write -P 0xAA 0xFE00 0x400" --image-o=
pts $1 | _filter_qemu_io | _filter_testdir
> > +
> > +	echo
> > +	echo "=3D=3D verify that the rest of the image is not changed =3D=3D=
"
> > +	$QEMU_IO --object $SECRET -c "read -P 0x00 0x00000 0xFE00" --image-=
opts $1 | _filter_qemu_io | _filter_testdir
> > +	$QEMU_IO --object $SECRET -c "read -P 0xAA 0x0FE00 0x400" --image-o=
pts $1 | _filter_qemu_io | _filter_testdir
> > +	$QEMU_IO --object $SECRET -c "read -P 0x00 0x10200 0xEFE00" --image=
-opts $1 | _filter_qemu_io | _filter_testdir
>=20
> Looks good to me overall, but in case you respin, I don=E2=80=99t think=
 there=E2=80=99s
> reason not to quote the $1.
>=20
> Max
>=20
Fixed, good idea.

Best regards,
	Maxim Levitsky


