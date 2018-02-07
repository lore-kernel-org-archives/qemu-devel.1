Received: from eggs.gnu.org ([2001:4830:134:3::10]:41921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejRcU-00035w-Af
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejRcR-0004mQ-5J
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:26:46 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejRcR-0004mC-0y
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:26:43 -0500
Received: by mail-qt0-x241.google.com with SMTP id z10so2116797qti.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 07:26:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180207151925.26325-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5b4c1a42-2a75-56f0-d9f1-3a9b2df00bec@amsat.org>
Date: Wed, 7 Feb 2018 12:26:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180207151925.26325-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] .travis.yml: add --disable-linux-user for
 some jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 02/07/2018 12:19 PM, Alex Bennée wrote:
> The modules and co-routine builds are only really relevant to softmmu
> builds and regularly timeout on Travis. Let's disable linux-user
> builds here for more headroom.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .travis.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index f583839755..a6bd01b0a1 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -51,9 +51,9 @@ env:
>      - CONFIG=""
>      - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
>      - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb"
> -    - CONFIG="--enable-modules"
> -    - CONFIG="--with-coroutine=ucontext"
> -    - CONFIG="--with-coroutine=sigaltstack"
> +    - CONFIG="--enable-modules --disable-linux-user"
> +    - CONFIG="--with-coroutine=ucontext --disable-linux-user"
> +    - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
>  git:
>    # we want to do this ourselves
>    submodules: false
> 
