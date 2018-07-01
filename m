Received: from eggs.gnu.org ([2001:4830:134:3::10]:56109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZjrm-0001Or-G4
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 17:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZjrj-0004BQ-Br
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 17:26:42 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZjrj-00041q-4Y
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 17:26:39 -0400
Received: by mail-wr0-x242.google.com with SMTP id h40-v6so2466988wrh.2
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 14:26:38 -0700 (PDT)
References: <20180629205232.27190-1-alex.bennee@linaro.org>
	<20180629205232.27190-22-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180629205232.27190-22-alex.bennee@linaro.org>
Date: Sun, 01 Jul 2018 22:26:36 +0100
Message-ID: <87d0w64pgz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 21/21] .shippable.yml: add linux-user
 cross-build for ppc-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Use our new ability to use linux-user powered docker images to build
> ppc-softmmu.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .shippable.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index f74a3de3ff..12f9d3b221 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -25,6 +25,14 @@ env:
>        TARGET_LIST=3Dmips64el-softmmu,mips64el-linux-user
>      - IMAGE=3Ddebian-ppc64el-cross
>        TARGET_LIST=3Dppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
> +    include:
> +      # Additional linux-user cross build
> +      - pre_ci:
> +          - ./configure --target-list=3Dppc-linux-user --static
> +          - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
> +          - make docker-image-powerpc-user-cross
> +        env: IMAGE=3Ddebian-image-powerpc-user-cross
> +             TARGET_LIST=3Dppc-softmmu

OK this doesn't work, back to the drawing board for the CI bit then.

>  build:
>    pre_ci:
>      - make docker-image-${IMAGE} V=3D1


--
Alex Benn=C3=A9e
