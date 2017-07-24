Received: from eggs.gnu.org ([2001:4830:134:3::10]:41403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZjT7-0005bN-HU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZjT3-0006Ks-M1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:56:41 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dZjT3-0006K1-B1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:56:37 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-29-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bc580035-c608-0d2a-7898-8b9767eac44b@vivier.eu>
Date: Mon, 24 Jul 2017 21:56:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-29-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 28/35] syscall: check
 dup/dup2/dup3() errors, return EBADFD/EINVAL if required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

Le 24/07/2017 à 20:27, Philippe Mathieu-Daudé a écrit :
> Linux dup(2) manpage:
> 
> ERRORS
>   EBADF
>     newfd is out of the allowed range for file descriptors (like negative)
>   EINVAL (dup3())
>     oldfd was equal to newfd
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 


I don't understand why we need that: the dup()/dup2()/dup3() functions
will return the good error number.

Could you be more explicit on the reason?

Thanks,
Laurent
