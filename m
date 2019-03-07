Received: from eggs.gnu.org ([209.51.188.92]:41588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h1o5J-0007fQ-TW
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h1o5J-000643-60
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:08:57 -0500
Date: Thu, 7 Mar 2019 09:08:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190307090851.14582d67.cohuck@redhat.com>
In-Reply-To: <96d70258-6ed8-136c-d824-a0403ace036f@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-7-git-send-email-jjherne@linux.ibm.com>
	<e3f0d9ab-c98b-d500-12e6-cfcc1a2b2a1b@redhat.com>
	<96d70258-6ed8-136c-d824-a0403ace036f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 06/16] s390-bios: Clean up
 cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Wed, 6 Mar 2019 13:42:17 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 3/5/19 12:51 AM, Thomas Huth wrote:
> > On 01/03/2019 19.59, Jason J. Herne wrote:  
> >> Add proper typedefs to all structs and modify all bit fields to use consistent
> >> formatting.
> >>
> >> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> >> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   pc-bios/s390-ccw/cio.h      | 152 ++++++++++++++++++++++----------------------
> >>   pc-bios/s390-ccw/s390-ccw.h |   8 ---
> >>   2 files changed, 76 insertions(+), 84 deletions(-)
> >>
> >> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> >> index 1a0795f..2f58256 100644
> >> --- a/pc-bios/s390-ccw/cio.h
> >> +++ b/pc-bios/s390-ccw/cio.h  
> > [...]  
> >> -struct subchannel_id {
> >> -        __u32 cssid  : 8;
> >> -        __u32        : 4;
> >> -        __u32 m      : 1;
> >> -        __u32 ssid   : 2;
> >> -        __u32 one    : 1;
> >> -        __u32 sch_no : 16;
> >> -} __attribute__ ((packed, aligned(4)));
> >> +} __attribute__ ((packed, aligned(4))) Schib;
> >> +
> >> +typedef struct subchannel_id {
> >> +        __u32 cssid:8;
> >> +        __u32:4;  
> > 
> > __u32:4 looks a little bit funny. Not sure, but maybe this should be
> > given a name like "reserved" or so?
> >   
> 
> Perhaps, but this is not my code. I was just cleaning up the style. If you feel strongly 
> that this patch is the place to give this a name, I can do that.

FWIW, my personal preference for this is keeping it unnamed.
