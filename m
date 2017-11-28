Received: from eggs.gnu.org ([2001:4830:134:3::10]:52602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJixS-0001kj-VL
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJixO-000672-2G
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:42:06 -0500
Date: Tue, 28 Nov 2017 17:41:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128174157.397590c6.cohuck@redhat.com>
In-Reply-To: <2a2ee45b-c199-2763-a151-938bbed49ca3@linux.vnet.ibm.com>
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-3-git-send-email-walling@linux.vnet.ibm.com>
	<20171128114814.55ccfbf3.cornelia.huck@mailbox.org>
	<2a2ee45b-c199-2763-a151-938bbed49ca3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 2/5] s390-ccw: ipl structs
 for eckd cdl/ldl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, frankja@linux.vnet.ibm.com

On Tue, 28 Nov 2017 10:42:30 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> On 11/28/2017 05:48 AM, Cornelia Huck wrote:
> > On Mon, 27 Nov 2017 15:55:33 -0500
> > "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
> >  
> >> ECKD DASDs have different IPL structures for CDL and LDL
> >> formats. The current Ipl1 and Ipl2 structs follow the CDL
> >> format, so we prepend "EckdCdl" to them. A new struct,
> >> EckdLdlIpl1 is introduced and contains boot info for LDL.  
> > So does this add support for LDL DASD, or does it simply enhance the
> > code? It's unclear from the desription alone.  
> 
> Enhances. I'll reword it. Perhaps something along the lines of "Boot info
> for LDL has been *moved* to a new struct, EckdLdlIpl1"

Yes, sounds good.

> 
> >  
> >> Also introduce structs for IPL stages 1 and 1b and for
> >> disk geometry.
> >>
> >> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> >> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> >> ---
> >>   pc-bios/s390-ccw/bootmap.c | 24 ++++++++++----------
> >>   pc-bios/s390-ccw/bootmap.h | 55 +++++++++++++++++++++++++++++++++-------------
> >>   2 files changed, 53 insertions(+), 26 deletions(-)  
> 
> 
