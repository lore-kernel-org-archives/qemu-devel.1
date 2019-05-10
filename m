Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD6DC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439762173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439762173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP2G2-0004p8-Jl
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:56:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP2Ey-0004LP-UU
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP2Ex-0000rq-PT
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:54:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hP2Ex-0000rH-Jv
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:54:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64C3B3082B46;
	Fri, 10 May 2019 09:54:54 +0000 (UTC)
Received: from localhost (ovpn-117-147.ams2.redhat.com [10.36.117.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9313360C81;
	Fri, 10 May 2019 09:54:48 +0000 (UTC)
Date: Fri, 10 May 2019 10:54:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190510095447.GC22311@stefanha-x1.localdomain>
References: <20190509121820.16294-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20190509121820.16294-1-stefanha@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 10 May 2019 09:54:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/2] security.rst: add Security Guide to
 developer docs
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
	Daniel Berrange <berrange@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 01:18:18PM +0100, Stefan Hajnoczi wrote:
> v3:
>  * Split into security.texi for qemu-doc and secure-coding-practices.rst =
for
>    the developer documentation [danpb]
>  * Mentioned that QEMU can be started as non-root using UNIX groups on
>    /dev/kvm, /dev/net/tun, etc [Alex Bennee]
>  * Kept Acked-by and Reviewed-by since the v3 changes are minor
> v2:
>  * Added mention of passthrough USB and PCI devices [philmd]
>  * Reworded resource limits [philmd]
>  * Added qemu_log_mask(LOG_GUEST_ERROR) [philmd]
>=20
> At KVM Forum 2018 I gave a presentation on security in QEMU:
> https://www.youtube.com/watch?v=3DYAdRf_hwxU8 (video)
> https://vmsplice.net/~stefan/stefanha-kvm-forum-2018.pdf (slides)
>=20
> This patch series extends the QEMU documentation to cover security topics,
> though this is just the beginning and we could flesh it out more in the f=
uture.
>=20
> Stefan Hajnoczi (2):
>   docs: add Secure Coding Practices to developer docs
>   docs: add Security chapter to the documentation
>=20
>  Makefile                               |   2 +-
>  docs/devel/index.rst                   |   1 +
>  docs/devel/secure-coding-practices.rst | 106 ++++++++++++++++++++
>  docs/security.texi                     | 131 +++++++++++++++++++++++++
>  qemu-doc.texi                          |   3 +
>  5 files changed, 242 insertions(+), 1 deletion(-)
>  create mode 100644 docs/devel/secure-coding-practices.rst
>  create mode 100644 docs/security.texi
>=20
> --=20
> 2.21.0
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzVSmcACgkQnKSrs4Gr
c8i0tgf9HrowlLyQqLZHFEayNv+IMUhvMo4vKMTsnVGN8qUBNq8U75EZdgjE2Zkf
zS0EtGUwGynItcBMnkenY1HKhUrmYMgDm3QSbVTf/XEJHg3h3NXPF5SYXOAlGAwn
++lIqPTmD+QCemeodYX92Ba3ide0Ifh4KNQDo+MrmULtw7HeRfL+TQ2B0AP/GQZZ
YfljjMTrRcAMNkkSvE/1XcsoomZzHBLwjgQ6rmTR71R4ZxlAROvGeCpH9vRoSTOX
llgS61Ou+AJc5OhNjjjm47yzqbKKvCeReLilfq/HmkS2Xx6CD0tl/I6v/PWCu7oZ
tfs0N16PE4J8bDvhBVUzYF8CUSVxZg==
=ejiG
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--

