Received: from eggs.gnu.org ([2001:4830:134:3::10]:60574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1ceXyI-0001L1-7u
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 21:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1ceXyD-0002BX-7N
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 21:08:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51276
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1ceXyD-00028l-0y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 21:08:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1H23bfX036509
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 21:08:23 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28npg4u66r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 21:08:23 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 16 Feb 2017 19:08:21 -0700
Date: Fri, 17 Feb 2017 10:08:15 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112072513.98411-4-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170112072513.98411-4-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170217020815.GA28001@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 03/12] s390x/css: add s390-map-css
 machine option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-01-12 08:25:04 +0100]:

> From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> 
> We want to support real (i.e. not virtual) channel devices
> even for guests that do not support MCSS-E (where guests may
> see devices from any channel subsystem image at once). As all
> virtio-ccw devices are in css 0xfe (and show up in the default
> css 0 for guests not activating MCSS-E), we need an option to
> map e.g. passed-through subchannels from their real css (0-3,
> or 0 for hosts not activating MCSS-E) into the default css.
> This will be exploited in a later patch.

After some brainstorming, we decided to change this interface a bit.

The first thing is that, we agreed that "s390-squash-mcss" is a better
name than "s390-map-css". The new name denotes that it is trying to
accommodate the devices from multiple channel subsystems into a
non-mcsse-e system, and the word "suqash" is more accurate about what
is happening internally.

The second thing is, we should never map/squash a vfio-ccw device into
css 0xfe, which is reserved for virtio device only. So when squashing,
we need to do it the other way around (i.e. have virtio devices at
0.x.xxxx instead of fe.x.xxxx to accommodate non-mcsse-e).

> 
> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
[...]

-- 
Dong Jia
