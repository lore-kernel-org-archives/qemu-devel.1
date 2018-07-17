Received: from eggs.gnu.org ([2001:4830:134:3::10]:42864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRII-0003f9-Um
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRIE-00089P-9o
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:49:39 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:32941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRIE-000899-3Y
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:49:34 -0400
Received: by mail-vk0-x244.google.com with SMTP id y70-v6so722935vkc.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:49:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f085fb59-5ccc-b009-6d4e-6ce76426d768@amsat.org>
Date: Tue, 17 Jul 2018 11:49:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 02/16] docker: base
 debian-tricore on qemu:debian9
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
> We need both git and a working compiler to build the tools. Although
> the qemu:debian9 image also has a bunch of extra dependencies it would
> be fairly unusual for a user not to already have this layer available
> for one of our many other docker images so lets not complicate things.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/dockerfiles/debian-tricore-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
> index 898b8dd511..180ca646c8 100644
> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -7,7 +7,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -FROM debian:9
> +FROM qemu:debian9
>  
>  MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
>  
> 
