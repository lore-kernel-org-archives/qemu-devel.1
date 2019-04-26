Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E048BC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53492077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53492077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43777 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJxAX-0004XW-ON
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 05:29:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJx8f-0002hR-SG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJwym-00082T-K4
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:17:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hJwyj-0007yq-NG; Fri, 26 Apr 2019 05:17:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C73D83091761;
	Fri, 26 Apr 2019 09:17:08 +0000 (UTC)
Received: from localhost (ovpn-117-222.ams2.redhat.com [10.36.117.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A03411001E81;
	Fri, 26 Apr 2019 09:17:03 +0000 (UTC)
Date: Fri, 26 Apr 2019 10:17:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190426091702.GA2071@stefanha-x1.localdomain>
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 26 Apr 2019 09:17:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
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
	Jim Mussared <jim@groklearning.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Steffen Gortz <qemu.ml@steffen-goertz.de>,
	qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
	Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426091702.GGS6dghy6oTrRDGDgHha9y8nygbcuBw_5QU6VDbc6tM@z>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 08:07:06PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 1/4/19 4:16 PM, Peter Maydell wrote:
> > On Thu, 3 Jan 2019 at 14:41, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> >>
> >> This reverts commit 01fd41ab3fb69971c24a69ed49cde96086d81278.
> >>
> >> The generic loader device (-device loader,file=3Dkernel.bin) can be us=
ed
> >> to load a kernel instead of the -kernel option.  Some boards have flash
> >> memory (pflash) that is set via the -pflash or -drive options.
> >>
> >> Allow starting QEMU without the -kernel option to accommodate these
> >> scenarios.
> >>
> >> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Previous to this commit (v3.1), we have:
>=20
> $ qemu-system-aarch64 -M netduino2
> qemu-system-aarch64: Guest image must be specified (using -kernel)
>=20
> Now (v4.0) we get:
>=20
> $ qemu-system-aarch64 -M netduino2
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

A user-friendly error message is needed here.  The check for -kernel was
too specific and is not desirable for microbit where we use -device
loader.

Old boards probably want to continue using -kernel.  New boards like
microbit may use just -device loader.  Perhaps there is even a group
that wants both options.

A solution is to introduce explicit checks so that we can tell the user
the appropriate option for the machine type.  I can work on this if you
like, but probably won't be able to send a patch until Tuesday.

Stefan

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwsyOAAoJEJykq7OBq3PIxrQH/RvZOjp//Ku7wHbPSH6LRX1g
z7Fhi7/66tL7IDgjvybqRnwV+cH3hIU7bDyOPLK5ec/GHsDrqUlt0FPRXCQZksuo
AeazNW0YoqO+zI+M/JDZ6JXHMUSjnybtCDkC2ZbYpEKAJ0miSlrjIiKKjbKFPGc0
WHNsdPz5/KHvxPyD0lmI+7/MHE6B5YpanYr7V+2kDYW+/WhXT6AU99Ge3LxO4VNn
qC8FP0yRuC5FKHDlhaXw+GldH8sQvv+TUyqODXuBJZY4PF+3DFLhPI7tMizNBERs
yEgn6jGdtxXveA3RCbVkCfmUi9q9RjOY3n7ubxgCM/49EAztdzxNpT73OYr6od0=
=WxRV
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

