Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE023C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C777F20896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C777F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2VK-00039r-2V
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hb29I-00069O-6z
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hb29H-0003qQ-7s
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hb29H-0003q3-1r
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA4E7307D864;
 Wed, 12 Jun 2019 12:14:32 +0000 (UTC)
Received: from localhost (unknown [10.36.118.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D32C377B;
 Wed, 12 Jun 2019 12:14:32 +0000 (UTC)
Date: Wed, 12 Jun 2019 13:14:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190612121431.GA19156@stefanha-x1.localdomain>
References: <20190521145318.12787-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20190521145318.12787-1-stefanha@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 12 Jun 2019 12:14:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] build: use $(DESTDIR)x instead of
 $(DESTDIR)/x
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 03:53:18PM +0100, Stefan Hajnoczi wrote:
> The GNU make manual[1] demonstrates $(DESTDIR)$(bindir)/foo and QEMU
> mostly follows that.  There are just a few instances of
> $(DESTDIR)/$(bindir)/foo.  Fix these inconsistencies.
>=20
> [1] https://www.gnu.org/software/make/manual/html_node/DESTDIR.html
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0A7KcACgkQnKSrs4Gr
c8izKAf7B+R0ar1difLPfcF07luJdcvoX94rWrs2baRk054kVqPV4H4+w7rxynEQ
2WWvxn7D6j2KTK3xVwU9pBRXtY0HOxaHoQm58THVbqCNqeWIErDN0xu0OHW0vCX7
adIyGfW0JNczEqg5HD2VX7mbgS+PKZjBjM1CtYox+CBHElpY+5z+svnkngPVJ8VO
ZKsN5lcR5RCB0p3AMkgc1/ar72EFHSAuDDKRAnZ6XsfenqDGnlFcfCckV3HzHdc+
Iy+o7+xwRjbSuEZMSwEjbRfEbKZpAfbYF/rC+eSfWKs5zvprn72IB33wXQxyXokd
EauJs3dnTfMlzeX0KobquxS9sdIW/Q==
=jop7
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

