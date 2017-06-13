Received: from eggs.gnu.org ([2001:4830:134:3::10]:60983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dKruG-0004IB-Ij
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dKruD-0002Oi-H8
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:55:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dKruD-0002OV-Al
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:55:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id v104so33257705wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 12:55:13 -0700 (PDT)
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<20170608184944.19406-4-mrolnik@gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <4211d9f7-0d51-43eb-a441-099ea304c085@tuxfamily.org>
Date: Tue, 13 Jun 2017 21:55:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170608184944.19406-4-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v19 03/13] target-avr: adding a sample
 AVR board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, anichang@protonmail.ch

On 08.06.2017 20:49, Michael Rolnik wrote:
[...]
> diff --git a/hw/avr/sample.c b/hw/avr/sample.c
> new file mode 100644
> index 0000000000..7b03130680
> --- /dev/null
> +++ b/hw/avr/sample.c
> @@ -0,0 +1,108 @@
> +/*
> + * QEMU AVR CPU
> + *
> + * Copyright (c) 2016 Michael Rolnik
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +/*
> + *  NOTE:
> + *      This is not a real AVR board !!! This is an example !!!
> + *
> + *        This example can be used to build a real AVR board.
> + *
> + *      This example board loads provided binary file into flash memory and
> + *      executes it from 0x00000000 address in the code memory space.
> + *
> + *      Currently used for AVR CPU validation
> + *
> + */

Not sure if it useful for you, but you can nowadays also use the "null"
machine to execute some simple code (which can be loaded with the
"generic-loader" device) ... if that's already enough for your case, you
might get along without this "sample" board, too?

 Thomas
