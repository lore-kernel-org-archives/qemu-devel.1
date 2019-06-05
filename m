Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EB8C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0836A20866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0836A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49471 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcdK-0003MD-Tl
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:35:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYcbq-0002SV-PY
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYcbo-0005JX-4i
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:34:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hYcbg-00051d-7y; Wed, 05 Jun 2019 16:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D8377E422;
	Wed,  5 Jun 2019 20:33:50 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9798D619A9;
	Wed,  5 Jun 2019 20:33:37 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:33:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190605203335.GE22416@habkost.net>
References: <20190312234541.2887-1-philmd@redhat.com>
	<20190312234541.2887-3-philmd@redhat.com>
	<20190522205234.GY10764@habkost.net>
	<1204725743.24201394.1558559144548.JavaMail.zimbra@redhat.com>
	<1088d160-20c1-00ed-b494-fede1a3a8410@redhat.com>
	<1894627419.24355320.1558618806274.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1894627419.24355320.1558618806274.JavaMail.zimbra@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 05 Jun 2019 20:33:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 09:40:06AM -0400, Cleber Rosa wrote:
> ----- Original Message -----
> > From: "Philippe Mathieu-Daud=E9" <philmd@redhat.com>
> > To: "Cleber Rosa" <crosa@redhat.com>, "Eduardo Habkost" <ehabkost@red=
hat.com>
> > Cc: qemu-devel@nongnu.org, "Peter Maydell" <peter.maydell@linaro.org>=
, qemu-arm@nongnu.org, "Philippe Mathieu-Daud=E9"
> > <f4bug@amsat.org>, "Andrew Baumann" <Andrew.Baumann@microsoft.com>, "=
Gerd Hoffmann" <kraxel@redhat.com>
> > Sent: Thursday, May 23, 2019 5:29:22 AM
> > Subject: Re: [Qemu-devel] [PATCH v2 2/2] Boot Linux Console Test: add=
 a test for the Raspberry Pi 2
> >=20
> > On 5/22/19 11:05 PM, Cleber Rosa wrote:
> > > ----- Original Message -----
> > >> From: "Eduardo Habkost" <ehabkost@redhat.com>
> > >> On Wed, Mar 13, 2019 at 12:45:41AM +0100, Philippe Mathieu-Daud=E9=
 wrote:
> > >>> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > >>>
> > >>> Similar to the x86_64/pc test, it boots a Linux kernel on a raspi=
2
> > >>> board and verify the serial is working.
> > >>>
> > >>> If ARM is a target being built, "make check-acceptance" will
> > >>> automatically include this test by the use of the "arch:arm" tags=
.
> > >>>
> > >>> Alternatively, this test can be run using:
> > >>>
> > >>>     $ avocado run -t arch:arm tests/acceptance
> > >>>     $ avocado run -t machine:raspi2 tests/acceptance
> > >>>
> > >>> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > >>
> > >> We're getting timeouts on travis-ci:
> > >> https://travis-ci.org/ehabkost/qemu/jobs/535468057#L3289
> > >>
> > >> I don't know yet if the guest is hanging, or if we just need to
> > >> increase the timeout.  I could reproduce the timeout locally,
> > >> too.
> >=20
> > That's odd, I can't reproduce (this test is quicker than the followin=
g
> > test_arm_emcraft_sf2 which start u-boot then timeouts and start the k=
ernel).
> >=20
> > My guess is network issues, since this test use a different mirror:
> > archive.raspberrypi.org
> >=20
>=20
> It could be a network issue, it could be something else.  I think the v=
ery
> first step, and I'd urge us to get that on master ASAP, is to show the
> entire logs in CI, I mean:
>=20
> ---
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 6fd89b3d91..fd8f6ca2d2 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -225,7 +225,7 @@ matrix:
>      # Acceptance (Functional) tests
>      - env:
>          - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-=
softmmu,alpha-softmmu"
> -        - TEST_CMD=3D"make check-acceptance"
> +        - TEST_CMD=3D"make AVOCADO_SHOW=3Dtest check-acceptance"
>        addons:
>          apt:
>            packages:

I have applied this change on python-next.  The failure can be
seen here:
https://travis-ci.org/ehabkost/qemu/jobs/541758418#L4033

While we don't fix this, I'm removing this test case from the
queue, so I can send a pull request.  Sorry for taking so long to
act on this.

--=20
Eduardo

