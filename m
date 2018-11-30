Received: from eggs.gnu.org ([2001:4830:134:3::10]:59654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@os.amperecomputing.com>) id 1gSk1i-0004ZW-SA
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@os.amperecomputing.com>) id 1gSk1d-0002go-Tc
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:44:18 -0500
Received: from mail-eopbgr730118.outbound.protection.outlook.com
	([40.107.73.118]:13696
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@os.amperecomputing.com>)
	id 1gSk1d-0002gA-KH
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:44:13 -0500
From: Michael Spradling <michael@os.amperecomputing.com>
Date: Fri, 30 Nov 2018 14:44:10 +0000
Message-ID: <20181130144404.GA32091@mswork1>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4D6FD60FD79AF40B5AAA38011633AE2@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Loading snapshot with readonly qcow2 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello,

I would like to resume a snapshot via the command line option -loadvm
with a read only QCOW2 file.  For my use case, I would ideally like to
load multiple instances of different snapshots from the same QCOW2 image.

It seems this is not possible at the moment as when a snapshot is loaded, Q=
EMU
copies some meta data around in the qcow2 image.

I have also tried to use the "-snapshot" option, which to my understanding
creates a new temporary QCOW2 file with a backing file pointing the origina=
l
image passed on the command line.  This also does not work, when looking
through the source it appears QEMU only supports loading snapshots from wri=
table
QCOW2 images and doesn't support loading from images in backing files.

My question is has anyone looked into loading snapshots from a backing
file?  I have attempted to look through the code and this looks to be
difficult.  If I attempt to add support for this is there any general
advice to follow?  Any other ideas?

Thanks,
Michael
