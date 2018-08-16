Received: from eggs.gnu.org ([2001:4830:134:3::10]:44004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqLvP-0004U1-30
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqLvK-0000n4-5z
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:19:07 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:46650 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1fqLvJ-0000mi-Vm
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:19:02 -0400
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
Date: Thu, 16 Aug 2018 13:11:05 -0400
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZydjlvnrC41CumyMtC9kSpSJTnpD0DF6H"
Subject: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZydjlvnrC41CumyMtC9kSpSJTnpD0DF6H
From: Phillip Susi <psusi@ubuntu.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
Subject: Pipe key broken on US keyboards
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello, I recently upgraded my Xen server from Ubuntu 16.04 to 18.04 and
am no longer able to type a | over vnc to the xen vms.  When I press \
it works, but when I hold down shift and press \ which should generate a
|, the vm sees the scan code for some key that the keymap thinks should
sit between left shift and Z, but does not exist on US keyboards, and
that scan code produces a > when combined with shift.  I'm betting it
was this commit that broke it:

commit ab8f9d49d62c82a12409475547e4420a46da56ed
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Wed Jan 17 16:41:15 2018 +0000

    hw: convert ps2 device to keycodemapdb

    Replace the qcode_to_keycode_set1, qcode_to_keycode_set2,
    and qcode_to_keycode_set3 tables with automatically
    generated tables.

Any ideas?

According to xev in the vm, they scan code for \ is 51, and when I hold
down shift, it changes to scan code 94.



--ZydjlvnrC41CumyMtC9kSpSJTnpD0DF6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbdbAsAAoJENsuw7lhAP6E+fwH+gMgMXGzlBgzPTr27+oBjMjJ
/YHhs06q0EPMBKBks6r5nMnBQjBysIaMCI4vhIAubMc46YqhogDagEBWUJvR70uK
jNvlXdiERdq06XsQnO7EXfiYLwrgIX56HnpMiPUnX9+nO12Ax5NhGxGf74lqDjBN
ACXaFj62p4uXXe9CVcInnqNqNID6aDNudVntRpqcnn7AmrE7TApBRBezIiQTMQX0
Zk2je49THLWSiiBZfXML0JqPcLWVE04tb73g3ceSp/n4dB/NRfXodJ7oG1rUPHR7
dcQ4UmKnLeW2/5gDEbHzn5cDjm1B0hLOM3xSEUyNaeYYYEuDKeGXPrQ6nu+h2pk=
=Dgwn
-----END PGP SIGNATURE-----

--ZydjlvnrC41CumyMtC9kSpSJTnpD0DF6H--
