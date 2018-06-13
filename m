Received: from eggs.gnu.org ([2001:4830:134:3::10]:51706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fT8Xc-0000vW-6d
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fT8XZ-0006Gn-26
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:22:36 -0400
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <CAEB3B69-3F9C-451B-9465-AB0C60126285@gmail.com>
Date: Wed, 13 Jun 2018 12:22:29 -0400
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 7/7] mac_newworld: add PMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

+static uint64_t mos6522_pmu_read(void *opaque, hwaddr addr, unsigned =
size)
+{
+    PMUState *s =3D opaque;
+    MOS6522PMUState *mps =3D &s->mos6522_pmu;
+    MOS6522State *ms =3D MOS6522(mps);
+
+    addr =3D (addr >> 9) & 0xf;

This 9 should be replaced with a macro that communicates what this value =
means.=
