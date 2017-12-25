Received: from eggs.gnu.org ([2001:4830:134:3::10]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1eTNaL-0001bw-9n
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 02:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1eTNaI-0005k1-8g
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 02:54:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:1167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@intel.com>) id 1eTNaI-0005im-0E
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 02:54:06 -0500
From: "He, Junyan" <junyan.he@intel.com>
Date: Mon, 25 Dec 2017 07:54:00 +0000
Message-ID: <EC8A4E314CF1574AB62C80421BD9833933FEE069@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Some question about savem/qcow2 incremental snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

hi all:

I am now focusing on snapshot optimization for Intel NVDimm kind memory. Di=
fferent from the normal memory, the NVDimm may be 128G, 256G or even more f=
or just one guest, and its speed is slower than the normal memory. So somet=
imes it may take several minutes to complete just one snapshot saving. Even=
 with compression enabled, the=A0snapshot point may consume more than 30G d=
isk space. We decide to add incremental kind snapshot saving to resolve thi=
s. Just store difference between snapshot points to save time and disk spac=
e.
But the current snapshot/save_vm framework seems not to support this.
We need to add snapshot dependency and extra operations when we LOAD and DE=
LETE the snapshot point.
Is that possible to modify the savevm framework and add some incremental sn=
apshot support to QCOW2 format?

Thanks
