Received: from eggs.gnu.org ([2001:4830:134:3::10]:42990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gUR-00068n-Q3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gUN-0002lp-Un
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:06:07 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gUN-0002lP-BC
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:06:03 -0400
Received: by mail-wm0-x22b.google.com with SMTP id u65so80322031wmu.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:06:03 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-12-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-12-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:06:46 +0100
Message-ID: <877f1ra9q1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/23] shippable: add mipsel target
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
>  .shippable.yml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index b661e667b3..fa2d6a4e9b 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -13,6 +13,8 @@ env:
>        TARGET_LIST=aarch64-softmmu,aarch64-linux-user
>      - IMAGE=debian-s390x-cross
>        TARGET_LIST=s390x-softmmu,s390x-linux-user
> +    - IMAGE=debian-mipsel-cross
> +      TARGET_LIST=mipsel-softmmu,mips64el-softmmu,mipsel-linux-user,mips64el-linux-user
>  build:
>    pre_ci:
>      - make docker-image-${IMAGE}

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
