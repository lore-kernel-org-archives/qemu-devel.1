Received: from eggs.gnu.org ([2001:4830:134:3::10]:51642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNO6K-00068o-KH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNO6K-0001xt-02
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:42:08 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNO6J-0001xG-Oz
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:42:07 -0400
Received: by mail-wr0-x22c.google.com with SMTP id r103so102754183wrb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 11:42:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170620163009.21764-1-f4bug@amsat.org>
References: <20170620163009.21764-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 19:41:46 +0100
Message-ID: <CAFEAcA9Ra6dvyDExJ9GaSMiNBcifdz7_FJvLKBznTyVX=ab5Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: fix tcg-interpreter build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

On 20 June 2017 at 17:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> fix regression from commit 244f144134:
>
>     $ make subdir-arm-softmmu
>     make[1]: *** No rule to make target 'tci.o', needed by 'qemu-system-a=
rm'.  Stop.
>     Makefile:328: recipe for target 'subdir-arm-softmmu' failed
>     make: *** [subdir-arm-softmmu] Error 2
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  Makefile.target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.target b/Makefile.target
> index 3d49f29457..0066579090 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -92,7 +92,7 @@ obj-y +=3D exec.o
>  obj-y +=3D accel/
>  obj-y +=3D tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
>  obj-y +=3D tcg/tcg-common.o tcg/tcg-runtime.o
> -obj-$(CONFIG_TCG_INTERPRETER) +=3D tci.o
> +obj-$(CONFIG_TCG_INTERPRETER) +=3D tcg/tci.o
>  obj-$(CONFIG_TCG_INTERPRETER) +=3D disas/tci.o
>  obj-y +=3D fpu/softfloat.o
>  obj-y +=3D target/$(TARGET_BASE_ARCH)/
> --
> 2.11.0

Applied to master as a buildfix; thanks.

(I should probably put a tcg-interpreter build in my local build tests,
but I'd prefer we just got rid of it.)

-- PMM
