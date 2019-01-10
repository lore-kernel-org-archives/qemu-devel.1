Received: from eggs.gnu.org ([209.51.188.92]:54869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghZF5-0003Xr-4c
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghZF3-000695-Ag
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:15:23 -0500
Date: Thu, 10 Jan 2019 13:15:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190110131513.0d264b10.cohuck@redhat.com>
In-Reply-To: <18c1ba75-84f6-e928-64a9-ccf5044d92b5@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
	<20181213182100.6da37a95.cohuck@redhat.com>
	<bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
	<729790ec-a74a-2e6e-89ed-3d450c95f54f@linux.ibm.com>
	<20190109193406.616fcf66.cohuck@redhat.com>
	<18c1ba75-84f6-e928-64a9-ccf5044d92b5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 10/15] s390-bios: Support for
 running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Wed, 9 Jan 2019 15:01:19 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 1/9/19 1:34 PM, Cornelia Huck wrote:
> > On Wed, 9 Jan 2019 13:10:26 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> >> I'm not sure what value there is in abstracting sense at the moment. I'm not even sure
> >> what other device's sense data looks like. Since my description of the SENSE CCW comes
> >> from an ECKD reference I have not been able to verify any areas of the data that are
> >> common across device types. Thoughts?  
> > 
> > There's SA22-7204-01 ("Common I/O Device Commands"), which is from 1992
> > (this is what I have on my disk -- is there anything newer?). It
> > specifies what bits 0-5 of byte 0 mean and states that bytes 1-31 are
> > optional and device-specific.
> > 
> > Maybe some other bits have been specified after 1992, but I have not
> > come across documentation for them.  
> 
> That publication is no longer available. According to my quick research it has been 
> replaced by an internal only publication. I'll see what I can find.

The publication no longer being available is not good, as it is a
normative reference pointed to by the virtio standard (see
http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-30001)
:(

Is there any chance that at least that old version can be made
available again?
