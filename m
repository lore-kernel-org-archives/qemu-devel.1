Received: from eggs.gnu.org ([2001:4830:134:3::10]:38502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gQf9x-0003AG-Cp
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 16:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gQf9s-0005u2-DN
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 16:08:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60150
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gQf9s-0005tE-87
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 16:08:08 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAOKwnSU105333
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 16:08:07 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ny1p86qu0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 16:08:06 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Sat, 24 Nov 2018 21:08:05 -0000
Date: Sat, 24 Nov 2018 22:07:57 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181122165432.4437-1-cohuck@redhat.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181124220757.43560d50@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 0/3] vfio-ccw: support
 hsch/csch (kernel part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Thu, 22 Nov 2018 17:54:29 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> [This is the Linux kernel part, git tree is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git
> vfio-ccw-caps
> 
> The companion QEMU patches are available at
> https://github.com/cohuck/qemu vfio-ccw-caps]
> 
> Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> device. This tends to work well for the most common 'good path'
> scenarios; however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU,
> things like clearing pending requests at the device is currently not
> supported. This may be a problem for e.g. error recovery.
> 
> This patch series introduces capabilities (similar to what vfio-pci
> uses) and exposes a new async region for handling hsch/csch.

I'm on vacation and could not do more than skim over it real quick. FWIW
it looks very promising. I intend to give it an in depth review once I'm
back (i.e. second half of next week).

Regards,
Halil
