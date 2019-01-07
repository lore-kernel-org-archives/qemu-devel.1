Received: from eggs.gnu.org ([209.51.188.92]:60470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ggUVj-0001k8-Cb
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ggUVi-0004Jn-Kn
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:00:07 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41755
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ggUVi-0004Eo-Ec
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:00:06 -0500
References: <20190103093704.32635-1-ppandit@redhat.com>
	<cd325b25-15ee-46e4-896e-e5904340b1bf@ilande.co.uk>
	<nycvar.YSQ.7.76.1901041111410.31402@xnncv>
	<fcb58ca9-5019-5c46-24f8-3c09961ddd56@ilande.co.uk>
	<nycvar.YSQ.7.76.1901041521590.2878@xnncv>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3c112d5b-a2c7-0e41-71d3-0a1c16a6a708@ilande.co.uk>
Date: Mon, 7 Jan 2019 12:59:50 +0000
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1901041521590.2878@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sun4u: add power_mem_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On 04/01/2019 09:53, P J P wrote:

> +-- On Fri, 4 Jan 2019, Mark Cave-Ayland wrote --+
> | I asked someone with real Ultra-5 hardware to check this for me, and they've 
> | sent me back the following output:
> | 
> | ok .properties
> | address                  fffb8000
> | button
> | interrupts               00000001
> | reg                      00000014 00724000 00000004
> | name                     power
> | ok fffb8000 l@ u.
> | 0
> | 
> | Looks like the read value should be all 0s rather than all 1s. Can you resubmit the
> | patch with this change?
> 
> Done. Sent patch v1.

Thanks. I've applied this to my qemu-sparc branch.


ATB,

Mark.
