Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5939C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3E4204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3E4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Z03-0002an-3U
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2YyL-0001H2-H4
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2YyJ-0001AU-6S
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:45:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i2YyJ-0001AG-0f
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:45:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E72A510C696B;
 Tue, 27 Aug 2019 10:45:05 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 767991001DC0;
 Tue, 27 Aug 2019 10:45:05 +0000 (UTC)
Date: Tue, 27 Aug 2019 11:45:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jan Bobek <jan.bobek@gmail.com>
Message-ID: <20190827104504.GB4290@stefanha-x1.localdomain>
References: <9d60daf6-f4e3-37cd-799f-9f840b1b7ba1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <9d60daf6-f4e3-37cd-799f-9f840b1b7ba1@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 27 Aug 2019 10:45:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [GSOC] Support for AVX within TCG: Work Product
 Submission
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2019 at 03:30:49PM -0400, Jan Bobek wrote:
> Hi folks,
>=20
> those of you who have been keeping up with Google Summer of Code
> this year might know that it's nearly over -- meaning that it's
> time for me to summarize all the work that I have done as a
> participant. Without further ado, you can find the summary
> attached below.
>=20
> Huge thanks to everyone who made this possible!
>=20
> Best,
> -Jan Bobek

Thanks for your contributions, Jan!

If you have the opportunity to attend KVM Forum 2019 in Lyon, France it
would allow you to meet many members of the QEMU community:
https://events.linuxfoundation.org/events/kvm-forum-2019/

Stefan

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1lCbAACgkQnKSrs4Gr
c8jlywf+Napeh+uvoYFpnRAvKdVvZSI+qc/dpr5qQ9bje+NmD5y5DU1b+LjPryuG
EZnXBWyhNVdPtw6QHKY77qV+E2f+9blOMFIspxF01e9QjM11Z8T6mofs4Viq6Yi4
4DBrOycLH+AOYGsRAn9OuXRR7Ffy9WW24XfcDIQLhKzrdfvu6yHcT6lk5NjZKCaz
jZpM9jkBdH5Cu1YIdK/Njd+ZKTHqrRXC9id3R4t+yDA7yjod50Z1QUaGfQQD/M+e
EKJyj4UCPA4DdO6FfGtnthuEaQskkm7LMa5Zi+bl/88Kwka8hGvb1icnMvjJ4JJw
4zgxsbylI3muy7Bld3o6Y3kJ3H+y2A==
=kq7H
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

