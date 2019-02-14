Received: from eggs.gnu.org ([209.51.188.92]:35287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDcF-00088e-6p
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDcE-00011Y-6p
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:47:35 -0500
References: <20190207233704.29978-1-n54@gmx.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9b42552a-b0b9-3786-3062-72e00d2ee7db@vivier.eu>
Date: Thu, 14 Feb 2019 10:47:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190207233704.29978-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] configure: Add HAX support
 in NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org
Cc: asanchez@kryptoslogic.com, qemu-devel@nongnu.org, yu.ning@intel.com, pbonzini@redhat.com

On 08/02/2019 00:37, Kamil Rytarowski wrote:
> The NetBSD support in Intel HAXM has beem merged upstream and is functional.
> 
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configure b/configure
> index b18281c61f..89b889072d 100755
> --- a/configure
> +++ b/configure
> @@ -819,6 +819,7 @@ DragonFly)
>  ;;
>  NetBSD)
>    bsd="yes"
> +  hax="yes"
>    make="${MAKE-gmake}"
>    audio_drv_list="oss try-sdl"
>    audio_possible_drivers="oss sdl"
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
