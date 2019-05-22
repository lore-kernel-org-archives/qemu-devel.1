Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A01C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888CB20881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888CB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51407 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTYT3-00069m-Q9
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 17:08:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hTYRA-0004z9-Vt
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hTYR8-0002NG-U6
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:06:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>)
	id 1hTYQy-0002Ah-HA; Wed, 22 May 2019 17:06:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9345581F0D;
	Wed, 22 May 2019 21:05:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 878F454389;
	Wed, 22 May 2019 21:05:47 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 77E081806B14;
	Wed, 22 May 2019 21:05:47 +0000 (UTC)
Date: Wed, 22 May 2019 17:05:44 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <1204725743.24201394.1558559144548.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190522205234.GY10764@habkost.net>
References: <20190312234541.2887-1-philmd@redhat.com>
	<20190312234541.2887-3-philmd@redhat.com>
	<20190522205234.GY10764@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.36.116.137, 10.4.195.3]
Thread-Topic: Boot Linux Console Test: add a test for the Raspberry Pi 2
Thread-Index: 85aLi307SoOiFEeNWcragCqkXg6pqQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 22 May 2019 21:05:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Boot Linux Console Test: add a test
 for the Raspberry Pi 2
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
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	qemu-arm@nongnu.org,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Eduardo Habkost" <ehabkost@redhat.com>
> To: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: qemu-devel@nongnu.org, "Cleber Rosa" <crosa@redhat.com>, "Peter Mayde=
ll" <peter.maydell@linaro.org>,
> qemu-arm@nongnu.org, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>, "An=
drew Baumann" <Andrew.Baumann@microsoft.com>
> Sent: Wednesday, May 22, 2019 4:52:34 PM
> Subject: Re: [Qemu-devel] [PATCH v2 2/2] Boot Linux Console Test: add a t=
est for the Raspberry Pi 2
>=20
> On Wed, Mar 13, 2019 at 12:45:41AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >=20
> > Similar to the x86_64/pc test, it boots a Linux kernel on a raspi2
> > board and verify the serial is working.
> >=20
> > If ARM is a target being built, "make check-acceptance" will
> > automatically include this test by the use of the "arch:arm" tags.
> >=20
> > Alternatively, this test can be run using:
> >=20
> >     $ avocado run -t arch:arm tests/acceptance
> >     $ avocado run -t machine:raspi2 tests/acceptance
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> We're getting timeouts on travis-ci:
> https://travis-ci.org/ehabkost/qemu/jobs/535468057#L3289
>=20
> I don't know yet if the guest is hanging, or if we just need to
> increase the timeout.  I could reproduce the timeout locally,
> too.
>=20
> --
> Eduardo
>=20

It may be related to:

 https://bugs.launchpad.net/qemu/+bug/1829779

And this is a proof that we urgently need to have a better
way of presenting/storing test artifacts.  The brief output
is nice when everything goes well, but makes the test results
close to useless once a failure happens.

Philippe showed us how GitLab allows CI jobs to preserve
artifacts, so maybe the solution is to move the loads there.

- Cleber.

