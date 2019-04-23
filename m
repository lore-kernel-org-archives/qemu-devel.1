Received: from eggs.gnu.org ([209.51.188.92]:43995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ45a-0004iA-LN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3zo-0004ER-D4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:34:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3zo-0004DD-66
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:34:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so22188258wra.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:34:36 -0700 (PDT)
References: <20190423160608.7519-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <319f3544-a107-416f-ff8a-3501943f1821@redhat.com>
Date: Wed, 24 Apr 2019 00:34:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190423160608.7519-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] net: Print output of "-net nic,
 model=help" to stdout instead of stderr
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

On 4/23/19 6:06 PM, Thomas Huth wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
