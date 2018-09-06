Received: from eggs.gnu.org ([2001:4830:134:3::10]:34707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fxoLJ-00055j-H1
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fxoLG-0002Oo-7H
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:04:41 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fxoLF-0002Ne-QB
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:04:38 -0400
References: <20180906065729.2487-1-sandipan@linux.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <876f77aa-ce49-2ee4-1f21-5f371076c9c9@vivier.eu>
Date: Thu, 6 Sep 2018 09:04:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180906065729.2487-1-sandipan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target-ppc: Extend HWCAP2 bits for ISA 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandipan Das <sandipan@linux.ibm.com>, david@gibson.dropbear.id.au, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, nikunj@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com

Le 06/09/2018 à 08:57, Sandipan Das a écrit :
> This adds the HWCAP2 bit to detect if a linux user process is
> running on an ISA 3.0 compliant cpu like POWER9. This can be
> verified using a simple test program that prints the value in
> the auxiliary vector for AT_HWCAP2 as shown below.
> 
> Before:
>   $ qemu-ppc64le -cpu power8 test
>   0x8c000000
> 
>   $ qemu-ppc64le -cpu power9 test
>   0x8c000000
> 
> After:
>   $ qemu-ppc64le -cpu power8 test
>   0x8c000000
> 
>   $ qemu-ppc64le -cpu power9 test
>   0x8c800000
> 
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>  linux-user/elfload.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
