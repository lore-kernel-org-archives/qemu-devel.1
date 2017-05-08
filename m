Received: from eggs.gnu.org ([2001:4830:134:3::10]:34134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7aIW-0006BE-PJ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7aIV-0000X6-VM
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:29:24 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:34391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cfkarsten@gmail.com>) id 1d7aIV-0000Wu-QA
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:29:23 -0400
Received: by mail-qk0-x229.google.com with SMTP id k74so42921910qke.1
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:29:23 -0700 (PDT)
MIME-Version: 1.0
Sender: cfkarsten@gmail.com
From: Carl Karsten <carl@personnelware.com>
Date: Sun, 7 May 2017 23:28:52 -0500
Message-ID: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] format=raw,readonly errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses  -drive
file=disk.cow -drive file=boot.img
WARNING: Image format was not specified for 'boot.img' and probing guessed
raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.

This is OK, as I don't want anything writing to that thing anyway.  So to
get rid of the waring:

juser@gator:~/temp$ qemu-system-x86_64 -drive
file=boot.img,format=raw,readonly qemu-system-x86_64: Can't use a read-only
drive
qemu-system-x86_64: Initialization of device ide-hd failed: Device
initialization failed.

hmm... one more try:

juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses  -drive
file=disk.cow,readonly
qemu-system-x86_64: Can't use a read-only drive
qemu-system-x86_64: Initialization of device ide-hd failed: Device
initialization failed.




-- 
Carl K
