Received: from eggs.gnu.org ([2001:4830:134:3::10]:58437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7jSH-00014a-Ef
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7jSG-00040g-6C
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:16:05 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:36111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cfkarsten@gmail.com>) id 1d7jSF-00040W-Rg
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:16:03 -0400
Received: by mail-qk0-x22b.google.com with SMTP id u75so52719103qka.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 07:16:03 -0700 (PDT)
MIME-Version: 1.0
Sender: cfkarsten@gmail.com
In-Reply-To: <87wp9r689l.fsf@dusky.pond.sub.org>
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
	<87wp9r689l.fsf@dusky.pond.sub.org>
From: Carl Karsten <carl@personnelware.com>
Date: Mon, 8 May 2017 09:15:32 -0500
Message-ID: <CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] format=raw,readonly errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, May 8, 2017 at 3:51 AM, Markus Armbruster <armbru@redhat.com> wrote:

> Carl Karsten <carl@personnelware.com> writes:
>
> > juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses  -drive
> > file=disk.cow -drive file=boot.img
> > WARNING: Image format was not specified for 'boot.img' and probing
> guessed
> > raw.
> >          Automatically detecting the format is dangerous for raw images,
> > write operations on block 0 will be restricted.
> >          Specify the 'raw' format explicitly to remove the restrictions.
> >
> > This is OK, as I don't want anything writing to that thing anyway.  So to
> > get rid of the waring:
> >
> > juser@gator:~/temp$ qemu-system-x86_64 -drive
> > file=boot.img,format=raw,readonly qemu-system-x86_64: Can't use a
> read-only
> > drive
> > qemu-system-x86_64: Initialization of device ide-hd failed: Device
> > initialization failed.
>
> -drive without if=... creates an IDE disk[*].  IDE disks can't do
> read-only.  Have you tried omitting ",readonly"?
>


omitting works, but my goal was for the drive to be read only.




>
> > hmm... one more try:
> >
> > juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses  -drive
> > file=disk.cow,readonly
> > qemu-system-x86_64: Can't use a read-only drive
> > qemu-system-x86_64: Initialization of device ide-hd failed: Device
> > initialization failed.
>
>
> [*] It actually depends on the machine, but I figure that's of no
> interest to you.
>



-- 
Carl K
