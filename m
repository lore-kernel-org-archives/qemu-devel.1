Received: from eggs.gnu.org ([2001:4830:134:3::10]:45528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjmYe-0000Oc-Hh
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjmYb-0003o2-Eo
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:43:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47100
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cjmYb-0003nr-9F
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:43:37 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v23CcofG056476
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 07:43:36 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xssu4rx9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:43:36 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 3 Mar 2017 12:43:34 -0000
References: <20170302185942.76255-1-pasic@linux.vnet.ibm.com>
	<20170303132149.34e5906a.cornelia.huck@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 3 Mar 2017 13:43:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170303132149.34e5906a.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <aa9b9219-f3a6-165c-2d92-156a9295adbb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fail device if
 set_event_notifier fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 03/03/2017 01:21 PM, Cornelia Huck wrote:
> On Thu,  2 Mar 2017 19:59:42 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> The function virtio_notify_irqfd used to ignore the return code of
>> event_notifier_set. Let's fail the device should this occur.
> 
> I'm wondering if there are reasons for event_notifier_set() to fail
> beyond "we've hit an internal race and should make an effort to fix
> that one, or else we have completely messed up in qemu". Marking the
> device broken tells the guest that there's something wrong with the
> device, but I think we want qemu bug reports when there's something
> broken with the irqfd.
>

That's why the error is logged. I understand virtio_error like something
suitable for indicating bugs.

What do you suggest? Forcing a dump? I would rather leave it to the
user to figure out how important is the state sitting in the machine
and the device, and how much effort does (s)he want to put into recovering
from the failure. 

Halil
