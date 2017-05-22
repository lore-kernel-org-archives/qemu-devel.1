Received: from eggs.gnu.org ([2001:4830:134:3::10]:35681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo52-0001nu-HC
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo4z-0004D3-4u
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:13:04 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCo4y-0004CT-Uz
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:13:01 -0400
Received: by mail-wr0-x22a.google.com with SMTP id z52so39468837wrc.2
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 07:13:00 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-22-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-22-f4bug@amsat.org>
Date: Mon, 22 May 2017 15:13:04 +0100
Message-ID: <87shjx2d5b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 21/24] shippable: add powerpc target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .shippable.yml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index 2070c4d827..aad66ec5ec 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -11,6 +11,8 @@ env:
>        TARGET_LIST=aarch64-softmmu,aarch64-linux-user
>      - IMAGE=debian-s390x-cross
>        TARGET_LIST=s390x-softmmu,s390x-linux-user
> +    - IMAGE=debian-powerpc-cross
> +      TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
>  build:
>    pre_ci:
>      - make docker-image-${IMAGE} V=1


--
Alex Bennée
