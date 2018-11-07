Received: from eggs.gnu.org ([2001:4830:134:3::10]:43322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kallan@suse.com>) id 1gKRXr-00030z-2h
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kallan@suse.com>) id 1gKRXm-00066Q-V2
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:23:11 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:51239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kallan@suse.com>) id 1gKRXm-00065e-OS
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:23:06 -0500
Message-Id: <5BE31F76020000760003D33A@prv-mh.provo.novell.com>
Date: Wed, 07 Nov 2018 10:23:02 -0700
From: "Kirk Allan" <kallan@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Qemu-devel]  getting link errors when building for qga-vss.dll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When I try to build qga-vss.dll I get the following link error:

LINK    qga/vss-win32/qga-vss.dll
/usr/lib64/gcc/i686-w64-mingw32/8.2.0/../../../../i686-w64-mingw32/bin/ld: =
qga/vss-win32/requester.o: in function `requester_freeze':
/src/qemu/qga/vss-win32/requester.cpp:284: undefined reference to =
`g_assertion_message_expr'

I started getting this link error with commit 3ebee3b191e755d3f7311a6a62eea=
5c9628b221b where assert is redefined to g_assert.

Is there something additional I need to add to my configure or make =
commands to resolve g_assertion_message_expr?

My configure command is: ./configure --cross-prefix=3Di686-w64-mingw32- =
--enable-guest-agent --with-vss-sdk

My make command is: make qemu-ga.exe qga/vss-win32/qga-vss.dll

Thanks,
Kirk
