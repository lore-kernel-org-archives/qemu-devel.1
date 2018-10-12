Received: from eggs.gnu.org ([2001:4830:134:3::10]:42468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAtyk-0001wt-Jz
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAtyd-0004Fi-3x
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:43:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAtyc-0004EP-Qh
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:43:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so11604271wmg.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 02:43:20 -0700 (PDT)
References: <153933509870.3834759.13291133122604475240.stgit@bahia.lan>
	<153933510947.3834759.3504000962964977142.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7b426297-35ae-1df3-8d37-54d572671d13@redhat.com>
Date: Fri, 12 Oct 2018 11:43:18 +0200
MIME-Version: 1.0
In-Reply-To: <153933510947.3834759.3504000962964977142.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr_pci: convert g_malloc() to
 g_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>

On 12/10/2018 11:05, Greg Kurz wrote:
> When allocating an array, it is a recommended coding practice to call
> g_new(FooType, n) instead of g_malloc(n * sizeof(FooType)) because
> it takes care to avoid overflow when calculating the size of the
> allocated block and it returns FooType *, which allows the compiler
> to perform type checking.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/ppc/spapr_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index c2271e6ed462..0537ce018f51 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1883,7 +1883,7 @@ static int spapr_pci_pre_save(void *opaque)
>      if (!sphb->msi_devs_num) {
>          return 0;
>      }
> -    sphb->msi_devs = g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_msi_mig));
> +    sphb->msi_devs = g_new(spapr_pci_msi_mig, sphb->msi_devs_num);
>  
>      g_hash_table_iter_init(&iter, sphb->msi);
>      for (i = 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
> 
> 
