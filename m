Received: from eggs.gnu.org ([209.51.188.92]:33244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grq1c-0006j0-UK
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grq1c-00015F-8K
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:11:56 -0500
References: <20190207193605.25676-1-crosa@redhat.com>
	<20190207193605.25676-3-crosa@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <eb52ed3a-e2fb-d5d2-5d7e-ceb41e8a7987@vivier.eu>
Date: Thu, 7 Feb 2019 21:11:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190207193605.25676-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] configure: fix qemu-img name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>

On 07/02/2019 20:36, Cleber Rosa wrote:
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index ff55e2273e..c8fc1647fe 100755
> --- a/configure
> +++ b/configure
> @@ -1768,7 +1768,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    virglrenderer   virgl rendering support
>    xfsctl          xfsctl support
>    qom-cast-debug  cast debugging support
> -  tools           build qemu-io, qemu-nbd and qemu-image tools
> +  tools           build qemu-io, qemu-nbd and qemu-img tools
>    vxhs            Veritas HyperScale vDisk backend support
>    bochs           bochs image format support
>    cloop           cloop image format support
> 

Fixes: c12d66aac1aa ("configure: add the missing help output for
optional features")

Perhaps the list can be updated with qemu-edid, ivshmem-client and elf2dmp?

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
