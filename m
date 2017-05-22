Received: from eggs.gnu.org ([2001:4830:134:3::10]:46266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCqVI-0004rl-G5
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCqVF-0003JI-E9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:48:20 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:33909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCqVF-0003IZ-6I
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:48:17 -0400
Received: by mail-wm0-x231.google.com with SMTP id 123so13219647wmg.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 09:48:17 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-23-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-23-f4bug@amsat.org>
Date: Mon, 22 May 2017 17:48:19 +0100
Message-ID: <87r2zg3kj0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 22/24] shippable: add mipsel target
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .shippable.yml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index aad66ec5ec..75c2895a21 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -13,6 +13,9 @@ env:
>        TARGET_LIST=s390x-softmmu,s390x-linux-user
>      - IMAGE=debian-powerpc-cross
>        TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
> +    # mips64el-softmmu disabled due to libfdt problem
> +    - IMAGE=debian-mipsel-cross
> +      TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
>  build:
>    pre_ci:
>      - make docker-image-${IMAGE} V=1


--
Alex Bennée
