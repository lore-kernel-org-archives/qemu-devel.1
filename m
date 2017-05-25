Received: from eggs.gnu.org ([2001:4830:134:3::10]:46136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dDx7t-0001S3-B5
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dDx7q-0003EN-74
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:04:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dDx7q-0003Dt-0p
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:04:42 -0400
Date: Thu, 25 May 2017 21:04:39 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170525210048-mutt-send-email-mst@kernel.org>
References: <5922D0EC.6060405@intel.com>
	<b415fea9-9d48-9390-0ec2-46f69b7a54b0@redhat.com>
	<5923C557.3020301@intel.com>
	<ac8a484d-744a-8bdf-eba2-05239c6eefb1@redhat.com>
	<5924109F.6090608@intel.com>
	<48ec0c88-801f-fc1f-401f-51cb2ca3fed2@redhat.com>
	<592541D9.3030303@intel.com>
	<781faa1c-9253-d212-f616-2a899087edc1@redhat.com>
	<5926C519.6080508@intel.com>
	<2fb56ab7-99c6-ac30-de60-a747438416b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb56ab7-99c6-ac30-de60-a747438416b8@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH RFC]
 virtio-net: enable configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, stefanha@gmail.com, qemu-devel@nongnu.org, jan.scheurich@ericsson.com, marcandre.lureau@gmail.com, pbonzini@redhat.com

On Thu, May 25, 2017 at 08:13:31PM +0800, Jason Wang wrote:
> > 
> > The point of using the config field here is, when tomorrow's device is
> > released with a requirement for the driver
> > to use max_chain_size=1022 (not today's 1023), today's driver will
> > naturally support tomorrow's device without
> > any modification, since it reads the max_chain_size from the config
> > field which is filled by the device (either today's
> > device or tomorrow's device with different values).
> 
> I'm not saying anything wrong with the config filed you introduced. But you
> should answer the following question:
> 
> Is it useful to support more than 1024? If yes, why? If not, introduce a
> VIRTIO_F_SG_1024 is more than enough I think.
> 
> Thanks

I think it's useful to limit it below queue size too.

-- 
MST
