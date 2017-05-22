Received: from eggs.gnu.org ([2001:4830:134:3::10]:35647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo4q-0001dI-5P
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo4m-00047K-8v
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:12:52 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCo4m-00046S-2e
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:12:48 -0400
Received: by mail-wm0-x22e.google.com with SMTP id e127so39684071wmg.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 07:12:48 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-21-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-21-f4bug@amsat.org>
Date: Mon, 22 May 2017 15:12:50 +0100
Message-ID: <87tw4d2d5p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 20/24] shippable: add armeb-linux-user
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .shippable.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index fe360f85cb..2070c4d827 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -6,7 +6,7 @@ env:
>      - LC_ALL=C
>    matrix:
>      - IMAGE=debian-armhf-cross
> -      TARGET_LIST=arm-softmmu,arm-linux-user
> +      TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
>      - IMAGE=debian-arm64-cross
>        TARGET_LIST=aarch64-softmmu,aarch64-linux-user
>      - IMAGE=debian-s390x-cross


--
Alex Bennée
