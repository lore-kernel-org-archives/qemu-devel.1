Received: from eggs.gnu.org ([208.118.235.92]:58713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gfKn0-0001Tb-1Y
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gfKmw-0003P4-13
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:25:10 -0500
Received: from chuckie.co.uk ([82.165.15.123]:38621
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gfKmv-0003MT-RF
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 03:25:05 -0500
References: <20190103093704.32635-1-ppandit@redhat.com>
	<cd325b25-15ee-46e4-896e-e5904340b1bf@ilande.co.uk>
	<nycvar.YSQ.7.76.1901041111410.31402@xnncv>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <fcb58ca9-5019-5c46-24f8-3c09961ddd56@ilande.co.uk>
Date: Fri, 4 Jan 2019 08:24:56 +0000
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1901041111410.31402@xnncv>
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

On 04/01/2019 05:47, P J P wrote:

>   Hello Mark,
> 
> +-- On Thu, 3 Jan 2019, Mark Cave-Ayland wrote --+
> | >  /* Power */
> | > +static uint64_t power_mem_read(void *opaque, hwaddr addr, unsigned size)
> | > +{
> | > +    return 0xffffffff;
> | > +}
> | > +
> | >  
> | >  static const MemoryRegionOps power_mem_ops = {
> | > +    .read = power_mem_read,
> | >      .write = power_mem_write,
> | >      .endianness = DEVICE_NATIVE_ENDIAN,
> | >      .valid = {
> | 
> | Certainly the addition of the missing read function is valid, although I see that
> | you've defaulted reads to returning 0xffffffff - can you point me towards the source
> | that indicates that this behaviour matches that of real Ultra-5 hardware?
> 
>  -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02787.html
> 
> I haven't checked Ultra-5 h/w spec, return value was chosen similar to above 
> one, thinking unimplemented .read need not return success.
> 
> Thank you.

I asked someone with real Ultra-5 hardware to check this for me, and they've sent me
back the following output:

ok .properties
address                  fffb8000
button
interrupts               00000001
reg                      00000014 00724000 00000004
name                     power
ok fffb8000 l@ u.
0

Looks like the read value should be all 0s rather than all 1s. Can you resubmit the
patch with this change?


ATB,

Mark.
