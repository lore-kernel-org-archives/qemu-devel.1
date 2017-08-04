Received: from eggs.gnu.org ([2001:4830:134:3::10]:37787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddVoQ-0007La-Q1
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddVoM-0003eY-I6
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:10:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ddVoM-0003cW-CR
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:10:14 -0400
Date: Fri, 4 Aug 2017 02:10:11 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <637661261.1409588.1501827011350.JavaMail.zimbra@redhat.com>
In-Reply-To: <41045776-f4c2-20f5-1000-c826e314cfe2@suse.de>
References: <1501766821-76419-1-git-send-email-hare@suse.de>
	<8ad6ed91-b793-fab1-ea72-1e30e5b59266@redhat.com>
	<41045776-f4c2-20f5-1000-c826e314cfe2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] scsi: enclosure support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.de>
Cc: qemu-devel@nongnu.org


> On 08/03/2017 05:10 PM, Paolo Bonzini wrote:
> > On 03/08/2017 15:26, Hannes Reinecke wrote:
> >> Hi all,
> >>
> >> due to a customer issue I've added simple subenclosure support
> >> to the SCSI emulation. The patch simply converts the current invisible
> >> LUN0 into an enclosure device; existing setups using LUN0 as disks or
> >> CD-ROMs will not be affected.
> > 
> > What is the issue exactly?  That is, for what is it necessary to have a
> > dummy enclosure?
> > 
> Well, stock linux displays some very interesting error messages for
> these types of enclosures. Which was the prime mover for doing this.

--verbose?

> > I agree with Dan that this need machine type compatibility gunk.  For
> > example, could the new device affect /dev/sgN numbering?
>
> Yes, indeed it would.
> 
> What about a new option to the scsi driver?

If you do that, you've done 99% of the work to do compatibility so I
won't complain and do the 1% myself. :)

Paolo
