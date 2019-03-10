Received: from eggs.gnu.org ([209.51.188.92]:39317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2zWx-0007U5-Ef
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2zWv-0004Td-Gs
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:34:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2zWn-0004QJ-NS
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:34:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id w2so2279358wrt.11
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 07:34:11 -0700 (PDT)
References: <20190310113408.59912-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <43275bae-952c-c044-0525-5e6592dbe58d@redhat.com>
Date: Sun, 10 Mar 2019 15:34:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190310113408.59912-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: test-bdrv-graph-mod: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, vsementsov@virtuozzo.com, kwolf@redhat.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org

On 3/10/19 12:34 PM, Li Qiang wrote:
> Fixes: 2dbfadf

  ^ Please keep tags together (with Signed-off-by, ...)

> Spotted by ASAN when 'make check'.

I'm not native English speaker but I'd say:

Spotted by ASAN [with] 'make check'.

or

Spotted by ASAN [while running] 'make check'.

Here goes:

"Fixes: 2dbfadf"

> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/test-bdrv-graph-mod.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
> index 458dfa6661..8bf0fe735d 100644
> --- a/tests/test-bdrv-graph-mod.c
> +++ b/tests/test-bdrv-graph-mod.c
> @@ -117,6 +117,7 @@ static void test_update_perm_tree(void)
>  
>      bdrv_unref(bs);
>      blk_unref(root);
> +    error_free(local_err);

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  }
>  
>  /*
> 
