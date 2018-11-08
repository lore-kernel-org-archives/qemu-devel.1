Received: from eggs.gnu.org ([2001:4830:134:3::10]:47600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKhos-0002Pm-Eb
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKhon-0002jN-Hk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:45:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gKhol-0002L9-JB
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:45:43 -0500
Date: Thu, 8 Nov 2018 10:45:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181108104520.GF17083@stefanha-x1.localdomain>
References: <20181105104524.933-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <20181105104524.933-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v3] tests/microbit-test: Check nRF51 UART
 functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2018 at 01:45:24PM +0300, Julia Suvorova wrote:
> +    writel(NRF51_UART_BASE + A_UART_SUSPEND, 0x01);
> +    writel(NRF51_UART_BASE + A_UART_TXD, 'h');
> +    writel(NRF51_UART_BASE + A_UART_STARTTX, 0x01);
> +    w_to_txd("world");
> +    g_assert(read(sock_fd, s, 10) == 5);
> +    g_assert(strcmp(s, "world") == 0);

Please use memcmp(3) instead.  A broken QEMU could send non-NUL
terminated data and strcmp(3) would go beyond the end of s[].

(I haven't looked back to see if s[6..9] was previously initialized to
'\0' but it's cleaner if the code makes it obvious that there is no bug
here.)

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb5BPAAAoJEJykq7OBq3PIgqgIAMQcdllTOgcgAUF7I1/PwfJC
C/mzHj5XPXtMe+qCx42PGSsSZrr8hB7jfjWROyqiXAjahfOz5+rWgRQ7cgwN/XMM
tyj0xiu6+TMuv/z9sFjYTQyLLVYNwNWiLIkFn1EHB3zhkM0ykKSGNJFICGS6U4kJ
q7M76sRNseWz9eMX7xiXfYKO/NIEOhhFuIy2hQZ6CaCAgauryh2I6H8c3KIkCFcu
HJqkW2gW08W2iG/O4f7n5X8ljozilY7G97MNy2ECKoNGZId8StZPCIzn00kSCCdz
OU2yY8NxzOZl1wCBRTZytymdATfsy+0a7aCM3uxfTMUKX5V/1vPcd5/5STp1wEs=
=BRcF
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
