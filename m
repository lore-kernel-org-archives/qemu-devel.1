Received: from eggs.gnu.org ([2001:4830:134:3::10]:57950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhaOy-0007mV-Sd
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhaOe-0007KE-Rh
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:52:52 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dhaOe-0007HY-Ky
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:52:32 -0400
Received: by mail-wm0-x235.google.com with SMTP id t201so7139759wmt.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 04:52:32 -0700 (PDT)
Date: Tue, 15 Aug 2017 12:52:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170815115229.GB22606@stefanha-x1.localdomain>
References: <20170815084430.7128-1-stefanha@redhat.com>
	<150278758924.78.16068223215275870985@dd743fd916bd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <150278758924.78.16068223215275870985@dd743fd916bd>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 0/2] trace: fix simpletrace.stp
 flight recorder mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2017 at 01:59:50AM -0700, no-reply@patchew.org wrote:
> Checking PATCH 2/2: simpletrace: fix flight recorder --no-header option...
> ERROR: line over 90 characters
> #40: FILE: scripts/simpletrace.py:101:
> +    """Deserialize trace records from a file, yielding record tuples (event_num, timestamp, pid, arg1, ..., arg6).

This line was not modified, so it wasn't introduced by this patch
series.  I think the reason it's a single line is because Python
docstrings must start with a single line.

Stefan

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZkuB9AAoJEJykq7OBq3PIguMH/0641P2+ltBAtnECQP6ISGhD
0QNuuREW4qGWq2wKHeCNpKA8XGVQKExhdqdCqiIfT1JdWUK6aK9sN4buWUhY0TNN
L2qbvE+qHqJlPJymjDgTYrq5ZohsCcjHiOZhZ2girHCRHXhIUBc+RXcY7mqlYcpP
H5YTxudwffAPP6VerjBNSUol2e9XAnQceeZcgBOaifjP9bFbT7+RjZtD4eCDb+31
pyMFUt3ut3zWJBe/rrwU/61TPurI4kkO0+HmxnojpwXgBu/et/KpEUoWnVIYFl1V
WIxpxEQUc2FOcm+kIOBc27PJx7v6X5ENNBnHz73JP+ZgMoHI5paYGoxkpQpJwAo=
=RlNA
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
