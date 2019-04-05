Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B56C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F52C20652
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F52C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39599 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCMAQ-0006xG-Cd
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 06:33:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hCM9a-0006bv-0m
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hCM9Z-0007Ue-38
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:32:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hCM9V-0007Km-CV; Fri, 05 Apr 2019 06:32:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F297C308FED2;
	Fri,  5 Apr 2019 10:32:50 +0000 (UTC)
Received: from localhost (ovpn-117-172.ams2.redhat.com [10.36.117.172])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DF4C026546;
	Fri,  5 Apr 2019 10:32:48 +0000 (UTC)
Date: Fri, 5 Apr 2019 11:32:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190405103247.GG25152@stefanha-x1.localdomain>
References: <20190328182810.21497-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kadn00tgSopKmJ1H"
Content-Disposition: inline
In-Reply-To: <20190328182810.21497-1-kwolf@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 05 Apr 2019 10:32:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] file-posix:
 query-qemu-features for auto-read-only
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405103247.JXaRN8WN8GWr-CwKbWkCT0Bds2KrCnFr-Rvmepx7NuY@z>


--kadn00tgSopKmJ1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2019 at 07:28:08PM +0100, Kevin Wolf wrote:
> auto-read-only=3Don changed its behaviour in file-posix for the 4.0
> release. This change cannot be detected through the usual mechanisms
> like schema introspection.
>=20
> I took Stefan's patch 'qmp: add query-qemu-capabilities', removed the
> feature that he originally wanted this for and addressed the review
> comments. The introduction of the file-posix-dynamic-auto-read-only
> feature is a separate patch.
>=20
> Stefan, I kept you as the author of the first patch and also your
> Signed-off-by. Is this okay with you or would you prefer a change?

Sorry I was unresponsive.  I'm fine with the authorship and
Signed-off-by: but won't be offended if either or both are removed when
the patch is reworked (my code is trivial).

Stefan

--kadn00tgSopKmJ1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJcpy7PAAoJEJykq7OBq3PIq28H9i8gw8+Ff/dAJQ8MWHiX8Yja
23Y9Z0Fvv8iMkEMxDKvNX8Datf/FrUIVSwJSbY1AYmdEWtR6gYcZpp3UARlr5xJ7
iGjrFqJW2dxGdzgay7M8MSVivTQwCZVuDhYVNJ++7CWYozpC3H5T1G/rD4j28ttA
LdLoaLOAu2tVD7IEA1qaCowJ3k0SM59vFVnQsK0nKHCSU1E4RR63hM/cK9+hOoeC
C+SSzp+HcBTi0KIb/tBecY/1jQGN3eJ2ZgCeZd7e0XebVg7EwDCvuPOc3SiJb08R
YCr7aOBcHuO5X6N7i1riEBvOp2uKwyREY6L+EffPUF137hxvLWWcNDGQaKyItw==
=GC5L
-----END PGP SIGNATURE-----

--kadn00tgSopKmJ1H--

