Received: from eggs.gnu.org ([2001:4830:134:3::10]:58276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7l27-0003ZP-IC
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7l26-0005Ru-Eb
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:57:11 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cfkarsten@gmail.com>) id 1d7l26-0005RZ-8o
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:57:10 -0400
Received: by mail-qt0-x241.google.com with SMTP id j13so10118343qta.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 08:57:10 -0700 (PDT)
MIME-Version: 1.0
Sender: cfkarsten@gmail.com
In-Reply-To: <bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
	<87wp9r689l.fsf@dusky.pond.sub.org>
	<CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
	<bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
From: Carl Karsten <carl@personnelware.com>
Date: Mon, 8 May 2017 10:56:39 -0500
Message-ID: <CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
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
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Mon, May 8, 2017 at 10:32 AM, John Snow <jsnow@redhat.com> wrote:

>
>
> On 05/08/2017 10:15 AM, Carl Karsten wrote:
> > On Mon, May 8, 2017 at 3:51 AM, Markus Armbruster <armbru@redhat.com>
> wrote:
> >
> >> Carl Karsten <carl@personnelware.com> writes:
> >>
> >>> juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses  -drive
> >>> file=disk.cow -drive file=boot.img
> >>> WARNING: Image format was not specified for 'boot.img' and probing
> >> guessed
> >>> raw.
> >>>          Automatically detecting the format is dangerous for raw
> images,
> >>> write operations on block 0 will be restricted.
> >>>          Specify the 'raw' format explicitly to remove the
> restrictions.
> >>>
> >>> This is OK, as I don't want anything writing to that thing anyway.  So
> to
> >>> get rid of the waring:
> >>>
> >>> juser@gator:~/temp$ qemu-system-x86_64 -drive
> >>> file=boot.img,format=raw,readonly qemu-system-x86_64: Can't use a
> >> read-only
> >>> drive
> >>> qemu-system-x86_64: Initialization of device ide-hd failed: Device
> >>> initialization failed.
> >>
> >> -drive without if=... creates an IDE disk[*].  IDE disks can't do
> >> read-only.  Have you tried omitting ",readonly"?
> >>
> >
> >
> > omitting works, but my goal was for the drive to be read only.
> >
> >
>
> I don't think there's a way to make physical IDE drives "read only." I
> don't think there's any jumper settings or any of the like which can
> accomplish this.
>
> Unlike floppy disks (which you could notch the corner of) or SD cards
> (which have the write lock), I don't think ATA disks have a method for
> being "read only," so this isn't a feature QEMU can support.
>
> What you CAN do, however, is to use -snapshot or otherwise use something
> like a qcow2 overlay to trap all writes to a temporary file that you can
> discard at a later point in time, effectively keeping your original
> image "read only."
>
> I believe that SCSI disks support a read-only mode, though.
>


k - that all makes sense.

kinda ;)

 "write operations on block 0 will be restricted."

Is there a way to explicitly enable that?

The installer on the usb stick keeps stepping on itself rendering it
broken, both physical usb drive and a dd image.

I can play with OS permissions too, but that restricted warning made me
think that would be 'best'.

but but, now that I have index/bootindex working I probably won't be
trashing my installer any more, so non-issue.



-- 
Carl K
