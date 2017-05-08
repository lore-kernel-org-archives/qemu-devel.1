Received: from eggs.gnu.org ([2001:4830:134:3::10]:46179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gjp-0005kS-NH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gjm-0006z6-Il
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:22:01 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gjm-0006ym-C6
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:21:58 -0400
Received: by mail-wm0-x230.google.com with SMTP id m123so61046737wma.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:21:58 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508050230.22039-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508050230.22039-1-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:22:41 +0100
Message-ID: <87vapb8uf2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/23] shippable: temporary disable
 mips64el-softmmu build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .shippable.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index 6601243060..7e714991f9 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -15,8 +15,9 @@ env:
>        TARGET_LIST=aarch64-softmmu,aarch64-linux-user
>      - IMAGE=debian-s390x-cross
>        TARGET_LIST=s390x-softmmu,s390x-linux-user
> +    # mips64el-softmmu disabled due to libfdt problem
>      - IMAGE=debian-mipsel-cross
> -      TARGET_LIST=mipsel-softmmu,mips64el-softmmu,mipsel-linux-user,mips64el-linux-user
> +      TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
>  build:
>    pre_ci:
>      - make docker-image-${IMAGE}


If you fix the order of your patches you can get rid of this noise.

--
Alex Bennée
