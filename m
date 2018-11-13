Received: from eggs.gnu.org ([2001:4830:134:3::10]:35295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1gMYtT-000397-Tx
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1gMYtQ-0000Ln-2q
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:38:14 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:40804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1gMYtJ-00064X-NG
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:38:07 -0500
Received: by mail-ed1-x536.google.com with SMTP id d3so9886952edx.7
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 05:37:31 -0800 (PST)
MIME-Version: 1.0
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 13 Nov 2018 15:37:19 +0200
Message-ID: <CAKPgXcHAzuiy2Kr7-oaYDpUV71KAvzEhZ_bfTQ9GXFS4s8e4OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qga-win: Build errors when building with vss support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Bishara AbuHattoum <bishara@daynix.com>, Yan Vugenfirer <yan@daynix.com>

Hi all,

The following errors show up when attempting to compile qemu-ga for windows
which is done using mingw:

qga/vss-win32/requester.o: In function `requester_freeze':
/home/bishara/git_qemu/qga/vss-win32/requester.cpp:283: undefined
reference to `g_assertion_message_expr'
qga/vss-win32/requester.o: In function `requester_thaw':
/home/bishara/git_qemu/qga/vss-win32/requester.cpp:468: undefined
reference to `g_assertion_message_expr'
/home/bishara/git_qemu/qga/vss-win32/requester.cpp:469: undefined
reference to `g_assertion_message_expr'

I believe that the error was caused by the following commit:
https://github.com/qemu/qemu/commit/3ebee3b191e755d3f7311a6a62eea5c9628b221b

What do you think is the best approach to resolve this?

-- 
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.
