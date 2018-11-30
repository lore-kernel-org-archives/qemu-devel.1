Received: from eggs.gnu.org ([2001:4830:134:3::10]:36110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSmYc-0004rF-JO
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSmYY-0002sn-L8
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:26:26 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSmYW-0002rT-If
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:26:20 -0500
Received: by mail-oi1-x241.google.com with SMTP id b141so5343151oii.12
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-4-minyard@acm.org>
In-Reply-To: <20181126200435.23408-4-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 17:26:08 +0000
Message-ID: <CAFEAcA9RcGMUb_sMkGZ3ORWpug1V5XwWuA66MNAV-npna-hN-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 03/16] arm:i2c: Don't mask return from
 i2c_recv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On Mon, 26 Nov 2018 at 20:04, <minyard@acm.org> wrote:
>
> From: Corey Minyard <cminyard@mvista.com>
>
> It can't fail, and now that it returns a uint8_t a 0xff mask
> is unnecessary.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/stellaris.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 6c69ce79b2..638b649911 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -811,7 +811,7 @@ static void stellaris_i2c_write(void *opaque, hwaddr offset,
>              /* TODO: Handle errors.  */
>              if (s->msa & 1) {
>                  /* Recv */
> -                s->mdr = i2c_recv(s->bus) & 0xff;
> +                s->mdr = i2c_recv(s->bus);
>              } else {
>                  /* Send */

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
