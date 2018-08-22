Received: from eggs.gnu.org ([2001:4830:134:3::10]:58739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsNqW-00049x-Oh
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsNqQ-000113-5B
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:46:28 -0400
Date: Wed, 22 Aug 2018 09:46:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180822094608.17c070b9.cohuck@redhat.com>
In-Reply-To: <f9634033-8cf4-b677-28f8-1eda2cb6647e@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<20180815134844.55722b47.cohuck@redhat.com>
	<f9634033-8cf4-b677-28f8-1eda2cb6647e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/15] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 21 Aug 2018 15:31:55 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 08/15/2018 07:48 AM, Cornelia Huck wrote:
> > On Thu,  5 Jul 2018 13:25:28 -0400
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> >   
> >> This is to support booting from vfio-ccw dasd devices. We basically implement
> >> the real hardware ipl procedure. This allows for booting Linux guests on
> >> vfio-ccw devices.
> >>
> >> vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
> >> channel programs dynamically modify themselves. Details on the ipl process and
> >> how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.  
> > 
> > Cleaning up my mail backlog... I think there were some comments; will
> > there be a new version forthcoming?
> >   
> 
> Yes there will. We're hitting a hang now and not sure if it is a device, 
> configuration or coding problem. Once I get that cleared up I'll be back 
> for round #2.
> 

Great, thanks for the info!
