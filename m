Received: from eggs.gnu.org ([209.51.188.92]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyzsZ-0000Pp-FZ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyzsY-0004OT-HD
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:08:11 -0500
Date: Wed, 27 Feb 2019 15:07:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190227150757.4fc857b6.cohuck@redhat.com>
In-Reply-To: <a6766d6e-c848-be08-7881-dec6b0cb0604@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
	<735ca9ff-76e3-966f-6fbc-a72bf994b413@linux.ibm.com>
	<20190204121319.32915fd6.cohuck@redhat.com>
	<bd0a3a4e-d82c-e01b-7c81-60ee2b50eebe@linux.ibm.com>
	<20190205111838.5fe2fc47.cohuck@redhat.com>
	<a6766d6e-c848-be08-7881-dec6b0cb0604@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/15] s390-bios: Support for running
 format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com

On Wed, 27 Feb 2019 08:35:37 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 2/5/19 5:18 AM, Cornelia Huck wrote:

> > I think that the routine needs to be split:
> > - inner routine that does the ssch, retries if the subchannel is status
> >    pending, and waits for a final status (regardless whether it is a
> >    special condition or not)
> > - outer routine that does error handling, if needed (like retrying on
> >    IFCC, or doing a basic sense on unit check)
> > 
> > The inner routine will probably only be called by the outer routine
> > (and not directly by other code).
> > 
> > Does that make sense? It's hopefully enough; we really don't want to
> > transplant the whole Linux cio state machine into the bios...
> >   
> 
> I had a hard time following what you were suggesting here. Its most likely me,not you :). 
> That said, I did redesign it to remove the potential infinite recursion. I'll be posting 
> v3 soon, let me know what you think.

I might have been not clear enough; but looking forward to your v3 :)
