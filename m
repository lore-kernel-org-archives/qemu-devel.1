Received: from eggs.gnu.org ([2001:4830:134:3::10]:49529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Wcr-0004eH-1w
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Wcn-0005Fx-1m
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e5Wcm-0005Fb-R9
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:42:04 -0400
Date: Fri, 20 Oct 2017 14:41:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171020144155.11f7e549.cohuck@redhat.com>
In-Reply-To: <83d262ee-47e8-61c7-77cd-bbfc53d692c5@de.ibm.com>
References: <20171020102517.28385-1-borntraeger@de.ibm.com>
	<20171020133100.1dcec567.cohuck@redhat.com>
	<83d262ee-47e8-61c7-77cd-bbfc53d692c5@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: print carriage return with new
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

On Fri, 20 Oct 2017 14:27:12 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 10/20/2017 01:31 PM, Cornelia Huck wrote:
> > On Fri, 20 Oct 2017 12:25:17 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
> >>
> >> The sclp console in the s390 bios writes raw data,
> >> leading console emulators (such as virsh console) to
> >> treat a new line ('\n') as just a new line instead
> >> of as a Unix line feed. Because of this, output
> >> appears in a "stair case" pattern.
> >>
> >> Let's print \r\n on every occurrence of a new line
> >> in the string passed to write to amend this issue.
> >>
> >> This is in sync with the guest Linux code in
> >> drivers/s390/char/sclp_vt220.c which also does a line feed
> >> conversion  in the console part of the driver. 
> >>
> >> This fixes the s390-ccw and s390-netboot output like
> >> $ virsh start test --console
> >> Domain test started
> >> Connected to domain test
> >> Escape character is ^]
> >> Network boot starting...
> >>                           Using MAC address: 02:01:02:03:04:05
> >>                                                                 Requesting information via DHCP:  010
> >>
> >> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  pc-bios/s390-ccw/s390-ccw.h |  3 +++
> >>  pc-bios/s390-ccw/sclp.c     | 17 ++++++++++++++---
> >>  2 files changed, 17 insertions(+), 3 deletions(-)  
> > 
> > I'd defer that to a second pullreq before softfreeze where we can
> > collect the stragglers (currently building a pullreq). And I'd also
> > like to delegate that second pullreq to you, as I'll be busy/offline
> > after KVM Forum.  
> 
> Sure I can do that in a 2nd pull req after KVM forum.
> 

Cool, thx.
