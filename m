Received: from eggs.gnu.org ([2001:4830:134:3::10]:47414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOVm-000252-SU
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euOVj-0004Lv-Nz
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:21:06 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:51099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euOVj-0004LG-Eg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:21:03 -0500
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-2-lukeshu@lukeshu.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <966b35a3-654c-fabf-e416-86b14da9fd29@vivier.eu>
Date: Fri, 9 Mar 2018 21:20:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-2-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/10] linux-user: Use #if to only call
 validate_guest_space for 32-bit ARM target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>, qemu-devel@nongnu.org
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>

Le 28/12/2017 à 19:08, Luke Shumaker a écrit :
> From: Luke Shumaker <lukeshu@parabola.nu>
> 
> Instead of defining a bogus validate_guest_space that always returns 1 on
> targets other than 32-bit ARM, use #if blocks to only call it on 32-bit ARM
> targets.  This makes the "normal" flow control clearer.
> 
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

With the change request by Peter (condition "!= 1"),
applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
