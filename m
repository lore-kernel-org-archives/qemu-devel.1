Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC15C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E486C20868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E486C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36766 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTo8N-0007m5-7P
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:51:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hTnx8-0008FI-Sd
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hTnx6-0001cr-Tc
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:40:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>)
	id 1hTnx4-0001ag-1t; Thu, 23 May 2019 09:40:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5775C309B165;
	Thu, 23 May 2019 13:40:09 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BC7B5C69A;
	Thu, 23 May 2019 13:40:09 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 386CF1806B13;
	Thu, 23 May 2019 13:40:09 +0000 (UTC)
Date: Thu, 23 May 2019 09:40:06 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <1894627419.24355320.1558618806274.JavaMail.zimbra@redhat.com>
In-Reply-To: <1088d160-20c1-00ed-b494-fede1a3a8410@redhat.com>
References: <20190312234541.2887-1-philmd@redhat.com>
	<20190312234541.2887-3-philmd@redhat.com>
	<20190522205234.GY10764@habkost.net>
	<1204725743.24201394.1558559144548.JavaMail.zimbra@redhat.com>
	<1088d160-20c1-00ed-b494-fede1a3a8410@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.36.116.137, 10.4.195.29]
Thread-Topic: Boot Linux Console Test: add a test for the Raspberry Pi 2
Thread-Index: cTKA5go+WjGllWYQUczyegVNXSeSlQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 23 May 2019 13:40:09 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> To: "Cleber Rosa" <crosa@redhat.com>, "Eduardo Habkost" <ehabkost@redhat.=
com>
> Cc: qemu-devel@nongnu.org, "Peter Maydell" <peter.maydell@linaro.org>, qe=
mu-arm@nongnu.org, "Philippe Mathieu-Daud=C3=A9"
> <f4bug@amsat.org>, "Andrew Baumann" <Andrew.Baumann@microsoft.com>, "Gerd=
 Hoffmann" <kraxel@redhat.com>
> Sent: Thursday, May 23, 2019 5:29:22 AM
> Subject: Re: [Qemu-devel] [PATCH v2 2/2] Boot Linux Console Test: add a t=
est for the Raspberry Pi 2
>=20
> On 5/22/19 11:05 PM, Cleber Rosa wrote:
> > ----- Original Message -----
> >> From: "Eduardo Habkost" <ehabkost@redhat.com>
> >> On Wed, Mar 13, 2019 at 12:45:41AM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
> >>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>
> >>> Similar to the x86_64/pc test, it boots a Linux kernel on a raspi2
> >>> board and verify the serial is working.
> >>>
> >>> If ARM is a target being built, "make check-acceptance" will
> >>> automatically include this test by the use of the "arch:arm" tags.
> >>>
> >>> Alternatively, this test can be run using:
> >>>
> >>>     $ avocado run -t arch:arm tests/acceptance
> >>>     $ avocado run -t machine:raspi2 tests/acceptance
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>
> >> We're getting timeouts on travis-ci:
> >> https://travis-ci.org/ehabkost/qemu/jobs/535468057#L3289
> >>
> >> I don't know yet if the guest is hanging, or if we just need to
> >> increase the timeout.  I could reproduce the timeout locally,
> >> too.
>=20
> That's odd, I can't reproduce (this test is quicker than the following
> test_arm_emcraft_sf2 which start u-boot then timeouts and start the kerne=
l).
>=20
> My guess is network issues, since this test use a different mirror:
> archive.raspberrypi.org
>=20

It could be a network issue, it could be something else.  I think the very
first step, and I'd urge us to get that on master ASAP, is to show the
entire logs in CI, I mean:

---

diff --git a/.travis.yml b/.travis.yml
index 6fd89b3d91..fd8f6ca2d2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -225,7 +225,7 @@ matrix:
     # Acceptance (Functional) tests
     - env:
         - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-sof=
tmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmm=
u,alpha-softmmu"
-        - TEST_CMD=3D"make check-acceptance"
+        - TEST_CMD=3D"make AVOCADO_SHOW=3Dtest check-acceptance"
       addons:
         apt:
           packages:

---

That way we can know for sure what's going on.=20

> Gerd already raised this problem (timeout reached while fetching
> artifacts) to Cleber.
> Cleber, can we add test_setup() methods that use different timeouts?
>=20

Not in a released Avocado version.  Interestingly enough, I wrote a PoC
that adds different timeouts to tearDown()[1], that can be used the same
way for setUp(), and it looks like Intel DAOS is already using those
patches[2].

So, I guess I can work on a non-PoC version for that.

- Cleber.

[1] - https://github.com/avocado-framework/avocado/pull/3076
[2] - https://github.com/daos-stack/daos/commit/084ec23461e7bd9b997d4b6f5e8=
095a4eaffc685

> Regards,
>=20
> Phil.
>=20
> > It may be related to:
> >=20
> >  https://bugs.launchpad.net/qemu/+bug/1829779
> >=20
> > And this is a proof that we urgently need to have a better
> > way of presenting/storing test artifacts.  The brief output
> > is nice when everything goes well, but makes the test results
> > close to useless once a failure happens.
> >=20
> > Philippe showed us how GitLab allows CI jobs to preserve
> > artifacts, so maybe the solution is to move the loads there.
> >=20
> > - Cleber.
> >=20
>=20

