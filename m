Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F1BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB8721D56
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB8721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwdj-0000AL-KR
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAwCl-00030b-NN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAwCj-0007QV-FO
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAwCg-0007OV-F9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:10:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB546C053B34;
 Thu, 19 Sep 2019 13:10:32 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA1D60BF1;
 Thu, 19 Sep 2019 13:10:29 +0000 (UTC)
Date: Thu, 19 Sep 2019 14:10:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919131028.GT3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YqKeQn+qkMVHQmbT"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 19 Sep 2019 13:10:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 00/22] Add virtual device fuzzing support
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YqKeQn+qkMVHQmbT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 11:19:27PM +0000, Oleinik, Alexander wrote:
> This series adds a framework for coverage-guided fuzzing of
> virtual-devices. Fuzzing targets are based on qtest and can make use of
> the libqos abstractions.
>=20
> Build instructions in docs/devel/fuzzing.txt
>=20
> V3:
>  * Rebased onto v4.1.0+
>  * Add the fuzzer as a new build-target type in the build-system
>  * Add indirection to qtest client/server communication functions
>  * Remove ramfile and snapshot-based fuzzing support
>  * Add i440fx fuzz-target as a reference for developers.
>  * Add linker-script to assist with fork-based fuzzer

I have done an initial review, mostly skipping Makefile changes.
Thanks!

Stefan

--YqKeQn+qkMVHQmbT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DfkQACgkQnKSrs4Gr
c8gqnggAhF8jSwJj7m6vOaF81yjSmcXeThhhO+W6ffqOzgL08Di4Qr4IrkRnLL/c
lKCoebDltTVoNvEpgTlAMKTRZgEFtvHqZ70KoF7nBEpuaOhjWrDZuTYVv+GdacxR
vF7sI5BvvWxlaU+8MgxX97pnPUBL4kn/tymoqY5H6nGPZ8y8XMNWO7Kevi47+tiZ
TRicGOPN24YfmIGdXYYxz9cOAwKa3oHmQrskOw9lh3Aim0kU7dTCvUbmYqjxGdph
JcCRnSFlrUbRZ2vXaj7tFcNDLj19MZPMzg9Dcc7ZMOhs973+u/JIkaxLKtDRbZAI
EzXZLF8eGF7HUt7TGqeHR4I0TthGGA==
=F6TD
-----END PGP SIGNATURE-----

--YqKeQn+qkMVHQmbT--

