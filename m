Received: from eggs.gnu.org ([2001:4830:134:3::10]:42433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX1yH-0000J2-1X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX1yD-00050x-Jy
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:05:40 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dX1yC-0004zb-VU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:05:37 -0400
Received: by mail-wm0-x22c.google.com with SMTP id b134so40806225wma.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 02:05:35 -0700 (PDT)
Date: Mon, 17 Jul 2017 10:05:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170717090531.GA7163@stefanha-x1.localdomain>
References: <20170717063521.GA7393@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20170717063521.GA7393@lemon>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2017 at 02:35:21PM +0800, Fam Zheng wrote:
> Q1: In the worst case, you get four individual auto replies from patchew. Is
> that too many? Do you prefer one reply with all the results concatenated into
> one?

I'd like to avoid situations where one of the failure emails is sent
hours after the others, because it's possible that the patch series
author has already sent the next (still broken) revision by that time.
The simplest way to avoid that is by sending just one email.

> Q2: Some think the full log in the mail body is more than necessary. Is it
> better or worse if it is a "tail -n 200" of the log in the body and the full log
> attached?

tail output and a link to the full logs would be nice.  Often there is a
lot of irrelevant output.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbH3bAAoJEJykq7OBq3PIbPwIAJCrlY/7YZXz/0yidA/StUhx
CDz7l7aKP1nbx+XxUz3Ufom8vMnQqFL0AMHnUS1jVMdwihQwmUGYXFLgWPEPFjGR
5e5fAM3fkOzoeL2HpAMM/ADyxyAWqOj/Wser/UWKydsSvKvUC70PLWebgA130IH9
9c+hvf8ns0T2aLwm/gdR7EnOYAR36ZpDJq2wM/A0zY0ctYbtX/H1tlha7ap2vdhT
vqM5E82NHd702fw5X+fxEqTZy/M7msfjBGAHPF8s/eJx85K6Z61FsoyK0P4ONvfb
FiU3gFODWuJB8eaJOqQ16g+EWTzve9EWeHXvYDd/ul+woaSMnySgjey8D92R7u0=
=BEng
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
