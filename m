Received: from eggs.gnu.org ([2001:4830:134:3::10]:41559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cRjdG-0007Db-70
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cRjdF-0000BG-7i
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:57:50 -0500
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
From: Bob Chen <a175818323@gmail.com>
Date: Fri, 13 Jan 2017 01:57:46 +0800
Message-ID: <CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-block] [Nbd] How to online resize qemu disk
 with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

There might be a time window between the NBD server's resize and the
client's `re-read size` request. Is it safe?

What about an active `resize` request from the client? Considering some NBD
servers might have the capability to do instant resizing, not applying to
LVM or host block device, of course...


Regards,
Bob

2017-01-13 0:54 GMT+08:00 Stefan Hajnoczi <stefanha@gmail.com>:

> On Thu, Jan 12, 2017 at 3:44 PM, Alex Bligh <alex@alex.org.uk> wrote:
> >> On 12 Jan 2017, at 14:43, Eric Blake <eblake@redhat.com> wrote:
> >> That's because the NBD protocol lacks a resize command.  You'd have to
> >> first get that proposed as an NBD extension before qemu could support
> it.
> >
> > Actually the NBD protocol lacks a 'make a disk with size X' command,
> > let alone a resize command. The size of an NBD disk is (currently)
> > entirely in the hands of the server. What I think we'd really need
> > would be a 'reread size' command, and have the server capable of
> > supporting resizing. That would then work for readonly images too.
>
> That would be fine for QEMU.  Resizing LVM volumes or host block
> devices works exactly like this.
>
> Stefan
>
>
