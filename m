Received: from eggs.gnu.org ([2001:4830:134:3::10]:32792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRNVR-0006h9-QK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRNVO-0002yk-Ld
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:29:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRNVO-0002ya-G3
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:29:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so19522080wmc.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:29:18 -0800 (PST)
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-4-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8bbcc21a-5f9b-5e49-243d-bcf5badfd212@redhat.com>
Date: Mon, 26 Nov 2018 21:29:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200435.23408-4-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: minyard@acm.org, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 26/11/18 21:04, minyard@acm.org wrote:
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
>                  i2c_send(s->bus, s->mdr);
> 

This could be squashed in the previous patch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
