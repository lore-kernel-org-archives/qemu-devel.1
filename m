Received: from eggs.gnu.org ([2001:4830:134:3::10]:33819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyNJ0-00046h-4u
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 14:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyNIx-00017r-1x
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 14:47:50 -0400
Received: from mail-ve1eur01on0115.outbound.protection.outlook.com
	([104.47.1.115]:45884
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cyNIw-00016e-Gf
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 14:47:46 -0400
References: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <6da22cb5-de2d-1c0d-e912-79a6c7e4b7a2@openvz.org>
Date: Wed, 12 Apr 2017 21:47:38 +0300
MIME-Version: 1.0
In-Reply-To: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] WinDbg module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>, qemu-devel@nongnu.org
Cc: sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, pbonzini@redhat.com

On 04/12/2017 05:05 PM, Mihail Abakumov wrote:
> Hello.
>
> We made the debugger module WinDbg (like GDB) for QEMU. This is the
> replacement of the remote stub in Windows kernel. Used for remote
> Windows kernel debugging without debugging mode.
>
> The latest build and instructions for the launch can be found here:
> https://github.com/ispras/qemu/releases/tag/v2.7.50-windbg
>
> Currently only one ways to create a remote debugging connection is
> supported: using COM port with named pipe.
>
> Should I prepare patches for inclusion in the master branch? Or is it
> too specific module and it is not needed?
>
this would be indeed useful. We have a lot of problems
with Windows debugging. In general, Windows behaviour
with and without debugger is different.

Den
