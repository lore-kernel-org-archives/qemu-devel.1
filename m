Received: from eggs.gnu.org ([2001:4830:134:3::10]:46452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdy6l-0001vV-EJ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdy6i-0003bD-BI
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:27:39 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdy6h-0003aD-Qn
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:27:36 -0400
Received: by mail-wm0-x243.google.com with SMTP id n17-v6so9445821wmh.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 06:27:35 -0700 (PDT)
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-4-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180713121741.19262-4-alex.bennee@linaro.org>
Date: Fri, 13 Jul 2018 14:27:33 +0100
Message-ID: <87601jclkq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 03/16] shippable: Build the
 TriCore docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .shippable.yml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index f74a3de3ff..9670b13f8e 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -25,6 +25,8 @@ env:
>        TARGET_LIST=3Dmips64el-softmmu,mips64el-linux-user
>      - IMAGE=3Ddebian-ppc64el-cross
>        TARGET_LIST=3Dppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
> +    - IMAGE=3Ddebian-tricore-cross
> +      TARGET_LIST=3D
>  build:
>    pre_ci:
>      - make docker-image-${IMAGE} V=3D1

Serves me right for not waiting until the shippable build finished. This
needs to be dropped as while we can build the image we can't use it to
build anything.

--
Alex Benn=C3=A9e
