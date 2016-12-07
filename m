Received: from eggs.gnu.org ([2001:4830:134:3::10]:52291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cEcyq-0002xD-Q8
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cEcyl-0008CF-Qz
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:13:56 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:49026
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cEcyl-0008C0-HC
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:13:51 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7E8Ydb091068
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 09:13:50 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276jhh5k4a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 09:13:50 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 07:13:48 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20161207140733.3613.57602@loki>
References: <20161207140733.3613.57602@loki>
Date: Wed, 07 Dec 2016 08:13:27 -0600
Message-Id: <20161207141327.3613.89015@loki>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.8.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

Quoting Michael Roth (2016-12-07 08:07:33)
> Hello,
> =

> On behalf of the QEMU Team, I'd like to announce the availability of the
> fourth release candidate for the QEMU 2.8 release.  This release is meant
> for testing purposes and should not be used in a production environment.
> =

> http://wiki.qemu.org/download/qemu-2.8.0-rc3.tar.bz2
> =

> Barring the discovery of any major issues, this is the last planned RC
> before the release of QEMU 2.8, so your testing is greatly appreciated.
> =

> You can help improve the quality of the QEMU 2.8 release by testing this
> release and reporting bugs on Launchpad or directly to the mailing list:
> =

> https://bugs.launchpad.net/qemu/
> =

> The release plan, as well a documented known issues for release
> candidates, are available at:
> =

> http://wiki.qemu.org/Planning/2.8
> =

> Please add entries to the ChangeLog for the 2.8 release below:
> =

> http://wiki.qemu.org/ChangeLog/2.8
> =

> Changes since rc1:

Sorry, I neglected to include the changes since rc2. Please see them
below:

Changes since rc2:

a92f7fe: Update version for v2.8.0-rc3 release (Stefan Hajnoczi)
4230e5d: qapi: Document introduction of gluster's 'debug' option (Eric Blak=
e)
a9353fe: exec.c: Fix breakpoint invalidation race (Peter Maydell)
d750c3a: qapi: Document DEVICE_TRAY_MOVED addition (Eric Blake)
b5b7b5d: tests/.gitignore: Ignore test-char (Changlong Xie)
a3e1505: qcow2: Don't strand clusters near 2G intervals during commit (Eric=
 Blake)
9f5832d: fsl_etsec: Fix various small problems in hexdump code (Andrey Smir=
nov)
76b5550: qemu-doc: update gluster protocol usage guide (Prasanna Kumar Kale=
ver)
7103d91: block/nfs: fix QMP to match debug option (Prasanna Kumar Kalever)
1a417e4: block/gluster: fix QMP to match debug option (Prasanna Kumar Kalev=
er)
5460da5: target-arm/translate-a64: fix gen_load_exclusive (Alex Benn=C3=A9e)
5072f7b: qapi: add missing colon-ending for section name (Marc-Andr=C3=A9 L=
ureau)
9f2a70e: qapi: use one symbol per line (Marc-Andr=C3=A9 Lureau)
4d5c8bc: qapi: fix various symbols mismatch in documentation (Marc-Andr=C3=
=A9 Lureau)
c5927e7: qapi: fix missing symbol @prefix (Marc-Andr=C3=A9 Lureau)
49687ac: qapi: fix schema symbol sections (Marc-Andr=C3=A9 Lureau)
95cd8fd: qga/schema: fix double-return in doc (Marc-Andr=C3=A9 Lureau)
29a6731: tests: Avoid qobject_from_jsonf("%"PRId64) (Eric Blake)
1792d7d: test-qga: Avoid qobject_from_jsonv("%"PRId64) (Eric Blake)
043b5a4: qmp-event: Avoid qobject_from_jsonf("%"PRId64) (Eric Blake)
4299b90: display: cirrus: check vga bits per pixel(bpp) value (Prasad J Pan=
dit)
64f441d: fsl_etsec: Pad short payloads with zeros (Andrey Smirnov)
77d5498: net: mcf: check receive buffer size register value (Prasad J Pandi=
t)
2d1cd6c: virtio-gpu: fix memory leak in update_cursor_data_virgl (Li Qiang)
42a8dad: virtio-gpu: fix information leak in getting capset info dispatch (=
Li Qiang)
6c75650: qxl: Only emit QXL_INTERRUPT_CLIENT_MONITORS_CONFIG on config chan=
ges (Christophe Fergeau)
e6e2784: target-mips: fix bad shifts in {dextp|dextpdp} (Yongbok Kim)
b5a587b: target-mips: Fix Loongson multimedia instructions. (Heiher)
bb7cab5: target-mips: Fix Loongson multimedia 'or' instruction. (Heiher)
9099a36: target-mips: Fix Loongson pandn instruction. (Heiher)
5c0139a: spapr: fix default DRC state for coldplugged LMBs (Michael Roth)
9730280: virtio-crypto: fix uninitialized variables (Gonglei)
1b57bd4: loader: fix undefined behavior in rom_order_compare() (Laszlo Erse=
k)
aa6c6ae: loader: fix handling of custom address spaces when adding ROM blob=
s (Laszlo Ersek)
6cb99ac: intel_iommu: fix incorrect device invalidate (Peter Xu)
5449c23: spec/vhost-user: fix the VHOST_USER prefix (Wei Wang)
