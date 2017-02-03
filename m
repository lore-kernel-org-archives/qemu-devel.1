Received: from eggs.gnu.org ([2001:4830:134:3::10]:50426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cZdvx-0003eG-Ag
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cZdvu-0006FR-6f
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:29:49 -0500
Received: from isrv.corpit.ru ([86.62.121.231]:51521)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cZdvt-0006EB-VM
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:29:46 -0500
References: <20170203120649.15637-1-berrange@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <e33cb32f-b767-3f40-6543-33a7af513514@msgid.tls.msk.ru>
Date: Fri, 3 Feb 2017 16:29:43 +0300
MIME-Version: 1.0
In-Reply-To: <20170203120649.15637-1-berrange@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Support multiple listening sockets
 per VNC server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

03.02.2017 15:06, Daniel P. Berrange wrote:

>  - If a DNS name resolves to multiple distinct IP addresses,
>    the VNC server is now able to listen on all of them
> 
>  - The -vnc argument syntax is extended to allow the 'vnc'
>    and 'websocket' arguments to be listed multiple times.
>    This allows a single VNC server to listen on multiple
>    different names / addresses.

Why it's needed? To me it looks like to much for a very rarely
useful thing, no? (Just thinking out loud, nothing more)

/mjt
