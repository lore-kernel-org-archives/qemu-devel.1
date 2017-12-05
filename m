Received: from eggs.gnu.org ([2001:4830:134:3::10]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMDm8-0000n8-RX
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMDm3-00070Y-C5
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:00:44 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:38586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eMDm3-00070B-5X
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:00:39 -0500
Received: by mail-wr0-x233.google.com with SMTP id o2so391773wro.5
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 06:00:38 -0800 (PST)
Date: Tue, 5 Dec 2017 14:00:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171205140034.GB29422@stefanha-x1.localdomain>
References: <20171203013037.31978-1-doug16k@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20171203013037.31978-1-doug16k@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] gdbstub: add tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: qemu-devel@nongnu.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 02, 2017 at 08:30:37PM -0500, Doug Gale wrote:
> Signed-off-by: Doug Gale <doug16k@gmail.com>
> ---
> Fix usage of %c in trace output, now uses 0x%02x
> Fix possible sign extended char that could cause 0xfc to say 0xfffffffc
> Add missing traces for hitting breakpoints, continuing, stepping
> Fix incorrect dynamic check for tracing being enabled in hexdump
> Fix missing braces around single line if body
> Fix incorrectly indented return statement
> Fix order of trace-events to be more tidy
>  gdbstub.c    | 113 +++++++++++++++++++++++++++++++++++++++++------------------
>  trace-events |  28 +++++++++++++++
>  2 files changed, 106 insertions(+), 35 deletions(-)

Thanks, since there is no gdbstub.c maintainer I have applied this to my
tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJqaCAAoJEJykq7OBq3PI4koIAKeQ7izoUbU0CYbfZP0AoMfG
xyn11px6KWhY1HZiv6A9J3LWeBZh+IN3oMaRmXA8fwP2VLnd5WPHNvGZSHTnCwAF
mdtRtFCTYbRDe8zesl4Mi+atzZDHzxCOH83t5CEVKDtQZ9LLxSBBtFzOk8xFfru1
/0UK85qbVItjsMMLSDnZspTIOwPxvSKFxPwiNsithdW+87dEhI2O3bNVXiyaCs+h
OevS+ljEtwA+BqBWHHtrQooGuVbYHMbscAI39NW4D+gPP4DynqjrqvkYKytdlixj
I6t7Nhq7aY+OO85asuhTMIXOH4Z+H1wtPgpOmYyozGpjnA69EQHqwnJBSzyFlYQ=
=YUT6
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
