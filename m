Received: from eggs.gnu.org ([2001:4830:134:3::10]:47842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da09H-0003m0-Qa
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da09E-0000NX-MR
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:45:19 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da09E-0000Mv-FX
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:45:16 -0400
Received: by mail-wm0-x229.google.com with SMTP id m85so42708551wma.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:45:16 -0700 (PDT)
Date: Tue, 25 Jul 2017 14:45:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725134512.GF23343@stefanha-x1.localdomain>
References: <20170724124438.27344-1-apahim@redhat.com>
	<20170724124438.27344-3-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <20170724124438.27344-3-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] qemu.py: cleanup and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com, famz@redhat.com


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 02:44:38PM +0200, Amador Pahim wrote:
> is_running():
> - Use Popen.poll() instead of Popen.returncode to check whether
>   the VM is running or not.
>=20
> exitcode():
> - Use Popen.poll() instead of Popen.returncode to return an updated
> exit code.
>=20
> _load_io_log():
> - Add a try/except to prevent raising exception when qemu io file
> does not exist.
>=20
> launch():
> - If VM is already running, do nothing.
> - If vm is not running but was not cleaned up, call shutdown()
>   before launching again.
> - Offload the core of this method to _launch().
> - Load the args and try to call _launch().
> - Make sure we cleanup on exception.
> - On exception, print an error message with the qemu command line
>   and output.
>=20
> _launch():
> - Execute _pre_launch(), subprocess.Popen() and self._post_launch().
> - No try/except here. Any exceptions will be handled by the caller.
>=20
> shutdown():
> - Make sure self._popen is not None before calling self._popen.wait().
> - Cleanup the message on negative exit codes.
> - Always execute self._load_io_log() and self._post_shutdown().
>=20
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Please break this up into logical changes and include the rationale for
making them.  The commit description should explain "why" rather than
"what" the code change is.

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd0toAAoJEJykq7OBq3PIChYH+wXYWOEOsSfpI/lfJHXJcsss
YR/VkUbxv9BwI64YPIBu+Kw3arZdeBwkzvmBamnq0Eavm/DjeZQ1CeX7lqPdFhJm
OQY4EjWrxdWiYeGWcKZycUBVUolXs0N7sMgdC6Cr3/ET7oSkvNOpoLV1YUfCJoh5
bSGQvDHGlqEGN7q4P+K7qyOIOA3kYEhIZsGo2Rc6gliLDj2EVJNABYJV2a8tvsZi
GKXt6Zsee+8kTkSfUkYpu+dzVU8CraKGqYjuSHaNoaxkK9eDAfanabV3roMIAyTR
V9B3LV5WRsRjq/XJsIYzyLZSe7y89WEuJMk/aKcO+MpnYHRneeLPysZGjzvRK0M=
=OwaD
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
