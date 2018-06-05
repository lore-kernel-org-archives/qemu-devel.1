Received: from eggs.gnu.org ([2001:4830:134:3::10]:58451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQAO6-0006Qk-Ut
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQAO6-0008SB-8N
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:31 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQAO6-0008Ro-12
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:30 -0400
Received: by mail-wr0-x242.google.com with SMTP id w10-v6so2063849wrk.9
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 04:44:29 -0700 (PDT)
Date: Tue, 5 Jun 2018 12:44:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180605114427.GH11888@stefanha-x1.localdomain>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<1527840629-18648-7-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bpVaumkpfGNUagdU"
Content-Disposition: inline
In-Reply-To: <1527840629-18648-7-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH V6 6/7] migration/ram: Add check and info
 message to nvdimm post copy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--bpVaumkpfGNUagdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 04:10:28PM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
>=20
> The nvdimm kind memory does not support post copy now.
> We disable post copy if we have nvdimm memory and print some
> log hint to user.
>=20
> Signed-off-by: Junyan He <junyan.he@intel.com>
> ---
>  migration/ram.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bpVaumkpfGNUagdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFnebAAoJEJykq7OBq3PIoeUH/05fCqd7LsW8t0v4KLpzfmiT
dJizYHSgtrfTGZklr29S7/bTa6yJdX1w6f0cKjJN81jssBy3BBVkummCvEx2peNj
ryUQbyfJ16JUfK3A3Bf3/5tV9M80FgBtykhE+Tv1Zx7rjJm3EXf69aQiCqrgH9cd
4ATsceL4zI8Dk5CCJBZLecegVBKx8rEOmSY8M1tvq4LvFYzpMnL0swKciN4GXJUs
ekOSa+jKfcE+6LsCKU+822+FJyjQL1WwFdLntIFbxVCMA+vUZpN1Nc1pWx4Pa+gz
glbs8Ze/t8ItKbz8efKrWhVRLAyN3GGwBowEreffgGDoMyGUCc5+WLf1OZwuhgE=
=uLhB
-----END PGP SIGNATURE-----

--bpVaumkpfGNUagdU--
