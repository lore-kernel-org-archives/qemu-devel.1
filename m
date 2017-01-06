Received: from eggs.gnu.org ([2001:4830:134:3::10]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1cPaBY-0005MC-Lu
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1cPaBV-0006sp-FP
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:28:20 -0500
Date: Fri, 06 Jan 2017 20:28:09 +0100
In-Reply-To: <1483724714-5469-1-git-send-email-peter.maydell@linaro.org>
References: <1483724714-5469-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Michael Walle <michael@walle.cc>
Message-ID: <DE593C1D-BF88-4ABD-99F5-176D9090538A@walle.cc>
Subject: Re: [Qemu-devel] [PATCH] lm32: milkymist-tmu2: fix another integer
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

Am 6=2E Januar 2017 18:45:14 MEZ schrieb Peter Maydell <peter=2Emaydell@lin=
aro=2Eorg>:
>Don't truncate the multiplication and do a 64 bit one instead
>because the result is stored in a 64 bit variable=2E
>
>This fixes a similar coverity warning to commit 237a8650d640,
>in a similar way, and is the other half of the fix for
>coverity CID 1167561=2E
>
>Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>

Acked-by: Michael Walle <michael@walle=2Ecc>

>---
> hw/display/milkymist-tmu2=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/display/milkymist-tmu2=2Ec b/hw/display/milkymist-tmu2=2E=
c
>index 5c666f9=2E=2E920374b 100644
>--- a/hw/display/milkymist-tmu2=2Ec
>+++ b/hw/display/milkymist-tmu2=2Ec
>@@ -257,7 +257,7 @@ static void tmu2_start(MilkymistTMU2State *s)
>     glColor4f(m, m, m, (float)(s->regs[R_ALPHA] + 1) / 64=2E0f);
>=20
>     /* Read the QEMU dest=2E framebuffer into the OpenGL framebuffer */
>-    fb_len =3D 2 * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
>+    fb_len =3D 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
>     fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 0);
>     if (fb =3D=3D NULL) {
>         glDeleteTextures(1, &texture);
