Received: from eggs.gnu.org ([2001:4830:134:3::10]:47597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Yu9-0007cs-Nb
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Yu6-0003p0-IQ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:28:57 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:39342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Yu6-0003oq-E3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:28:54 -0400
Received: by mail-qk0-x242.google.com with SMTP id i73so9189498qke.6
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 09:28:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <99068580-c8b1-438e-8289-e2e044a59aa5@amsat.org>
Date: Fri, 20 Apr 2018 13:28:50 -0300
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/13] hw/char/serial: Allow disconnected
 chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04/20/2018 11:52 AM, Peter Maydell wrote:
> Currently the serial.c realize code has an explicit check that it is not
> connected to a disconnected backend (ie one with a NULL chardev).
> This isn't what we want -- you should be able to create a serial device
> even if it isn't attached to anything. Remove the check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/char/serial.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index eb72191ee7..2c080c9862 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -923,11 +923,6 @@ static int serial_be_change(void *opaque)
>  
>  void serial_realize_core(SerialState *s, Error **errp)
>  {
> -    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> -        error_setg(errp, "Can't create serial device, empty char device");
> -        return;
> -    }
> -
>      s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
>  
>      s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
> 
