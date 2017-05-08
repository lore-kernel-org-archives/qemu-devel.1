Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7eOa-0005On-FD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7eOX-0007o6-Dg
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d7eOX-0007nu-6q
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:51:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
Date: Mon, 08 May 2017 10:51:50 +0200
In-Reply-To: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
	(Carl Karsten's message of "Sun, 7 May 2017 23:28:52 -0500")
Message-ID: <87wp9r689l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] format=raw,readonly errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carl Karsten <carl@personnelware.com>
Cc: qemu-devel@nongnu.org

Carl Karsten <carl@personnelware.com> writes:

> juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses  -drive
> file=disk.cow -drive file=boot.img
> WARNING: Image format was not specified for 'boot.img' and probing guessed
> raw.
>          Automatically detecting the format is dangerous for raw images,
> write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions.
>
> This is OK, as I don't want anything writing to that thing anyway.  So to
> get rid of the waring:
>
> juser@gator:~/temp$ qemu-system-x86_64 -drive
> file=boot.img,format=raw,readonly qemu-system-x86_64: Can't use a read-only
> drive
> qemu-system-x86_64: Initialization of device ide-hd failed: Device
> initialization failed.

-drive without if=... creates an IDE disk[*].  IDE disks can't do
read-only.  Have you tried omitting ",readonly"?

> hmm... one more try:
>
> juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses  -drive
> file=disk.cow,readonly
> qemu-system-x86_64: Can't use a read-only drive
> qemu-system-x86_64: Initialization of device ide-hd failed: Device
> initialization failed.


[*] It actually depends on the machine, but I figure that's of no
interest to you.
