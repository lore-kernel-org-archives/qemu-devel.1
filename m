Received: from eggs.gnu.org ([2001:4830:134:3::10]:38455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebmZ1-0000VL-W3
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebmYx-0001TJ-V2
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:11:31 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:42776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ebmYx-0001Sg-Ov
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:11:27 -0500
Received: by mail-wm0-x243.google.com with SMTP id b141so14864995wme.1
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 04:11:27 -0800 (PST)
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-9-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180115143500.22631-9-f4bug@amsat.org>
Date: Wed, 17 Jan 2018 12:11:25 +0000
Message-ID: <87zi5cn0r6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] docker: fix typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 950ef51d35..a833c68cd8 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -47,7 +47,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>
>  docker-image-debian-powerpc-cross: EXTRA_FILES:=3D$(SRC_PATH)/tests/dock=
er/dockerfiles/debian-apt-fake.sh
>
> -# Enforce dependancies for composite images
> +# Enforce dependencies for composite images
>  docker-image-debian: docker-image-debian9
>  docker-image-debian8-mxe: docker-image-debian8
>  docker-image-debian-amd64: docker-image-debian9


--
Alex Benn=C3=A9e
