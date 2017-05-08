Received: from eggs.gnu.org ([2001:4830:134:3::10]:44679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gcs-0001lN-16
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gco-0004gl-Sd
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:14:50 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gco-0004fO-Mt
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:14:46 -0400
Received: by mail-wr0-x235.google.com with SMTP id l50so40658400wrc.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:14:46 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-17-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-17-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:15:29 +0100
Message-ID: <871srza9bi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/23] shippable: do not initialize
 submodules automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> do it in the 'ci' target when needed.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .shippable.yml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index fa2d6a4e9b..b3cbca458c 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -1,4 +1,6 @@
>  language: c
> +git:
> +   submodules: false
>  env:
>    global:
>      - LC_ALL=C

Maybe this should be merged with the next patch?

--
Alex Bennée
