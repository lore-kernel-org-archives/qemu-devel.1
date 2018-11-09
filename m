Received: from eggs.gnu.org ([2001:4830:134:3::10]:56396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gL1OQ-0001Ff-MN
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 02:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gL1OL-0006WD-Ua
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 02:39:49 -0500
Received: from pv33p00im-asmtp002.me.com ([17.142.194.251]:29600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1gL1OJ-0005jm-KT
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 02:39:45 -0500
Received: from process-dkim-sign-daemon.pv33p00im-asmtp002.me.com by
	pv33p00im-asmtp002.me.com
	(Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built
	May 31 2018)) id <0PHX00L0012DD000@pv33p00im-asmtp002.me.com> for
	qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:39:33 +0000 (GMT)
Received: from icloud.com ([127.0.0.1]) by pv33p00im-asmtp002.me.com
	(Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built
	May 31
	2018)) with ESMTPSA id <0PHX00O7L19R9H00@pv33p00im-asmtp002.me.com> for
	qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:39:31 +0000 (GMT)
From: Chen Zhang <tgfbeta@me.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (1.0)
Date: Fri, 09 Nov 2018 15:39:26 +0800
Message-id: <84DB61DD-A7DB-4DDC-9CAD-410ECEC979D5@me.com>
Subject: [Qemu-devel] GTK: default display refresh rate at 60Hz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

It=E2=80=99s observed that GTK display performs poorly compared with native e=
nvironment. The display refresh timer fires at a interval of GUI_REFRESH_INT=
ERVAL_DEFAULT milliseconds which is defined as 30 in include/ui/console.h. T=
his throttles refresh rate to 33Hz.

Changing its value to 16 (i.e. 60Hz) seems reasonable and may actually impro=
ve performance.

Best regards=20=
