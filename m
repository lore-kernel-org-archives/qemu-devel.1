Received: from eggs.gnu.org ([2001:4830:134:3::10]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRie3-0000Uw-RA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRidz-00074G-F2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:54:35 -0500
MIME-Version: 1.0
In-Reply-To: <2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 12 Jan 2017 16:54:24 +0000
Message-ID: <CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
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
To: Alex Bligh <alex@alex.org.uk>
Cc: Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Jan 12, 2017 at 3:44 PM, Alex Bligh <alex@alex.org.uk> wrote:
>> On 12 Jan 2017, at 14:43, Eric Blake <eblake@redhat.com> wrote:
>> That's because the NBD protocol lacks a resize command.  You'd have to
>> first get that proposed as an NBD extension before qemu could support it.
>
> Actually the NBD protocol lacks a 'make a disk with size X' command,
> let alone a resize command. The size of an NBD disk is (currently)
> entirely in the hands of the server. What I think we'd really need
> would be a 'reread size' command, and have the server capable of
> supporting resizing. That would then work for readonly images too.

That would be fine for QEMU.  Resizing LVM volumes or host block
devices works exactly like this.

Stefan
