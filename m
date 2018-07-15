Received: from eggs.gnu.org ([2001:4830:134:3::10]:48798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fejPK-0000zL-0b
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 11:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fejPG-0005rM-PP
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 11:57:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50880 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fejPG-0005pz-IE
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 11:57:54 -0400
References: <20180512000545.966-1-cyrus296@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2645955d-3d57-3bc8-9325-07fb6830ac78@redhat.com>
Date: Sun, 15 Jul 2018 17:57:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180512000545.966-1-cyrus296@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/2] Fix UART serial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Calvin Lee <cyrus296@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, dgilbert@redhat.com

On 12/05/2018 02:05, Calvin Lee wrote:
> While developing a serial implementation for my OS, I found several bugs
> in QEMU's serial device. I confirmed (by testing on my x64 laptop) that
> there are several inconsistancies between QEMU and hardware in this
> regard. For both patches, I used "http://www.sci.muni.cz/docs/pc/serport.txt"
> for reference.
> 
> First, QEMU has several errors for setting the UART divisor that are
> fixed in my first patch. Second, (and more importantly) QEMU does not
> transmit serial bytes at the correct rate, and this is fixed in my
> second patch.

Hi Calvin,

I am queuing the first patch.  Regarding the second, it's been debated
quite a few times over the years whether QEMU should respect the
transmit rate or not.  The main advantage of not doing so is that some
OSes use the serial port pretty heavily (e.g. Linux for boot messages,
or Windows for debugging), and throttling the serial port to just e.g.
115200 bps makes them unnecessarily slow.

Paolo
