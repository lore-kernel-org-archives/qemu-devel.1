Received: from eggs.gnu.org ([2001:4830:134:3::10]:53551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdGqN-0004cj-9M
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdGqJ-00052f-9z
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:15:51 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdGqJ-00052M-2w
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:15:47 -0400
Received: by mail-wm0-x242.google.com with SMTP id s14-v6so2989286wmc.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 08:15:46 -0700 (PDT)
Date: Wed, 11 Jul 2018 16:15:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711151544.GQ31228@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-8-e.emanuelegiuseppe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rUztinBX/EQDJOOk"
Content-Disposition: inline
In-Reply-To: <20180709091136.28849-8-e.emanuelegiuseppe@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] tests/qgraph: sdhci test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--rUztinBX/EQDJOOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 11:11:36AM +0200, Emanuele Giuseppe Esposito wrote:
> +/**
> + * Old sdhci_t structure:

Do you intend to delete this comment before this series is merged?  It
seems like a TODO that doesn't need to be kept around.

> +    qos_add_test("sdhci-test", "sdhci", test_machine);

How does this work for tests that need access to more than 1 device?
Can they request a driver instance via the API?

--rUztinBX/EQDJOOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRh8gAAoJEJykq7OBq3PIdugIALyLq11VeOW/E05WznyGopSp
bJSOEU0AkQ7/BQNX0IJXxkokGR+T4J1duF6YVVg0LREmXPWnl/q6+rw54IvfqIJl
NiD6mO115fC8XmAOhezO7hPdLJdDyWd2NJxKBfpRp/C9K78ddG3cBFIQHpWRUQQv
QFhek04+cWVAjUa8QJnqKXtftqESu8mOIPPFZZHB7ajx0iYydZucYTrsgLgtAEwN
i3CXhCqS9TMd4k12oCFgmMKGIWhSbS9mq2y4jk5EYYlrPXewCRumO78M+KZsX8xG
BOsDSIZr2pjdQPN6/stjaXbj5YuYH3y79rl/IKQHV5yCCmvjx/PRsk7+8F0mE/4=
=UvbM
-----END PGP SIGNATURE-----

--rUztinBX/EQDJOOk--
