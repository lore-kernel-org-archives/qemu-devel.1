Received: from eggs.gnu.org ([2001:4830:134:3::10]:50233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e5WeP-0005tt-0i
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e5WeL-0006Ag-1z
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1e5WeK-0006AN-Rb
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:43:40 -0400
Date: Fri, 20 Oct 2017 14:43:32 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20171020124332.GM130425@orkuz.home>
References: <87y3oqugm7.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171005121115.GD3946746@orkuz.home>
	<87y3ok7n2n.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171012120714.GA314661@orkuz.home>
	<87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] Question about the host-model CPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Fri, Oct 20, 2017 at 13:09:26 +0200, Marc Hartmayer wrote:
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
> 
> For determining the actual host-model the QMP command
> 'query-cpu-model-expansion' is used. This is done once per QEMU binary
> and the result of it is cached by libvirt. The problem with that is
> that libvirt queries with the newest machine type of the QEMU binary
> for the host CPU model.

No, libvirt probes QEMU with -machine none.

> We could now either probe the host CPU model for each QEMU binary +
> machine type combination and for this we've to start a new QEMU
> process each time.

This is not really a viable solution.

Jirka
