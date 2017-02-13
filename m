Received: from eggs.gnu.org ([2001:4830:134:3::10]:59601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHaW-0006gU-V6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHaU-0004VP-DC
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:26:44 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdHaU-0004V4-7C
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:26:42 -0500
Received: by mail-wr0-x242.google.com with SMTP id k90so24317377wrc.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 06:26:42 -0800 (PST)
Date: Mon, 13 Feb 2017 14:26:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213142638.GI10361@stefanha-x1.localdomain>
References: <20170207100302.3995.67911.malonedeb@chaenomeles.canonical.com>
	<20170207232226.5557.42629.malone@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Content-Disposition: inline
In-Reply-To: <20170207232226.5557.42629.malone@wampee.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1662468] Re: [feature request] qemu-img
 convert should respond to control-T like dd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <1662468@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 11:22:26PM -0000, Max Reitz wrote:
> That should be simple enough to implement considering we have this
> behavior already on SIGUSR1. Unfortunately, I wouldn't be able to test
> it because Linux apparently doesn't implement SIGINFO...
>=20
> Max
>=20
>=20
> PS: By the way, thanks for the information. I didn't know about SIGINFO a=
t all. Well, now I have mapped Ctrl-T to SIGUSR1 in my terminal emulator so=
 I don't have to feel quite as inferior...

Christophe: In case you hadn't seen what Max is referring to on the
qemu-img man page:

  -p  display progress bar (compare, convert and rebase commands
      only).  If the -p option is not used for a command that supports
      it, the progress is reported when the process receives a
      "SIGUSR1" signal.

Does this do what you want?

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYocIeAAoJEJykq7OBq3PIIJoH/3/Ogf0VaSmXe62d1YBlIgS+
NTOHKfQ+MWHww4nAFIfe3/RUDqAGnbZNmpHZ0tsD9Nw57ioIFHbjSUec9ZHlih39
CCW7770jLiC6knVsHfCPhr272YeSDVzzh1kZ45wqbkuoyM20GcU6q5dFNzWcpoW2
XthJSfANLbU8/g89jCFmAQwqxpE21hyd3mmMNYcHVlwGR2L18szTEteV5Rft9hWr
j8qPv2lK4DxFHPHFd5xmYTmYE8BM7NyAgQHvkyF+wnW0c5mfs4gpidK8v1OM/FED
fkYjoriTQj6cRN3eJOQvwJrsPqaA2MULOAvTple8QrKL7fRtewSb0eMXPXQbT8k=
=//iy
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--
