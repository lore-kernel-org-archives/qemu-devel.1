Received: from eggs.gnu.org ([2001:4830:134:3::10]:45575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1e1pQH-0008Ag-7A
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1e1pQD-0006yE-DV
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:57:53 -0400
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1]:60277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1e1pQD-0006x3-6O
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:57:49 -0400
References: <88c14424-9813-5e68-0aa7-38f3cde0a491@tuxfamily.org>
From: Marek Vasut <marex@denx.de>
Message-ID: <8ae225f4-b3b8-b09d-03ed-9e8b38a051a5@denx.de>
Date: Tue, 10 Oct 2017 09:57:43 +0200
MIME-Version: 1.0
In-Reply-To: <88c14424-9813-5e68-0aa7-38f3cde0a491@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-nios2 hangs when emulator is quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/10/2017 09:20 AM, Thomas Huth wrote:
>  Hi Chris, hi Marek,

Hi,

> I recently noticed that when I start qemu-system-nios2 (build from the
> very latest git master branch) and then type "quit" at the monitor (or
> simply try to close the GTK window), QEMU does not shut down right and
> hangs somewhere in pause_all_vcpus() forever.
> Do you have any idea what might be wrong here?

Nope, can you debug it and ev. send patch ? We're talking about git
HEAD, right ?

>  Thanks,
>   Thomas
> 


-- 
Best regards,
Marek Vasut
