Received: from eggs.gnu.org ([209.51.188.92]:38457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtUR5-0003ib-RE
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtUQu-0001BZ-3P
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:33:00 -0500
Date: Tue, 12 Feb 2019 10:32:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190212103241.78b2cccb.cohuck@redhat.com>
In-Reply-To: <d6de7984-bd51-ebfb-a6eb-32759faeab12@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-6-git-send-email-jjherne@linux.ibm.com>
	<20190204114537.0ddb236a.cohuck@redhat.com>
	<d6de7984-bd51-ebfb-a6eb-32759faeab12@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/15] s390-bios: Factor finding boot
 device out of virtio code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Mon, 11 Feb 2019 12:57:36 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 2/4/19 5:45 AM, Cornelia Huck wrote:
> > On Tue, 29 Jan 2019 08:29:12 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> >> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> >> index 7e3f65e..2457752 100644
> >> --- a/pc-bios/s390-ccw/main.c
> >> +++ b/pc-bios/s390-ccw/main.c
> >> @@ -55,17 +55,18 @@ unsigned int get_loadparm_index(void)
> >>    * NOTE: The global variable blk_schid is updated to contain the subchannel
> >>    * information.
> >>    */
> >> -static bool find_dev(Schib *schib, int dev_no)
> >> +static bool find_subch(int dev_no)  
> > 
> > I'm wondering why you drop passing in the schib here? But OTOH, the
> > usage of global variables or not is a bit confused in the bios anyway...
> >   
> 
> I dropped it as an argument because the schib was never used outside of find_dev. Seems to 
> make sense to make it a local variable in this case.
> 

Fair enough.
