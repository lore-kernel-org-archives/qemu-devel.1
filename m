Received: from eggs.gnu.org ([2001:4830:134:3::10]:41763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f6zCh-0006cx-Op
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f6zCd-0003rO-Sh
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:57:27 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f6zCd-0003qf-J2
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:57:23 -0400
References: <20180413133041.29509.59064.stgit@pasha-VirtualBox>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <450c3294-4e9e-1547-f75b-133ba756ca0a@vivier.eu>
Date: Fri, 13 Apr 2018 15:57:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180413133041.29509.59064.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] m68: fix exception stack frame for 68000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru

Le 13/04/2018 à 15:30, Pavel Dovgalyuk a écrit :
> 68000 CPUs do not save format in the exception stack frame.
> This patch adds feature checking to prevent format saving for 68000.
> m68k_ret() already includes this modification, this patch fixes
> the exception processing function too.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> --
> 
> v2:
>  - moved switch under the condition (suggested by Laurent Vivier)
> ---
>  target/m68k/op_helper.c |   33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 


Reviewed-by: Laurent Vivier <laurent@vivier.eu>
