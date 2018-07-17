Received: from eggs.gnu.org ([2001:4830:134:3::10]:49664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG4a-0001pB-Np
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG4W-0000vB-QH
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:50:44 -0400
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:41030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG4W-0000v2-Kn
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:50:40 -0400
Received: by mail-vk0-x229.google.com with SMTP id j11-v6so22784652vke.8
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:50:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d3c79e7e-3550-d57a-ad9f-699ca923b6c0@amsat.org>
Date: Mon, 16 Jul 2018 23:50:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 05/16] docker: split
 configure_qemu from build_qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 07/13/2018 09:17 AM, Alex Bennée wrote:
> This allows some tests that just want to configure QEMU's source tree
> to do so.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/common.rc | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 046f8a5921..ba1f942328 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -21,7 +21,7 @@ requires()
>      done
>  }
>  
> -build_qemu()
> +configure_qemu()
>  {
>      config_opts="--enable-werror \
>                   ${TARGET_LIST:+--target-list=${TARGET_LIST}} \
> @@ -32,6 +32,11 @@ build_qemu()
>      echo $config_opts
>      $QEMU_SRC/configure $config_opts || \
>          { cat config.log && test_fail "Failed to run 'configure'"; }
> +}
> +
> +build_qemu()
> +{
> +    configure_qemu $@
>      make $MAKEFLAGS
>  }
>  
> 
