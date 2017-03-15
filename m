Received: from eggs.gnu.org ([2001:4830:134:3::10]:59942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1co4DH-0003D1-DM
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1co4DD-0006li-CS
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:23:19 -0400
Received: from nm12-vm7.bullet.mail.ir2.yahoo.com ([212.82.96.177]:59059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <oussemakeder@yahoo.fr>) id 1co4DD-0006lV-2n
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:23:15 -0400
Date: Wed, 15 Mar 2017 08:23:12 +0000 (UTC)
From: oussema ben khedher <oussemakeder@yahoo.fr>
Reply-To: oussema ben khedher <oussemakeder@yahoo.fr>
Message-ID: <1204883637.539550.1489566192901@mail.yahoo.com>
MIME-Version: 1.0
References: <1204883637.539550.1489566192901.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] about trace Translation blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

hi=C2=A0
im trying to trace Translation bloks and i guess that this function its the=
 responsible for print the trace informations=C2=A0
qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc, "Trace %p [%d: " TARGET_FMT_l=
x "] %s\n", itb->tc_ptr, cpu->cpu_index, itb->pc, lookup_symbol(itb->pc));
but really i didn't understand it can someone guide me to modify this funct=
ion to have a trace in a file.txt or something else=C2=A0
thanks
