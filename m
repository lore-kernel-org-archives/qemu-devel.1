Received: from eggs.gnu.org ([2001:4830:134:3::10]:46746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpyOH-0006ni-5O
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpyOD-0002nA-8C
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:34:33 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cpyOD-0002ms-1Y
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:34:29 -0400
Received: by mail-wm0-x243.google.com with SMTP id z133so14950236wmb.2
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:34:28 -0700 (PDT)
Date: Mon, 20 Mar 2017 14:34:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320143425.GC17887@stefanha-x1.localdomain>
References: <1490002022-22653-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+b2GFy/wpzNn/yIF"
Content-Disposition: inline
In-Reply-To: <1490002022-22653-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] parallels: fix default options parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: stefanha@redhat.com, Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>


--+b2GFy/wpzNn/yIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 12:27:02PM +0300, Denis V. Lunev wrote:
> From: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>
>=20
> parallels block driver is completely broken since commit
>     commit 75cdcd1553e74b5edc58aed23e3b2da8dabb1876
>     Author: Markus Armbruster <armbru@redhat.com>
>     Date:   Tue Feb 21 21:14:08 2017 +0100
>     option: Fix checking of sizes for overflow and trailing crap
> Right now even simple
>     qemu-io -c "read 512 64k" 1.hds
> ends up with
>     Unexpected error in parse_option_size() at util/qemu-option.c:188:
>     Parameter 'prealloc-size' expects a non-negative number below 2^64
>     Aborted (core dumped)
> The cure is simple - we should use 'M' as a suffix in default option value
> instead of 'MiB'.
>=20
> Signed-off-by: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/parallels.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--+b2GFy/wpzNn/yIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz+hxAAoJEJykq7OBq3PIvn0H/jW88DzULVVnofZ++qMFAcqJ
JyG8xQ+AnvvpboJ3Op/JgPF3F62MySIia8y75SofTZkkVADbnZ1B2X3rBh7on6iY
Z5p/Emwjy11U1Wv0Rywl17uFUG7QyX2WKiBjlXH3CSDH0Hd3gbyyVVfPXiAKV3td
vr20vHPlvPfrkFa2TQlBCE4ectJYPiv+jocnirBoYEHdZ96X2vOl8s4scMAeMmNv
habvpb8OqsshRD3OKS1FjOCFhIfMZ7hpee3MDjvmq8MzG7hEJAPzAugiDpzBAETs
bKJfoISdp1r7l2ypLA9sjr3GdmZ2YB1Z9InBMInvoLa6gK9/yfKTicZjML/0PSI=
=wJc+
-----END PGP SIGNATURE-----

--+b2GFy/wpzNn/yIF--
