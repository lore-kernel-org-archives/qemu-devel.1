Received: from eggs.gnu.org ([2001:4830:134:3::10]:43291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvR13-0003yt-Dh
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvR0y-0004Gs-G9
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:41:25 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:64939)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dvR0y-0004Fp-6t
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:41:20 -0400
References: <20170922140237.10869-1-carenas@gmail.com>
	<20170922140237.10869-4-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2f874d0a-2cb6-8409-b42a-c405ad779074@vivier.eu>
Date: Fri, 22 Sep 2017 18:41:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170922140237.10869-4-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 3/6] linux-user: refactor socket.h for mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, riku.voipio@iki.fi

Le 22/09/2017 à 16:02, Carlo Marcelo Arenas Belón a écrit :
> fresh bits from linux 4.14, redefine SO_STYLE and {SO,SCM}_TIMESTAMP to
> the target values and enables SO_REUSEPORT

And you fix TARGET_SOCK_NONBLOCK value.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
