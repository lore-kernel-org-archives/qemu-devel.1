Received: from eggs.gnu.org ([2001:4830:134:3::10]:34570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo12-000735-LQ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo11-0001z7-S9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:08:56 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCo11-0001yv-MB
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:08:55 -0400
Received: by mail-wm0-x234.google.com with SMTP id d127so153256462wmf.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 07:08:55 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-18-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-18-f4bug@amsat.org>
Date: Mon, 22 May 2017 15:08:58 +0100
Message-ID: <87y3tp2dc5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 17/24] shippable: build using all
 available cpus
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

> As of this commit:
>
> $ echo "container proc:" `getconf _NPROCESSORS_ONLN` `getconf _NPROCESSORS_CONF`
> container proc: 2 2
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .shippable.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index 231c29b620..1e3ae35dd9 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -20,4 +20,4 @@ build:
>    ci:
>      - unset CC
>      - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
> -    - make -j2
> +    - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))


--
Alex Bennée
