Received: from eggs.gnu.org ([209.51.188.92]:42128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h1o7s-0000OB-SO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h1o7r-0007WF-2Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:11:36 -0500
Date: Thu, 7 Mar 2019 09:11:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190307091127.7a93313c.cohuck@redhat.com>
In-Reply-To: <3beee536-d96e-390e-cb5f-db1c1e460f23@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-9-git-send-email-jjherne@linux.ibm.com>
	<5d26b514-7d19-9323-c727-696ee5ed4f84@redhat.com>
	<3beee536-d96e-390e-cb5f-db1c1e460f23@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 08/16] s390-bios: Map low
 core memory
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

On Wed, 6 Mar 2019 14:28:42 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 3/5/19 1:27 AM, Thomas Huth wrote:
> > On 01/03/2019 19.59, Jason J. Herne wrote:  

> >> +    PSW             return_psw;               /* 0x200 */
> >> +    uint8_t         irb[64];                  /* 0x210 */
> >> +    uint64_t        sync_enter_timer;         /* 0x250 */
> >> +    uint64_t        async_enter_timer;        /* 0x258 */
> >> +    uint64_t        exit_timer;               /* 0x260 */
> >> +    uint64_t        last_update_timer;        /* 0x268 */
> >> +    uint64_t        user_timer;               /* 0x270 */
> >> +    uint64_t        system_timer;             /* 0x278 */
> >> +    uint64_t        last_update_clock;        /* 0x280 */
> >> +    uint64_t        steal_clock;              /* 0x288 */
> >> +    PSW             return_mcck_psw;          /* 0x290 */  
> > 
> > ... but where do these entries between 0x200 and 0x2a0 come from? They
> > do not seem to be defined by the Principles of Operation?
> >   
> 
> Taken from target/s390x/internal.h. I stopped at "/* System info area */". Now that I'm 
> looking at it, I'm not sue where these are coming from.... I will remove them in the next 
> version.

That was coming from an very old version of the lowcore in the Linux
kernel... removed from internal.h with a patch queued on s390-next
now :)
