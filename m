Received: from eggs.gnu.org ([2001:4830:134:3::10]:46280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dqEAB-0005fV-FN
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dqEA6-000814-VD
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:57:19 -0400
Date: Fri, 8 Sep 2017 09:57:05 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170908075705.GA16888@vader>
References: <20170901110332.32650-1-otubo@redhat.com>
	<20170901143016.GK7570@localhost.localdomain>
	<20170902091520.bxecfhisvy46o4cb@aurel32.net>
	<CABgObfZ-CthwUFC-E2QTxnpqYZ-Sr_f_M3-FdmH6tQPdjG3OAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfZ-CthwUFC-E2QTxnpqYZ-Sr_f_M3-FdmH6tQPdjG3OAg@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] dma/i82374: avoid double
 creation of i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Jarno, Aurelien" <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, "Gibson, David" <david@gibson.dropbear.id.au>

On Thu, Sep 07, 2017 at 06:05:37PM +0200, Paolo Bonzini wrote:
> Il 02 set 2017 11:17 AM, "Aurelien Jarno" <aurelien@aurel32.net> ha scritto:
> 
> On 2017-09-01 11:30, Eduardo Habkost wrote:
> > i82374 is compiled in only on ppc and sh4, so I'm CCing the
> > maintainers for those architectures.
> 
> The i82374 device is not useful nor usable on SH4. It has just been
> added in commit 85d3846a39 to be able to run the tests.
> 
> 
> But that means that the patch is wrong and probably was not tested with
> "make check".
> 
> Eduardo's proposal is the right one.
> 

Great, I'll just add the missing details and resend the v2. Thanks for
the review.

Regards,

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
