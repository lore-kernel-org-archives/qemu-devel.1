Received: from eggs.gnu.org ([2001:4830:134:3::10]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e6X7Z-0007BY-9D
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 03:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e6X7W-0003JK-50
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 03:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1e6X7V-0003Ix-UU
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 03:25:58 -0400
Date: Mon, 23 Oct 2017 09:25:46 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20171023072546.GO130425@orkuz.home>
References: <87y3oqugm7.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171005121115.GD3946746@orkuz.home>
	<87y3ok7n2n.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171012120714.GA314661@orkuz.home>
	<87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
	<7aa560cd-d35f-7feb-a9db-378d3e763a62@redhat.com>
	<20171020125056.GN130425@orkuz.home>
	<f43de685-b6d6-14fe-38d1-35481a6ac954@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43de685-b6d6-14fe-38d1-35481a6ac954@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] Question about the host-model CPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Fri, Oct 20, 2017 at 15:04:57 +0200, David Hildenbrand wrote:
> On 20.10.2017 14:50, Jiri Denemark wrote:
> > The thing is libvirt calls query-cpu-model-expansion to check what the
> > host CPU is. This 'host-model' CPU is replaced with the probed CPU model
> > when a domain starts. The problem described by Marc is that the probed
> > CPU model cannot be used universally with all machine types. So starting
> > a domain on such host with machine type s390-virtio-ccw-2.10 works, but
> > a domain with machine type s390-virtio-ccw-2.9 fails to start with the
> > same probed CPU model.
> > 
> 
> My assumption would be that the CPU model is copied into the XML when
> the domain fist starts. This is what the documentation describes.

The CPU model is copied into the XML each time the domain starts.

> So when upgrading QEMU, the CPU model in the XML is still the same
> (z13), even though something different is now reported in the host info
> after upgrading QEMU (z14).
> 
> In this case it would continue to work.
> 
> The problem is that the CPU model is not copied into the XML doesn't
> remain there, right? It is suddenly replaced with a z14 host model.

Even preserving the actual CPU model in the XML from the first start
wouldn't solve the issue. You can always create a new domain with
s390-virtio-ccw-2.9 machine type even on the upgraded host.

Jirka
