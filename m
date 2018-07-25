Received: from eggs.gnu.org ([2001:4830:134:3::10]:55089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rebecca@bluestop.org>) id 1fiBif-0006gg-Mf
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 00:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rebecca@bluestop.org>) id 1fiBic-0001X2-OK
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 00:48:13 -0400
Received: from muon.bluestop.org ([96.73.9.1]:60811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rebecca@bluestop.org>)
	id 1fiBic-0001Ju-HU
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 00:48:10 -0400
Received: from muon.bluestop.org (localhost [127.0.0.1])
	by muon.bluestop.org (Postfix) with ESMTP id A1CEBA5297
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 22:48:10 -0600 (MDT)
Received: from muon.bluestop.org ([127.0.0.1])
	by muon.bluestop.org (muon.bluestop.org [127.0.0.1]) (amavisd-new,
	port 10026) with ESMTP id EC2jkRRoS014 for <qemu-devel@nongnu.org>;
	Tue, 24 Jul 2018 22:48:10 -0600 (MDT)
Received: from tau.bluestop.org (gw.bluestop.org [96.73.9.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by muon.bluestop.org (Postfix) with ESMTPSA
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 22:48:10 -0600 (MDT)
From: Rebecca Cran <rebecca@bluestop.org>
Message-ID: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
Date: Tue, 24 Jul 2018 22:47:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc, ./configure on
FreeBSD incorrectly detects RDMA support, with the build subsequently
failing with:

/home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:19:10: fatal error:
'linux/types.h' file not found
#include <linux/types.h>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~
1 error generated.
gmake[1]: *** [/home/bcran/workspace/qemu/rules.mak:69:
hw/rdma/vmw/pvrdma_cmd.o] Error 1
gmake[1]: *** Waiting for unfinished jobs....
gmake: *** [Makefile:481: subdir-x86_64-softmmu] Error 2


--=20
Rebecca Cran
