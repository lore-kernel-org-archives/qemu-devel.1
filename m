Received: from eggs.gnu.org ([2001:4830:134:3::10]:60558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa10w-0007KB-Ql
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa10u-0008S3-CE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa10u-0008PP-2F
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:16 -0400
Date: Mon, 2 Jul 2018 17:45:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180702154513.7ah55gzfwp7spkfa@sirius.home.kraxel.org>
References: <20180630165448.30795-1-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630165448.30795-1-mjt@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] [PATCH] ui: do not build-depend or link with
 libdrm, it is not needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org

On Sat, Jun 30, 2018 at 07:54:48PM +0300, Michael Tokarev wrote:
> Opengl support brings up libdrm. But actually nothing uses this library
> or includes any of its headers. Just remove checking for it from configure.

Added to ui queue.

thanks,
  Gerd
