Received: from eggs.gnu.org ([2001:4830:134:3::10]:60205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHTFC-0005qA-Se
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHTF7-0002Uo-MK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:35:38 -0400
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com
	([104.47.37.109]:12802
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gHTF1-0002AJ-0J
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:35:29 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 30 Oct 2018 12:35:15 +0000
Message-ID: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Question: Perfecting checkpatch.pl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

Perhaps checkpatch.pl should make sure the commit messages do not contain "=
address@hidden" and "Reviewed-off-by"?

$ git log | grep address@hidden
    Signed-off-by: Michael S. Tsirkin <address@hidden>
    Signed-off-by: Ronald Hecht <address@hidden>
    Signed-off-by: Justin Chevrier <address@hidden>
    Signed-off-by: Justin Chevrier <address@hidden>
    Signed-off-by: Justin Chevrier <address@hidden>

$ git log | grep Reviewed-off-by
    Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
    Reviewed-off-by: Anthony Liguori <aliguori@us.ibm.com>

Aleksandar=
