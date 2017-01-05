Received: from eggs.gnu.org ([2001:4830:134:3::10]:39899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cP2YF-0003wa-MU
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cP2YB-00062k-PU
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:33:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:7925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cP2YB-00061c-Fl
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:33:27 -0500
Message-ID: <586DF6FE.8070704@intel.com>
Date: Thu, 05 Jan 2017 15:34:22 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
	<CAJ+F1CKWSznG3hxj0=F1UAJD+ZOZg=q+Oio1YnbsRyz6vy51FQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CKWSznG3hxj0=F1UAJD+ZOZg=q+Oio1YnbsRyz6vy51FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RESEND Patch v1 00/37] Implementation of
 vhost-pci for inter-vm commucation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

Hi Marc-André

On 12/20/2016 12:43 AM, Marc-André Lureau wrote:
> On Mon, Dec 19, 2016 at 7:00 AM Wei Wang <wei.w.wang@intel.com 
> <mailto:wei.w.wang@intel.com>> wrote:
>
>     This patch series implements vhost-pci, which is a point-to-point
>     based inter-vm
>     communication solution. The QEMU side implementation includes the
>     vhost-user
>     extension, vhost-pci device emulation and management. The current
>     device part
>     implementation is based on virtio 1.0, but it can be easily
>     upgraded to support
>     the upcoming virtio 1.1.
>
>     The current QEMU implementation supports the polling mode driver
>     on both sides
>     to receive packets. More features, such as interrupt support, live
>     migration
>     support, protected memory accesses will be added later.
>
>
>
> I highly appreciate the effort you put in splitting the patch series 
> and commenting each, although some are probably superfluous. Before 
> going into details, I suppose you have kernel side bits too. I'd 
> suggest before sending individual patches for review, that you send a 
> RFC with links to the various git trees and instructions to test the 
> proposed device. This would really help things and potentially bring 
> more people for testing and comments (think about libvirt side etc). 
> Even better would be to have some tests (with qtest).

The code is ready to try. I plan to clean up the driver to upstream when 
the QEMU device part is finalized.

The QEMU code is available at: git clone 
https://github.com/wei-w-wang/vhost-pci-device
The driver: git clone https://github.com/wei-w-wang/vhost-pci-driver

I have a README.md under vhost-pci-device/ , which introduces the steps 
to try the implementation.
I will rename the variables/fields that you mentioned in the v2 version. 
Thanks.


Best,
Wei
