Received: from eggs.gnu.org ([2001:4830:134:3::10]:47517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5dku-0004D5-JS
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5dkq-0006LX-KA
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:18:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5dkq-0006Ks-9d
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:18:52 -0400
References: <1508513838-15530-1-git-send-email-gabriel291075@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ed96187-82e5-c6b4-1bd1-14f68b583e24@redhat.com>
Date: Fri, 20 Oct 2017 15:18:48 -0500
MIME-Version: 1.0
In-Reply-To: <1508513838-15530-1-git-send-email-gabriel291075@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O6Edo2e4FR1NiUlBkAB1Sui7527vfCLfG"
Subject: Re: [Qemu-devel] [PATCH v3 01/11] kinetis_k64_uart.h has been added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Augusto Costa <gabriel291075@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O6Edo2e4FR1NiUlBkAB1Sui7527vfCLfG
From: Eric Blake <eblake@redhat.com>
To: Gabriel Augusto Costa <gabriel291075@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <2ed96187-82e5-c6b4-1bd1-14f68b583e24@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/11] kinetis_k64_uart.h has been added
References: <1508513838-15530-1-git-send-email-gabriel291075@gmail.com>
In-Reply-To: <1508513838-15530-1-git-send-email-gabriel291075@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 10:37 AM, Gabriel Augusto Costa wrote:
> I made a new arm machine with some peripherals. The machine is mk64fn1m=
0, a
> cortex-m4 microcontroller from NXP Kinetis family. The machine can run =
a
> simple arm binary file using UART0 in polling mode.
> I have prepared a series of patchs to include this machine:

s/patchs/patches/

> PATCH v3 n/11: It adds the machine and peripherals devices;
> PATCH v4 n/2: It changes the Make files to compile this machine.

Are the last three sentences really useful as part of the git commit
message, or are they comments better directed to a cover letter?
Remember, when sending a series, please include a 0/11 cover letter that
all other messages are in-reply-to, rather than creating 11 separate
top-level threads.

More patch submission tips can be found at:
https://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--O6Edo2e4FR1NiUlBkAB1Sui7527vfCLfG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqWigACgkQp6FrSiUn
Q2rUdQgAoMfuzv111hpLWxglgRTdgfKwWuQmkyXPHNBa4mQI4sx/l/Dhr1e/3fxy
hH6gORL7Qr4Jm/d5m0Ru48V5Ioy2obkwyRBXXipzTMNH3KrWVcY9pXg8yE3RHrdv
D3FOb4pJFradCLX/snT1Vz62Un8u8c4Hb82YgP9T2kvnp2FgPt1IeYTazruQntAN
K7+JIk+krM9KPjXjIwCxzUgVc4A12/lQDUDoFH50e292PKXqZCatKWzbfTZVSZ8E
V+gOJan3FZuBDsTps9twz6spK2EH8ycVugJiiAmXuIIOIbeO+vd9o6zNYBNvbtCz
JldZi0BRukbAjqvtii9JVxqxJadD4A==
=lURM
-----END PGP SIGNATURE-----

--O6Edo2e4FR1NiUlBkAB1Sui7527vfCLfG--
