Received: from eggs.gnu.org ([2001:4830:134:3::10]:52104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewUlJ-0000Tv-UQ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewUlF-0000DX-TT
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:25:49 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ewUlF-0000CY-KI
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:25:45 -0400
References: <20180314153121.23838-1-james.cowgill@mips.com>
	<20180315151348.6451-1-james.cowgill@mips.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <67a47930-6e97-296a-e918-beb3d75b7a87@vivier.eu>
Date: Thu, 15 Mar 2018 16:25:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180315151348.6451-1-james.cowgill@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Cowgill <james.cowgill@mips.com>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Cc: Richard Henderson <richard.henderson@linaro.org>

Le 15/03/2018 à 16:13, James Cowgill a écrit :
> Add support for the two currently defined HWCAP bits on MIPS - R6 and
> MSA.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1754372
> Signed-off-by: James Cowgill <james.cowgill@mips.com>
> ---
> v2 changes:
>  - Fix kernel hwcap.h path.
> 
>  linux-user/elfload.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
