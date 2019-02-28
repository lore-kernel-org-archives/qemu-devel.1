Received: from eggs.gnu.org ([209.51.188.92]:44564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzOHE-0003Sc-40
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzOHD-0007sG-D6
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:11:16 -0500
Date: Thu, 28 Feb 2019 17:11:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190228171111.6484f968.cohuck@redhat.com>
In-Reply-To: <1ae847e3-5f46-e050-5910-7e9010a8c6cf@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-12-git-send-email-jjherne@linux.ibm.com>
	<20190204124105.0abb9b44.cohuck@redhat.com>
	<1ae847e3-5f46-e050-5910-7e9010a8c6cf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/15] s390-bios: cio error handling
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

On Thu, 28 Feb 2019 10:59:13 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 2/4/19 6:41 AM, Cornelia Huck wrote:

> >> @@ -148,6 +370,9 @@ int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
> >>               continue;
> >>           }
> >>   
> >> +        print_irb_err(&irb);
> >> +        basic_sense(schid, &sd, sizeof(sd));
> >> +        print_eckd_dasd_sense_data(&sd);  
> > 
> > I think this should only be printed for actual dasds (and maybe only
> > print it if there is actually sense data available)?
> >   
> 
> Good point. Currently do_cio doesn't have any info on its device type. Should I pass in 
> the controller type? Thats the easiest way I can think of to make the decision.
> 

Sounds reasonable to me!
