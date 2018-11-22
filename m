Received: from eggs.gnu.org ([2001:4830:134:3::10]:37529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gPqtG-00022T-RU
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gPqtB-0005SB-EM
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:27:37 -0500
References: <1542899500-23346-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c74fe488-cb98-33d0-3675-be377644df64@vivier.eu>
Date: Thu, 22 Nov 2018 16:27:25 +0100
MIME-Version: 1.0
In-Reply-To: <1542899500-23346-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] MAINTAINERS: Add
 nios2-related files to the Nios2 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 22/11/2018 16:11, Thomas Huth wrote:
> nios2_iic.c and the default-configs/nios2-softmmu.mak file are
> currently "unmaintained" according to the get_maintainers.pl script.
> Move them to the Nios2 section where they obviously belong to.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1291c07..33245b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -226,7 +226,9 @@ M: Marek Vasut <marex@denx.de>
>  S: Maintained
>  F: target/nios2/
>  F: hw/nios2/
> +F: hw/intc/nios2_iic.c
>  F: disas/nios2.c
> +F: default-configs/nios2-softmmu.mak
>  
>  OpenRISC
>  M: Stafford Horne <shorne@gmail.com>
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
