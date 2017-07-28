Received: from eggs.gnu.org ([2001:4830:134:3::10]:48706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db8FS-0006SB-Ny
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db8FR-0002DP-UL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:36:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170728123127.27921-1-olaf@aepfle.de>
	<d8aca223-4007-6524-9876-fe32fd81e893@redhat.com>
	<20170728124832.GP8603@aepfle.de>
Date: Fri, 28 Jul 2017 18:35:57 +0200
In-Reply-To: <20170728124832.GP8603@aepfle.de> (Olaf Hering's message of "Fri,
	28 Jul 2017 14:48:33 +0200")
Message-ID: <87mv7oldsi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] xen-disk: use g_malloc0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

Olaf Hering <olaf@aepfle.de> writes:

> On Fri, Jul 28, Eric Blake wrote:
>
>> This version is prone to multiplication overflow (well, maybe not, but
>> you have to audit for that).  Wouldn't it be better to use:
>
> What could go wrong?
> qemu will die either way, I think.

An overflow in the size argument of malloc(), realloc(), etc. is a heap
overrun waiting to happen.
