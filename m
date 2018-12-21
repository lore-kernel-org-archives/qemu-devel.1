Received: from eggs.gnu.org ([2001:4830:134:3::10]:44005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gaK8T-00075u-4j
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gaK8P-00035r-4r
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:42:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46196
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gaK8O-00034s-Uu
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:42:33 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBLCcThU096764
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 07:42:31 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pgxj3nah0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 07:42:31 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 21 Dec 2018 12:42:29 -0000
Date: Fri, 21 Dec 2018 13:42:22 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181221122332.61674eeb.cohuck@redhat.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181204133810.66e8cfe5@oc2783563651>
	<20181204141130.06496b9b.cohuck@redhat.com>
	<20181204160236.54de2784@oc2783563651>
	<20181205135402.33c2b22d.cohuck@redhat.com>
	<20181206194714.31e9f43a@oc2783563651>
	<20181207110529.3b293124.cohuck@redhat.com>
	<20181207175423.6c45621f@oc2783563651>
	<20181219125442.08eb053d.cohuck@redhat.com>
	<20181219151719.218dd2a2@oc2783563651>
	<20181221122332.61674eeb.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181221134222.562a790e@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 21 Dec 2018 12:23:32 +0100
Cornelia Huck <cohuck@redhat.com> wrote:
[..]
> 
> You've really lost me here :( I fear you're criticizing something I
> don't want to implement; I'll write some code, that should make things
> much easier to discuss.
> 

Nod.


> TBH, I have no idea how this will scale to many vfio-ccw devices.
> 
> > 
[..]
> > As long as you return -EAGAIN we are fine. But AFAIU you proposed to
> > do that until the I/O is submitted to the HW subchannel via ssch(). But
> > that is not the case I'm talking about here. We have already translated
> > the channel program for the first request, submitted it via ssch() and
> > are awaiting an interrupt that tells us the I/O is done. While waiting
> > for this interrupt we get a new ssch request. I understood, you don't
> > want to give -EAGAIN for this one, but make the ssch decide. The problem
> > is you still need the old translated channel program for the interrupt
> > handling, and at the same time you need the new channel program
> > translated as well, before doing the ssch for it in the host.
> 
> Why? You're not doing anything with that second ssch at all, it returns
> before translation is started.
> 

OK apparently I misunderstood something -- it was a long and twisty
discussion. Looking forward to the code ;).

[..]

> 
> I'll try to post something in January. Have a nice holiday break :)
> 

Don't feel pressured. :) Have nice holidays as well!

Regards,
Halil
