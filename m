Received: from eggs.gnu.org ([2001:4830:134:3::10]:47655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHiH-0007hR-UP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHiD-0003Vo-9t
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:53:26 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etHiD-0003Uc-2n
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:53:21 -0500
Received: by mail-wm0-x242.google.com with SMTP id a20so19335592wmd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 10:53:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306153951.1644-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6e45da44-53fd-a3d9-a84a-c90dba557e76@amsat.org>
Date: Tue, 6 Mar 2018 15:53:18 -0300
MIME-Version: 1.0
In-Reply-To: <20180306153951.1644-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] .shippable.yml: disable powerpc-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, peter.maydell@linaro.org

Hi Alex,

On 03/06/2018 12:39 PM, Alex Bennée wrote:
> Something has happened to the old emdebian setup which means it no
> longer builds. Let's disable the shippable builds which are always
> failing.

I read your comment on IRC and talked with Debian people, but couldn't
resolve this yet :(

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

In the meantime:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks,

Phil.

> ---
>  .shippable.yml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/.shippable.yml b/.shippable.yml
> index dd4bbc84b1..60f2ce9218 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -23,8 +23,6 @@ env:
>        TARGET_LIST=mips-softmmu,mipsel-linux-user
>      - IMAGE=debian-mips64el-cross
>        TARGET_LIST=mips64el-softmmu,mips64el-linux-user
> -    - IMAGE=debian-powerpc-cross
> -      TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
>      - IMAGE=debian-ppc64el-cross
>        TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
>  build:
> 
