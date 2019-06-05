Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D7BC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68372075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68372075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49969 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYd31-0001oC-NI
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:02:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYcl8-0002g9-QH
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYcl7-0004YY-Ej
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:43:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hYcl3-0004H1-Su; Wed, 05 Jun 2019 16:43:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1D6530593D8;
	Wed,  5 Jun 2019 20:43:29 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 50C0A29AD9;
	Wed,  5 Jun 2019 20:43:24 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:43:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190605204323.GF22416@habkost.net>
References: <20190520220635.10961-1-f4bug@amsat.org>
	<20190520220635.10961-3-f4bug@amsat.org>
	<20190605160659.GB7080@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190605160659.GB7080@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 05 Jun 2019 20:43:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] BootLinuxConsoleTest: Test the
 SmartFusion2 board
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Alistair Francis <alistair@alistair23.me>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 12:06:59PM -0400, Cleber Rosa wrote:
> On Tue, May 21, 2019 at 12:06:35AM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> > Similar to the x86_64/pc test, it boots a Linux kernel on an
> > Emcraft board and verify the serial is working.
> >=20
> > If ARM is a target being built, "make check-acceptance" will
> > automatically include this test by the use of the "arch:arm" tags.
> >=20
> > Alternatively, this test can be run using:
> >=20
> >   $ avocado run -t arch:arm tests/acceptance
> >   $ avocado run -t machine:emcraft-sf2 tests/acceptance
> >
>=20
> The pattern accepted as a tag currently doesn't include a dash, see:
>=20
>    https://avocado-framework.readthedocs.io/en/68.0/ReferenceGuide.html=
#docstring-directives-rules
>=20

Why isn't this causing test jobs to fail?

This patch is already queued on python-next, should I remove it?


> My suggestion is to replace the dash for an underline.  This was done
> on the s390 test:
>=20
>    :avocado: tags=3Dmachine:s390_ccw_virtio

I would love if we stopped using the docstring to store
machine-readable data and used Python class attributes or
methods, like most Python APIs do.  e.g.:

  class MyTest(avocado.Test):
      tags =3D {'machine':'s390-ccw-virtio'}

      def test_my_feature(self):
          ...


I understand the Avocado runner currently tries to not run any
test code at the "list" step.  But can we have a mode where it
will actually load the Python module and look at the class
objects directly, instead of trying to parse the Python code
without evaluating it?

> [...]

--=20
Eduardo

