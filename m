Received: from eggs.gnu.org ([2001:4830:134:3::10]:44005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYTq8-0007FZ-TH
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYTq4-0006HU-TH
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:35:32 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:57034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eYTq4-0006GS-Jl
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:35:28 -0500
References: <20171228193439.18835-1-samuel.thibault@ens-lyon.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a206f5d1-b529-0f9a-0e5b-7b0beedf3c7d@vivier.eu>
Date: Mon, 8 Jan 2018 10:35:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171228193439.18835-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix sched_get/setaffinity
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 28/12/2017 à 20:34, Samuel Thibault a écrit :
> sched_get/setaffinity linux-user syscalls were missing conversions for
> little/big endian, which is hairy since longs may not be the same size
> either.
> 
> For simplicity, this just introduces loops to convert bit by bit like is
> done for select.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---

You should add a version in your subject prefix and a version history of
your patch here.

>  linux-user/syscall.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 8 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
