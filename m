Received: from eggs.gnu.org ([2001:4830:134:3::10]:45923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UV7-00060B-RH
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UV6-0008Tz-V3
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:53:05 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d0UV6-0008SV-PU
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:53:04 -0400
Received: by mail-wm0-x22b.google.com with SMTP id w64so58575813wma.0
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 07:53:04 -0700 (PDT)
Date: Tue, 18 Apr 2017 15:53:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170418145301.GL21261@stefanha-x1.localdomain>
References: <CAGKXQyfCwbZ3w1bi=TVeSH=ZGx-90JBf+Bn6qqMdkUZTOoWAow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QWRRbczYj8mXuejp"
Content-Disposition: inline
In-Reply-To: <CAGKXQyfCwbZ3w1bi=TVeSH=ZGx-90JBf+Bn6qqMdkUZTOoWAow@mail.gmail.com>
Subject: Re: [Qemu-devel] sleeping in vm live migration code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org


--QWRRbczYj8mXuejp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2017 at 06:13:33PM +0430, ali saeedi wrote:
> why we have below code in vm live migration?
>   * g_usleep((initial_time + BUFFER_DELAY - current_time)*1000);*

It's for migration rate-limiting.  The migration thread throttles itself
if the user has configured a maximum transmission rate for the live
migration connection.

Stefan

--QWRRbczYj8mXuejp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9ihNAAoJEJykq7OBq3PI4IwH/jsGDxCVpR2DVy+o1lkMUM1A
jq93PU6vwVRCFh2DBOMdlf8846LdAeBkFRQN1Sf4lSgKmJDscWV61nTi0rha0I3R
TqojZ+l8cGOJYYo9m4IcYZyeIhONy6qLB4DuYoaDld7+ohg5IBZIXeMnjGaISNbb
rydj5BYbnqzpIx64t4oG9AtAHjXZkBQ1Z51m0kI+WZYR51Q46aVZm4cGElaKl7ad
P5LUTH4nZUNJeqc2phxirvNlfSqNY7IlAMoyHF/RvUYNZgFwM+UWvedjweL+4pJn
nuKaWBxxRBGX2w5K0t/StC7XCGZl4/Wf4Wd5ZPbvht/ybK9R+RMQyQItAdlYH04=
=p09Y
-----END PGP SIGNATURE-----

--QWRRbczYj8mXuejp--
