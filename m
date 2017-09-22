Received: from eggs.gnu.org ([2001:4830:134:3::10]:38981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvQrG-0006fY-3c
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvQrC-0005zM-Un
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:31:18 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dvQrC-0005xz-LC
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:31:14 -0400
References: <20170922140237.10869-1-carenas@gmail.com>
	<20170922140237.10869-3-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <592fda97-f1d3-d72d-82d4-abe7c9dcfe0d@vivier.eu>
Date: Fri, 22 Sep 2017 18:30:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170922140237.10869-3-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 2/6] linux-user: refactor socket.h for alpha
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
> based on fresh bits from linux 4.14 and therefore enabling SO_REUSEPORT
> as a side effect
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/alpha/sockbits.h | 104 ++++++++++++++++++++++++++++++++++++++++++++
>  linux-user/socket.h         | 104 +-------------------------------------------
>  2 files changed, 105 insertions(+), 103 deletions(-)
>  create mode 100644 linux-user/alpha/sockbits.h
> 
> diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
> new file mode 100644
> index 0000000000..768579a1f7
> --- /dev/null
> +++ b/linux-user/alpha/sockbits.h
> @@ -0,0 +1,104 @@
...
> +enum sock_type {
> +    TARGET_SOCK_STREAM      = 1,
> +    TARGET_SOCK_DGRAM       = 2,
> +    TARGET_SOCK_RAW         = 3,
> +    TARGET_SOCK_RDM         = 4,
> +    TARGET_SOCK_SEQPACKET   = 5,
> +    TARGET_SOCK_DCCP        = 6,
> +    TARGET_SOCK_PACKET      = 10,
> +    TARGET_SOCK_CLOEXEC     = 010000000,
> +    TARGET_SOCK_NONBLOCK    = 0x40000000,

You change the value of TARGET_SOCK_NONBLOCK, it's correct but you
should say that in the commit messages.

...
> -    enum sock_type {
> -           TARGET_SOCK_STREAM      = 1,
> -           TARGET_SOCK_DGRAM       = 2,
> -           TARGET_SOCK_RAW         = 3,
> -           TARGET_SOCK_RDM         = 4,
> -           TARGET_SOCK_SEQPACKET   = 5,
> -           TARGET_SOCK_DCCP        = 6,
> -           TARGET_SOCK_PACKET      = 10,
> -           TARGET_SOCK_CLOEXEC     = 010000000,
> -           TARGET_SOCK_NONBLOCK    = 010000000000,
> -    };

Thanks,
Laurent
