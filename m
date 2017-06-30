Received: from eggs.gnu.org ([2001:4830:134:3::10]:52811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQsoL-00010s-Da
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQsoK-0003P8-CW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:06:01 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:33304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQsoK-0003OP-4l
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:06:00 -0400
Received: by mail-wm0-x22a.google.com with SMTP id z75so24003629wmc.0
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 03:06:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <199bd37fe51c4b240da9834673c065ea042b9897.1498756113.git.alistair.francis@xilinx.com>
References: <cover.1498756113.git.alistair.francis@xilinx.com>
	<199bd37fe51c4b240da9834673c065ea042b9897.1498756113.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jun 2017 11:05:38 +0100
Message-ID: <CAFEAcA9oucBm84kep7NHBM1UP6LRdRCfOAS7_buKo_8DTKjeSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/3] util/oslib-win32: Remove invalid
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>, Qemu-block <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>

On 29 June 2017 at 18:16, Alistair Francis <alistair.francis@xilinx.com> wr=
ote:
> There is no way nhandles can be zero in this section so that part of the
> if statement will always be false. Let's just remove it to make the code
> easier to read.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>
>  util/oslib-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 80e4668935..7ec0f8e083 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -414,7 +414,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *hand=
les, gint nhandles,
>          /* If we have a timeout, or no handles to poll, be satisfied
>           * with just noticing we have messages waiting.
>           */
> -        if (timeout !=3D 0 || nhandles =3D=3D 0) {
> +        if (timeout !=3D 0) {
>              return 1;
>          }

The comment and the code now don't match -- does the comment
need updating too?

thanks
-- PMM
