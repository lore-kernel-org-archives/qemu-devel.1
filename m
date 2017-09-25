Received: from eggs.gnu.org ([2001:4830:134:3::10]:40179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1dwSF0-0007e2-JB
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1dwSEz-0005OC-MR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:12:02 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::8]:26610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1dwSEz-0005Ms-CC
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:12:01 -0400
Date: Mon, 25 Sep 2017 14:11:55 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20170925121155.GC9523@aepfle.de>
References: <alpine.DEB.2.10.1709201906040.2968@sstabellini-ThinkPad-X260>
	<1505960544-12202-1-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <1505960544-12202-1-git-send-email-sstabellini@kernel.org>
Subject: Re: [Qemu-devel] [PULL 1/2] xen-disk: use g_new0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: peter.maydell@linaro.org, stefanha@gmail.com, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Sep 20, Stefano Stabellini wrote:

> From: Olaf Hering <olaf@aepfle.de>
> g_malloc0_n is available since glib-2.24. To allow build with older glib
> versions use the generic g_new0, which is already used in many other
> places in the code.
> Fixes commit 3284fad728 ("xen-disk: add support for multi-page shared rings")

In case this missed the release, please backport to the relevant stable
branches as well. Many thanks.

Olaf

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWcjyiwAKCRBdQqD6ppg2
fs1xAJ4oefhiHcJd10elImrk3tUqsJ8+PQCg+RjdxswsVRtq3crhELGaHV6pr+c=
=ToT0
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
