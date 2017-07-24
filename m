Received: from eggs.gnu.org ([2001:4830:134:3::10]:49861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZm1n-0003bd-8q
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZm1k-0003U7-5y
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:40:39 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:36016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZm1j-0003Tu-WE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:40:36 -0400
Received: by mail-qk0-x231.google.com with SMTP id d136so63782099qkg.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 15:40:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <504798a0-0ac3-bfab-a451-2eb0cfca43ff@amsat.org>
Date: Mon, 24 Jul 2017 19:40:31 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] MAINTAINERS: surprising get_maintainer.pl output for
 ./configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kamil Rytarowski <kamil@netbsd.org>

Hi perl gurus :)

after changing the ./configure I wanted to figure to whom email and got 
this:

$ ./scripts/get_maintainer.pl -f configure
Kamil Rytarowski <kamil@netbsd.org> (maintainer:NETBSD)
qemu-devel@nongnu.org (open list:All patches CC here)

$ fgrep -A5 NETBSD MAINTAINERS
NETBSD
L: qemu-devel@nongnu.org
M: Kamil Rytarowski <kamil@netbsd.org>
S: Maintained
K: (?i)NetBSD

Descriptions of section entries:

   K: Keyword perl extended regex pattern to match
      content in a patch or file.

$ fgrep -inA1 NetBSD configure
547:elif check_define __NetBSD__; then
548:  targetos='NetBSD'
--
709:NetBSD)
710-  bsd="yes"
--
715:  HOST_VARIANT_DIR="netbsd"
716-  supported_os="yes"

since ./configure check for NetBSD host/target, the string appears in 
the ./configure and the K regex is matched...

I tried to add a 'F: configure' in NETBSD entry but it doesn't change.
The easier is to kill the K entry :)

Regards,

Phil.
