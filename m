Received: from eggs.gnu.org ([2001:4830:134:3::10]:51633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQfD8-0004Vb-Kk
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQfD7-00024e-O8
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:02:26 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cQfD7-00023x-JW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:02:25 -0500
Received: by mail-io0-x242.google.com with SMTP id m98so7885918iod.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 11:02:22 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  9 Jan 2017 11:02:17 -0800
Message-Id: <20170109190217.16301-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/11] tcg host mips64 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

[Bah.  This time with actual request-pull info.]

This is v6 of Jin Guojie's patch set, as tested by Aurelien Jarno,
James Hogan, and Yun Qiang Su.  Plus one more patch from me to fix
a trival Werror in mips specific code with gcc 5.3.


r~


The following changes since commit f0d703314ecb0415d51425727ed73ad2c6e3238a:

  tcg-mips: Adjust qemu_ld/st for mips64 (2017-01-06 10:09:10 -0800)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170108

for you to fetch changes up to f68808c7494b38764e1895a9852b994638b86536:

  translate-all: Avoid -Werror=switch-bool (2017-01-08 09:48:34 -0800)

----------------------------------------------------------------
TCG host support for mips64

----------------------------------------------------------------
Richard Henderson (1):
      translate-all: Avoid -Werror=switch-bool

 translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
