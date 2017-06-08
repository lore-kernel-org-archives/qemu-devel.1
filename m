Received: from eggs.gnu.org ([2001:4830:134:3::10]:43955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3259eba5e=anthony.perard@citrix.com>)
	id 1dIyyD-0002d0-GQ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3259eba5e=anthony.perard@citrix.com>)
	id 1dIyyA-0008Le-7D
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:03:33 -0400
Received: from smtp.citrix.com ([66.165.176.89]:15384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3259eba5e=anthony.perard@citrix.com>)
	id 1dIyyA-0008Io-2H
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:03:30 -0400
Date: Thu, 8 Jun 2017 16:01:37 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170608150137.GF1919@perard.uk.xensource.com>
References: <20170608115939.30985-1-marcandre.lureau@redhat.com>
	<20170608115939.30985-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170608115939.30985-2-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] char: fix alias devices regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Thu, Jun 08, 2017 at 03:59:37PM +0400, Marc-André Lureau wrote:
> Fix regression from commit 4d43a603c71, where the serial and parallel
> headers got removed from char.c, which broke the alias table.
> 
> Move the HAVE_CHARDEV_SERIAL/HAVE_CHARDEV_PARPORT to osdep.h instead
> of being in seperate headers.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Thanks, that works for me.

Tested-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
