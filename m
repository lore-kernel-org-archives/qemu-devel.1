Received: from eggs.gnu.org ([2001:4830:134:3::10]:50446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiXM-0000cy-Iy
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiXJ-0002ip-7X
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCiXI-0002d5-Td
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:54:41 -0400
References: <20181017094406.4844-1-maozhongyi@cmss.chinamobile.com>
	<20181017094406.4844-4-maozhongyi@cmss.chinamobile.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <134b72ef-0f6a-dd71-e761-0d4ae23e31cf@redhat.com>
Date: Wed, 17 Oct 2018 11:54:32 +0200
MIME-Version: 1.0
In-Reply-To: <20181017094406.4844-4-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] po/Makefile: Modern shell scripting
 (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, peter.maydell@linaro.org, sw@weilnetz.de

On 2018-10-17 11:44, Mao Zhongyi wrote:
> Various shell files contain a mix between obsolete ``
> and modern $(); It would be nice to convert to using $()
> everywhere.
> 
> Cc: philmd@redhat.com
> Cc: peter.maydell@linaro.org
> Cc: thuth@redhat.com
> Cc: sw@weilnetz.de
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  po/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/po/Makefile b/po/Makefile
> index e47e262ee6..10605e8eb3 100644
> --- a/po/Makefile
> +++ b/po/Makefile
> @@ -36,7 +36,7 @@ clean:
>  
>  install: $(OBJS)
>  	for obj in $(OBJS); do \
> -	    base=`basename $$obj .mo`; \
> +	    base=$(basename $$obj .mo); \

You're changing a Makefile here, so you need to "escape" the "$" by
doubling it:

	base=$$(basename $$obj .mo); \

 Thomas
