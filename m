Received: from eggs.gnu.org ([2001:4830:134:3::10]:50587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX2Uz-0008AC-Io
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX2Uv-0001Aj-Lf
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:39:29 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX2Uv-0001Ab-F0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:39:25 -0400
Received: by mail-wm0-x22c.google.com with SMTP id w126so70359499wme.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 02:39:25 -0700 (PDT)
References: <20170711031000.24844-1-f4bug@amsat.org>
	<20170711031000.24844-19-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170711031000.24844-19-f4bug@amsat.org>
Date: Mon, 17 Jul 2017 10:39:22 +0100
Message-ID: <87eftf8ks5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 18/18] shippable: restrict builds to
 master/staging and shippable* branches
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

Why? Don't this stop people testing their feature branches?


> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .shippable.yml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index 4c8a85941f..1f05d934e4 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -1,6 +1,11 @@
>  language: c
>  git:
>     submodules: false
> +branches:
> +  only:
> +    - master
> +    - staging
> +    - shippable*
>  env:
>    global:
>      - LC_ALL=C


--
Alex Bennée
