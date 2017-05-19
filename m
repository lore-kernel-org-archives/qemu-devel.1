Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBgeA-0006s9-L1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBge7-0007H0-21
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:04:42 -0400
Date: Fri, 19 May 2017 13:04:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170519120432.GK2081@work-vm>
References: <20170510151209.32767-1-pasic@linux.vnet.ibm.com>
	<20170518174714.GK2079@work-vm>
	<14e80dcc-9e3b-4a45-0dbe-735ad2590ade@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e80dcc-9e3b-4a45-0dbe-735ad2590ade@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/css: catch section mismatch on
 load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 05/18/2017 07:47 PM, Dr. David Alan Gilbert wrote:
> >> Hi!
> >>
> >> I also wonder what is the best way to do this with vmstate.  I know there
> >> are VMSTATE_*_EQUAL macros for integers, and I have partially modelled my
> >> patch after that, but there we only get a != b as error message, which is
> >> satisfactory for detecting bugs which are supposed to get fixed. In this
> >> particular case having a verbose error message should be really helpful
> >> and thus important.
> >>
> >> I'm asking because I'm currently working on a vmstate conversion of the
> >> s390x css and virtio-ccw  stuff (find my latest patch set here
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01364.html).
> > I think the way to solve that problem will probably be adding a 'hint'
> > parameter to the VMSTATE_*_EQUAL macros that is a constant string,
> > stuff a pointer to that into a possibly new field in VMStateField,
> > and then make the get_*_equal functions include that string in the
> > message like you do.  There's a lot of copy and paste but it's
> > not too bad now that Jianjun's patch from a few months ago passed
> > the VMStateField* to the .get/.put.
> > 
> > Dave
> > 
> > 
> 
> Thanks Dave! I read your reply like you are seeing this verbose
> message if VMSTATE_*_EQUAL feature something worth of inclusion.
> Am I right? 

Yes.

> If yes, I'm willing to implement it.

Please do!

Dave

> Halil
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
