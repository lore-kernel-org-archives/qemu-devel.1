Received: from eggs.gnu.org ([2001:4830:134:3::10]:55737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBrse-0000RH-HN
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBrsb-0003Cg-EG
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:04:24 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBrsb-0003CP-9N
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:04:21 -0400
Received: by mail-oi0-x244.google.com with SMTP id w138so14751848oiw.3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 17:04:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170429104937.31341-1-zxq_yx_007@163.com>
	<20170429104937.31341-7-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f9e167b5-bf79-d638-e01a-5070929feb15@amsat.org>
Date: Fri, 19 May 2017 21:04:18 -0300
MIME-Version: 1.0
In-Reply-To: <20170429104937.31341-7-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/9] hw/timer: QOM'ify m48txx_sysbus
 (pass 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au

On 04/29/2017 07:49 AM, xiaoqiang zhao wrote:
> assign DeviceClass::vmsd instead of using vmstate_register function
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/timer/m48t59.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
> index eff259ef96..3a9f541c9b 100644
> --- a/hw/timer/m48t59.c
> +++ b/hw/timer/m48t59.c
> @@ -640,8 +640,6 @@ void m48t59_realize_common(M48t59State *s, Error **errp)
>          s->wd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &watchdog_cb, s);
>      }
>      qemu_get_timedate(&s->alarm, 0);
> -
> -    vmstate_register(NULL, -1, &vmstate_m48t59, s);
>  }
>
>  static void m48t59_init1(Object *obj)
> @@ -702,6 +700,7 @@ static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
>      dc->realize = m48t59_realize;
>      dc->reset = m48t59_reset_sysbus;
>      dc->props = m48t59_sysbus_properties;
> +    dc->vmsd = &vmstate_m48t59;
>      nc->read = m48txx_sysbus_read;
>      nc->write = m48txx_sysbus_write;
>      nc->toggle_lock = m48txx_sysbus_toggle_lock;
>
