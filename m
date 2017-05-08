Received: from eggs.gnu.org ([2001:4830:134:3::10]:40776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gJc-0001wc-Hm
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gJZ-00005U-HO
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:54:56 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gJZ-00005H-Ao
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:54:53 -0400
Received: by mail-wr0-x22e.google.com with SMTP id l9so40221163wre.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 03:54:53 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-3-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-3-f4bug@amsat.org>
Date: Mon, 08 May 2017 11:55:36 +0100
Message-ID: <87bmr3aa8n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/23] shippable: build using all available
 cpus
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

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .shippable.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index 231c29b620..5170486ff9 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -20,4 +20,4 @@ build:
>    ci:
>      - unset CC
>      - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
> -    - make -j2
> +    - make -j$(getconf _NPROCESSORS_ONLN)

Did you ever check what this generates on Shippable? AFAICT they only
have one core for each docker image. I following the core+1 pattern
although that may not make as much sense for low core counts.

--
Alex Bennée
