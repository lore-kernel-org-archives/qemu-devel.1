Received: from eggs.gnu.org ([2001:4830:134:3::10]:38037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@mailbox.org>) id 1dwnuL-0000DT-Vn
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@mailbox.org>) id 1dwnuG-0007b1-Ld
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:20:09 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:42527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@mailbox.org>)
	id 1dwnuG-0007Zq-BS
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:20:04 -0400
Date: Tue, 26 Sep 2017 13:19:57 +0200
From: Cornelia Huck <cornelia.huck@mailbox.org>
Message-ID: <20170926131957.2110cc1b.cornelia.huck@mailbox.org>
In-Reply-To: <bce18b05-2f0c-b032-36e4-23dd8558e826@linux.vnet.ibm.com>
References: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
	<20170926121800.1e9e1ac1.cohuck@redhat.com>
	<bce18b05-2f0c-b032-36e4-23dd8558e826@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/5] add CCW indirect data access support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>

[Restored cc:s]

On Tue, 26 Sep 2017 12:45:11 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/26/2017 12:18 PM, Cornelia Huck wrote:
> > On Thu, 21 Sep 2017 20:08:36 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> Abstract
> >> --------
> >>
> >> The objective of this series is introducing CCW IDA (indirect data
> >> access) support to our virtual channel subsystem implementation. Briefly
> >> CCW IDA can be thought of as a kind of a scatter gather support for a
> >> single CCW. If certain flags are set, the cda is to be interpreted as an
> >> address to a list which in turn holds further addresses designating the
> >> actual data.  Thus the scheme which we are currently using for accessing
> >> CCW payload does not work in general case. Currently there is no
> >> immediate need for proper IDA handling (no use case), but since it IDA is
> >> a non-optional part of the architecture, the only way towards AR
> >> compliance is actually implementing IDA.
> >>
> >> The focus of this patch set is introducing IDA support. There seems to be
> >> a potential for further  improvements based on the introduced
> >> infrastructure, but such improvements are intended to be discusses
> >> separately and realized as patches on top of this series.  
> > 
> > Hm, do you have a list of what you want to do as follow-on patches?
> > (Checking return codes, ...)
> > 
> > It's easy to lose track of all this :)
> >   
> 
> These are the stuff I had in mind:
> * handling errors (aka. checking error codes) in virtio-ccw
> * using residual count
> * converting 3270 (patches already sent)

The 3270 stuff is next in line for me.

> 
> And then some related stuff is the error reporting and handling
> rework for the IO instruction handlers and for the ccw interpretation
> emulation (later affects CcwDataStream).
> 
> There is probably a lot of potential for making things prettier
> in virtio-ccw.c too -- I've done some experiments but ended up changing
> too many things at the same time.

There's always potential for such things :) Let's get the previously
identified stuff out of the door first (it's not that I lack patches to
apply anyway...)

> 
> Btw, do we still have open issues with this series?

Currently going through my acceptance testing.
