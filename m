Received: from eggs.gnu.org ([208.118.235.92]:54462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gfIL4-0000qx-1O
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gfIKy-00028x-V8
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:48:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gfIKy-000259-Pc
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:48:04 -0500
Date: Fri, 4 Jan 2019 11:17:54 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <cd325b25-15ee-46e4-896e-e5904340b1bf@ilande.co.uk>
Message-ID: <nycvar.YSQ.7.76.1901041111410.31402@xnncv>
References: <20190103093704.32635-1-ppandit@redhat.com>
	<cd325b25-15ee-46e4-896e-e5904340b1bf@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] sun4u: add power_mem_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>

  Hello Mark,

+-- On Thu, 3 Jan 2019, Mark Cave-Ayland wrote --+
| >  /* Power */
| > +static uint64_t power_mem_read(void *opaque, hwaddr addr, unsigned size)
| > +{
| > +    return 0xffffffff;
| > +}
| > +
| >  
| >  static const MemoryRegionOps power_mem_ops = {
| > +    .read = power_mem_read,
| >      .write = power_mem_write,
| >      .endianness = DEVICE_NATIVE_ENDIAN,
| >      .valid = {
| 
| Certainly the addition of the missing read function is valid, although I see that
| you've defaulted reads to returning 0xffffffff - can you point me towards the source
| that indicates that this behaviour matches that of real Ultra-5 hardware?

 -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02787.html

I haven't checked Ultra-5 h/w spec, return value was chosen similar to above 
one, thinking unimplemented .read need not return success.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
