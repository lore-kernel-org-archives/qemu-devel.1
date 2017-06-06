Received: from eggs.gnu.org ([2001:4830:134:3::10]:35856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dI2j3-0000IS-Ux
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 20:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dI2j0-0000II-R6
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 20:52:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49852
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dI2j0-0000Hn-Kp
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 20:51:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v560mcPe092158
	for <qemu-devel@nongnu.org>; Mon, 5 Jun 2017 20:51:57 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2awc1a4qa3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 20:51:57 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 5 Jun 2017 18:51:56 -0600
Date: Tue, 6 Jun 2017 08:51:50 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170602140531.48332-1-pasic@linux.vnet.ibm.com>
	<20170605030931.GA8262@bjsdjshi@linux.vnet.ibm.com>
	<b912112c-7b34-3ba8-c1d4-308b84a06007@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b912112c-7b34-3ba8-c1d4-308b84a06007@redhat.com>
Message-Id: <20170606005150.GB8262@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x: vmstatify config migration
 for virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Eric Blake <eblake@redhat.com> [2017-06-05 07:19:14 -0500]:

Hi Eric,

> On 06/04/2017 10:09 PM, Dong Jia Shi wrote:
> > * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-06-02 16:05:31 +0200]:
> > 
> > Hi Halil,
> > 
> > Sorry for the late show up. I just found some nits, which could be
> > ignored for me.
> > 
> >> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
> >> flexibility (extending using subsections) and for fun.
> >>
> >> To achieve this we need to hack the config_vector, which is VirtIODevice
> >> (that is common virtio) state, in the middle of the VirtioCcwDevice state
> >> representation.  This is somewhat ugly, but we have no choice because the
> >                  ^^
> > Nit:-------------++
> 
> What's wrong here?  Two spaces between sentences is a common
> typographical convention 
Thanks for letting me learn this. I didn't know this interesting
knowledge before I saw this comment and searched in the Internet:
https://en.wikipedia.org/wiki/Sentence_spacing

> (true, the codebase is inconsistent on whether sentences are separated
> with one or two spaces, but that's all the more reason to realize that
> since we don't have a consistent standard, it is just churn to change
> from one style to the other)
I was thinking 1) inconsistence is strange and unwelcome, and 2) the
inconsistence here may be something that Halil did not intend to have.

Since it's a common typographical convention, and I'm not a native
English speaker. I will follow your opinion.

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



-- 
Dong Jia Shi
