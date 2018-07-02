Received: from eggs.gnu.org ([2001:4830:134:3::10]:60085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3lB-0007j6-EI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3l8-0006FX-CC
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:41:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa3l8-0006Dy-1k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:41:10 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-11-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3e086611-f18d-2283-f3a2-2a421588f535@vivier.eu>
Date: Mon, 2 Jul 2018 20:40:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 10/13] linux-user/strace: Let
 print_sockaddr() have a 'last' argument
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
> If the format is not the syscall last argument, a comma is append.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/strace.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
