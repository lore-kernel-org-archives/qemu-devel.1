Received: from eggs.gnu.org ([209.51.188.92]:37560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEg1k-0002VI-Oa
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEg1j-0005rS-N2
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:10:28 -0400
References: <20190409053320.14612-1-sw@weilnetz.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <38f6dcce-2122-0516-01f6-a549f11da87f@vivier.eu>
Date: Thu, 11 Apr 2019 22:10:21 +0200
MIME-Version: 1.0
In-Reply-To: <20190409053320.14612-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Update configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 09/04/2019 07:33, Stefan Weil wrote:
> The last *.aml file was removed in commit 13b1881aacc7e5018773bd545bbaf8d5476699ee.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1c563a7027..9c5d9a8c96 100755
> --- a/configure
> +++ b/configure
> @@ -7886,7 +7886,6 @@ LINKS="$LINKS python"
>  for bios_file in \
>      $source_path/pc-bios/*.bin \
>      $source_path/pc-bios/*.lid \
> -    $source_path/pc-bios/*.aml \
>      $source_path/pc-bios/*.rom \
>      $source_path/pc-bios/*.dtb \
>      $source_path/pc-bios/*.img \
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
