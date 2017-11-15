Received: from eggs.gnu.org ([2001:4830:134:3::10]:46630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eF3wo-0001ED-MX
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eF3wn-0002u0-Ug
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:06:10 -0500
MIME-Version: 1.0
In-Reply-To: <0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date: Wed, 15 Nov 2017 21:06:08 +0100
Message-ID: <CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>, Qemu-block <qemu-block@nongnu.org>

2017-11-15 20:59 GMT+01:00 Max Reitz <mreitz@redhat.com>:
> Well, you can't just add support to qemu-img alone either.  Every image
> format supported by qemu-img is one supported by qemu as a whole and
> thus needs a proper block driver that needs to support random accesses
> as well.

I was talking about qemu-img convert, just to convert an XVA image to
something different, in a single pass, without having to extract the
tar.
