Received: from eggs.gnu.org ([2001:4830:134:3::10]:51999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5TKH-0007O0-BH
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5TKE-00058s-7r
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:43:01 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f5TKD-00057P-T9
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:42:58 -0400
References: <20180406013628.25900-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20ef86cd-b38f-f7b4-2400-4b0b77c5cfda@vivier.eu>
Date: Mon, 9 Apr 2018 11:42:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180406013628.25900-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

Le 06/04/2018 à 03:36, Max Filippov a écrit :
> preadv/pwritev accept low and high parts of file offset in two separate
> parameters. When host bitness doesn't match guest bitness these parts
> must be appropriately recombined.
> Introduce target_to_host_low_high that does this recombination and use
> it in preadv/pwritev syscalls.
> 
> This fixes glibc testsuite test misc/tst-preadvwritev64.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v3->v4:
> - recombine offset into unsigned long long and split it into two longs.
> 
> Changes v2->v3:
> - rename helper to target_to_host_low_high;
> - handle cases TARGET_LONG_BITS * 2 > HOST_LONG_BITS and
>   TARGET_LONG_BITS < 2 * HOST_LONG_BITS correctly.
> 
> Changes v1->v2:
> - fix host high computation in TARGET_LONG_BITS > HOST_LONG_BITS case
> 
>  linux-user/syscall.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
