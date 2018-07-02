Received: from eggs.gnu.org ([2001:4830:134:3::10]:38037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3w7-0003ct-99
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3w2-0006MJ-Ez
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:52:31 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa3w2-0006LS-3m
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:52:26 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-12-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a44c7017-4da8-c812-b7da-0d3c0751a9d0@vivier.eu>
Date: Mon, 2 Jul 2018 20:52:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 11/13] linux-user/strace: Add
 print_sockaddr_ptr() to handle plain/pointer addrlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Le 02/07/2018 à 19:50, Philippe Mathieu-Daudé a écrit :
> While very similar to send()/recv(), the format used by
> sendto()/recvfrom() is slightly different: the 'addrlen'
> is not a plain sockaddr_t but a pointer to it.
> 
> Split the current function to handle both formats.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/strace.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 

In the following patches I think you can use do_print_sockaddr() and
don't have to define print_sockaddr_ptr()

Thanks,
Laurent
