Received: from eggs.gnu.org ([2001:4830:134:3::10]:51411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhcT5-0003Kz-8y
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhcT1-0007ql-VO
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:09:47 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhcT1-0007qF-Lm
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:09:43 -0400
Received: by mail-wm0-x243.google.com with SMTP id s14-v6so1595740wmc.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 08:09:43 -0700 (PDT)
References: <20180717195553.9111-1-alex.bennee@linaro.org>
	<20180717195553.9111-10-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180717195553.9111-10-alex.bennee@linaro.org>
Date: Mon, 23 Jul 2018 16:09:41 +0100
Message-ID: <87k1pmt2dm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for 3.0 09/18] docker: disable
 debian-powerpc-user-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> While we can build we can't run the unit tests due to a missing system
> call (249 - swapcontext). This could be a code generation issue as
> other architectures don't seem to have this system call.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org

Dropping this patch now rth's setcontext fix is in.

> ---
>  tests/docker/Makefile.include | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 09fb7db7fa..fe63aacf69 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -140,6 +140,9 @@ docker-binfmt-image-debian-powerpc-user: QEMU_TARGET =
=3D ppc-linux-user
>  docker-binfmt-image-debian-powerpc-user: EXECUTABLE =3D ${BUILD_DIR}/ppc=
-linux-user/qemu-ppc
>  docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-power=
pc-user
>  DOCKER_USER_IMAGES +=3D debian-powerpc-user
> +# Unfortunalty while we can build with this image we can't run unit
> +# tests due to missing system call: 249 which causes an abort
> +DOCKER_PARTIAL_IMAGES +=3D debian-powerpc-user-cross
>
>  # Expand all the pre-requistes for each docker image and test combination
>  $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOC=
KER_DEPRECATED_IMAGES)), \


--
Alex Benn=C3=A9e
