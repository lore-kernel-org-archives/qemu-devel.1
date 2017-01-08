Received: from eggs.gnu.org ([2001:4830:134:3::10]:49135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cQ2Xp-00014r-G5
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 20:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cQ2Xm-0007uu-DG
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 20:45:13 -0500
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:33535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cardoe@cardoe.com>) id 1cQ2Xm-0007uW-8f
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 20:45:10 -0500
Received: by mail-io0-x231.google.com with SMTP id v96so58710495ioi.0
	for <qemu-devel@nongnu.org>; Sat, 07 Jan 2017 17:45:08 -0800 (PST)
Received: from doug-macbook.local
	(104-179-196-18.lightspeed.brhmal.sbcglobal.net. [104.179.196.18])
	by smtp.googlemail.com with ESMTPSA id
	z12sm28353486ioz.24.2017.01.07.17.45.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 07 Jan 2017 17:45:07 -0800 (PST)
From: Doug Goldstein <cardoe@cardoe.com>
Message-ID: <38337537-d2f4-6933-f4fe-2092247a199d@cardoe.com>
Date: Sat, 7 Jan 2017 19:45:03 -0600
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="wLFgTfdIA1JeEGNoTIFS9siaI1djvLC5H"
Subject: [Qemu-devel] assert hit on master with q35 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wLFgTfdIA1JeEGNoTIFS9siaI1djvLC5H
From: Doug Goldstein <cardoe@cardoe.com>
To: qemu-devel@nongnu.org
Message-ID: <38337537-d2f4-6933-f4fe-2092247a199d@cardoe.com>
Subject: assert hit on master with q35 machine type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm currently hitting an assert on master. I've bisected the change down
to aff8fd18f1786fc5af259a9bc0077727222f51ca but obviously that's a false
positive because that adds the assert for the condition. So obviously
the issue was introduced prior to this. As another data point the issue
only occurs with q35 machines and will only happen with pc-q35-2.7 and
pc-q35-2.8 (and obviously the aliased q35). If I use pc-q35-2.6 it does
not hit.

The message is: qemu-system-x86_64:
/home/doug/work/qemu/hw/virtio/virtio.c:214:
virtio_queue_set_notification: Assertion `vq->notification_disabled > 0'
failed.

But that clearly just shows its the assert that was added in that
commit. To create the machine I use the following command line:

=2E/work/qemu/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -M pc-q35-2.8=

-device intel-iommu -cpu host -m 2048 -smp 2 -drive
if=3Dpflash,format=3Draw,file=3D/tmp/tmp.Sno2BP3saP -global
isa-debugcon.iobase=3D0x402 -debugcon file:/tmp/tmp.KCrwM98Mus -monitor
stdio -chardev socket,host=3D127.0.0.1,port=3D4455,id=3DS0,server,nowait
-device isa-serial,chardev=3DS0 -device piix3-usb-uhci -device usb-tablet=

-netdev id=3Dnet0,type=3Dtap -device virtio-net-pci,netdev=3Dnet0 -boot
order=3Dn -device qxl-vga -gdb tcp::1234

It happens almost right away. Let me know how I can help track this down
further.

Thanks.
--=20
Doug Goldstein


--wLFgTfdIA1JeEGNoTIFS9siaI1djvLC5H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0

iQJ8BAEBCgBmBQJYcZmiXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBNTM5MEQ2RTNFMTkyNzlCNzVDMzIwOTVB
MkJDMDNEQzg3RUQxQkQ0AAoJEKK8A9yH7RvULyMP/RGpUv/CNbX3axLfKAi/65jh
n9U7dnf5qcBtn4ZPamUoscUK+qsq/gOwITyYBdDUZ4dCBB2JBiJYR2xxXxbNVBJd
HYtgDd1xrVqurexVzV+n4N8N6zmJzjM8Cf3sQSKx1OMUZXvnAqIy+3YrtD2jRvZG
J7HvHlY3QlOU1yNlncOHinDvpjcx85+rBCzsPL+nnKeCfLbdmzPlZha9AFEce+nS
3kHA7WhCgdM3zhD4pEeX3p+k6+8Md9MbR5WnMPLVpB3k9SusgdIoNNlMCFCOiO+1
Crcs4Me6iXru45xYVuuGvdoG+15XGMH8YDl1SSTcq5SrJQIx/Bt8uJ0FwyFrHngc
DkQ/vSXXb50YFQKInnjeFmlVnLVCJOa3QRrAEPA2khJDDK7x+x+Ej4cLKiEwQ+5e
j9XIOkKkdYk1L92pmS9ggBXNMHLBo8AOafOXi4NpujFppUTiM+RMr8A1dsKABzlb
Hc/1WCWZZoAntDlq2vHSpVFWEvkapavqSO5CX2QNMo+4QHiD9V7YYc2vSYT6HSc/
EtA9fexqfwAr0nwvICg1VVvL3CczqpKEfLR2HlptgSxQtermssJOJVVQ5oDUzscF
sc4PWVCe46XyOo/+K7oKbBdJu1EcqLhY8tK00qoI4/2xGm+VH+E46KV1Mpd/wRC4
yFiRPuBFOUyxPo3uIIJ0
=5nPC
-----END PGP SIGNATURE-----

--wLFgTfdIA1JeEGNoTIFS9siaI1djvLC5H--
