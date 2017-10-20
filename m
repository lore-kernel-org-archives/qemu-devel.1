Received: from eggs.gnu.org ([2001:4830:134:3::10]:57862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5X9x-0005ln-0e
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5X9u-0006Yu-4l
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:16:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e5X9t-0006YD-UT
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:16:18 -0400
References: <87y3oqugm7.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171005121115.GD3946746@orkuz.home>
	<87y3ok7n2n.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171012120714.GA314661@orkuz.home>
	<87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0aab6dae-a926-c106-9bc5-68561a9bef5c@redhat.com>
Date: Fri, 20 Oct 2017 15:16:07 +0200
MIME-Version: 1.0
In-Reply-To: <87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] Question about the host-model CPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>Christian Borntraeger <borntraeger@de.ibm.com>


> Hi all,
> 
> we recently encountered the problem that the 'host-model' [1] has to be
> related to the machine type of a domain. We have following problem:
> 
>    Let's assume we've a z13 system with a QEMU 2.9 and we define a
>    domain using the default s390-virtio-ccw machine together with the
>    host-model CPU mode [1]. The definition will have the machine
>    expanded to s390-virtio-ccw-2.9 but retain the host-model CPU mode
>    in the domain definition. In a next step we upgrade to QEMU 2.10
>    (first version to recognize z14). Everything is still fine, even
>    though the machine runs in 2.9 compatibility mode. Finally we
>    upgrade to a z14. As a consequence it is not possible to start the
>    domain anymore as the machine type doesn't support our CPU host
>    model (which is expanded at start time of the domain).

Actually, what is the cause of that problem? I assume it is the gs
feature (gs_allowed)?

We should really avoid such things (..._allowed) for CPU model features
in the future and clue all new such stuff to cpumodel_allowed.

-- 

Thanks,

David
