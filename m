Received: from eggs.gnu.org ([2001:4830:134:3::10]:57039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Xip-0006MW-Dt
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Xio-0005ht-Bc
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:13:11 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:33660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9Xio-0005gd-6u
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:13:10 -0400
Received: by mail-ot0-x230.google.com with SMTP id w2-v6so9978020otj.0
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 08:13:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152423701463.2118.8532788783924003585@71c20359a636>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<152423701463.2118.8532788783924003585@71c20359a636>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 16:12:49 +0100
Message-ID: <CAFEAcA_O5nnd2NLHOuJocy4vh0StaK_Z_p3yn8Q4vvdAUUwuNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/13] Drop compile time limit on number of
 serial ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 20 April 2018 at 16:10,  <no-reply@patchew.org> wrote:

> Checking PATCH 7/13: Change references to serial_hds[] to serial_hd()...
> WARNING: line over 80 characters
> #581: FILE: hw/cris/axis_dev88.c:340:
> +        etraxfs_ser_create(0x30026000 + i * 0x2000, irq[0x14 + i], serial_hd(i));
>
> ERROR: spaces required around that '/' (ctx:VxV)
> #824: FILE: hw/moxie/moxiesim.c:146:
> +                       8000000/16, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>                                ^
>
> total: 1 errors, 1 warnings, 852 lines checked

These are in the "mechanical change only" patch, so I didn't
want to change anything else there.

> Checking PATCH 12/13: vl.c: Remove compile time limit on number of serial ports...
> ERROR: do not initialise statics to 0 or NULL
> #35: FILE: vl.c:157:
> +static int num_serial_hds = 0;
>
> ERROR: do not initialise statics to 0 or NULL
> #36: FILE: vl.c:158:
> +static Chardev **serial_hds = NULL;

I'd forgotten checkpatch had this requirement; easy to fix.

thanks
-- PMM
