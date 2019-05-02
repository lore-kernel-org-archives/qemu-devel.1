Received: from eggs.gnu.org ([209.51.188.92]:56060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7jQ-00038a-O0
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7jB-0005oP-Sy
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:10:11 -0400
References: <20190423160608.7519-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <33e682e0-59e3-14f6-8f87-471ceea2657f@vivier.eu>
Date: Thu, 2 May 2019 11:07:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190423160608.7519-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] net: Print output of "-net
 nic, model=help" to stdout instead of stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 23/04/2019 18:06, Thomas Huth wrote:
> We are printing all other help output to stdout already (e.g. "-help",
> "-cpu help" and "-machine help" output). So the "-net nic,model=help"
> output should go to stdout instead of stderr, too. And while we're at
> it, also print the NICs line by line, like we do it e.g. with the
> "-cpu help" or "-M help" output, too.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1574327
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  net/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/net.c b/net/net.c
> index f3a3c5444c..2cf5e76469 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -837,9 +837,10 @@ int qemu_show_nic_models(const char *arg, const char *const *models)
>          return 0;
>      }
>  
> -    fprintf(stderr, "qemu: Supported NIC models: ");
> -    for (i = 0 ; models[i]; i++)
> -        fprintf(stderr, "%s%c", models[i], models[i+1] ? ',' : '\n');
> +    printf("Supported NIC models:\n");
> +    for (i = 0 ; models[i]; i++) {
> +        printf("%s\n", models[i]);
> +    }
>      return 1;
>  }
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
