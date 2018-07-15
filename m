Received: from eggs.gnu.org ([2001:4830:134:3::10]:52944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fepMh-0007rJ-Fw
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 18:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fepMe-0005T3-CJ
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 18:19:39 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fepMe-0005Sh-67
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 18:19:36 -0400
Received: by mail-qk0-x243.google.com with SMTP id b66-v6so19684018qkj.1
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 15:19:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180715211731.311B67456B5@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f5fc914b-ece0-a016-7eef-a6add340c54d@amsat.org>
Date: Sun, 15 Jul 2018 19:19:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180715211731.311B67456B5@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.0] sm501: Fix warning about
 unreachable code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 07/15/2018 05:59 PM, BALATON Zoltan wrote:
> Coverity warned that the false arm of conditional expression is
> unreachable when it is inside an if with the same condition.
> Remove the unreachable code to avoid the warning.
> 
> Fixes: CID 1394215
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/sm501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 9ab29d3..874260a 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1024,7 +1024,7 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
>                          if (res) {
>                              SM501_DPRINTF("sm501 i2c : transfer failed"
>                                            " i=%d, res=%d\n", i, res);
> -                            s->i2c_status |= (res ? SM501_I2C_STATUS_ERROR : 0);
> +                            s->i2c_status |= SM501_I2C_STATUS_ERROR;
>                              return;
>                          }
>                      }
> 
