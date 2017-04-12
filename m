Received: from eggs.gnu.org ([2001:4830:134:3::10]:47544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyV4r-0007Cb-KQ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 23:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyV4m-0003yu-KK
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 23:05:45 -0400
Received: from mail-db5eur01on0110.outbound.protection.outlook.com
	([104.47.2.110]:45413
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1cyV4m-0003yX-0m
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 23:05:40 -0400
Date: Wed, 12 Apr 2017 19:30:56 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170412163055.GB4915@rkaganb.sw.ru>
References: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
Subject: Re: [Qemu-devel] WinDbg module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel@nongnu.org, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, pbonzini@redhat.com

On Wed, Apr 12, 2017 at 05:05:45PM +0300, Mihail Abakumov wrote:
> Hello.
> 
> We made the debugger module WinDbg (like GDB) for QEMU. This is the
> replacement of the remote stub in Windows kernel. Used for remote Windows
> kernel debugging without debugging mode.
> 
> The latest build and instructions for the launch can be found here:
> https://github.com/ispras/qemu/releases/tag/v2.7.50-windbg
> 
> Currently only one ways to create a remote debugging connection is
> supported: using COM port with named pipe.
> 
> Should I prepare patches for inclusion in the master branch? Or is it too
> specific module and it is not needed?

Please do!

Every once in a while dealing with a Windows guest problem I wished I
had this.  We at Virtuozzo looked into doing something like this but
never got around to.

Thanks,
Roman.
