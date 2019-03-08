Received: from eggs.gnu.org ([209.51.188.92]:60364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Gos-0007TF-7n
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2Goq-0004RM-Gk
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:49:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2Goq-0004JF-98
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:49:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so21651453wre.10
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 06:49:52 -0800 (PST)
References: <20190308135744.6480-1-peter.maydell@linaro.org>
	<20190308135744.6480-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d4536c2e-3419-07b0-49a0-ac17a374218a@redhat.com>
Date: Fri, 8 Mar 2019 15:49:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190308135744.6480-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] Makefile: Fix 'make distclean'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 3/8/19 2:57 PM, Peter Maydell wrote:
> We forgot the '-r' option on the rm command to clean up the
> Sphinx .doctrees working directory, which meant that
> "make distclean" fails:
>  rm: cannot remove '.doctrees': Is a directory
> 
> Add the missing option.
> 
> Fixes: 5f71eac06e15b9a3fa1134d446f ("Makefile, configure: Support building rST documentation")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 0194ef7fa55..9fd7f3f9bfb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -691,7 +691,7 @@ distclean: clean
>  	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
>  	rm -f docs/qemu-block-drivers.7
>  	rm -f docs/qemu-cpu-models.7
> -	rm -f .doctrees
> +	rm -rf .doctrees
>  	$(call clean-manual,devel)
>  	$(call clean-manual,interop)
>  	for d in $(TARGET_DIRS); do \
> 
