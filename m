Received: from eggs.gnu.org ([209.51.188.92]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gjOL0-0005ae-7N
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gjOKu-0005S3-OR
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:01:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gjOKu-0005Rn-Hx
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:00:56 -0500
References: <20190111165801.15181-1-eric.auger@redhat.com>
	<20190111165801.15181-3-eric.auger@redhat.com>
	<20190115131243.6f8e51b3.cohuck@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <60925190-3427-3658-012f-033994661379@redhat.com>
Date: Tue, 15 Jan 2019 14:00:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190115131243.6f8e51b3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] vfio-pci: Use
 vfio_register_event_notifier in vfio_intx_enable_kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: alex.williamson@redhat.com, qemu-devel@nongnu.org, eric.auger.pro@gmail.com

Hi Cornelia,

On 1/15/19 1:12 PM, Cornelia Huck wrote:
> On Fri, 11 Jan 2019 17:58:01 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> We can also use vfio_register_event_notifier() helper in
>> vfio_intx_enable_kvm to set the signalling associated to
>> VFIO_PCI_INTX_IRQ_INDEX.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/vfio/pci.c | 38 +++++++-------------------------------
>>  1 file changed, 7 insertions(+), 31 deletions(-)
>>
> 
>>  static void vfio_intx_disable(VFIOPCIDevice *vdev)
> 
> I'm wondering why the _disable path can't use the new helper. Ordering
> issues?
> 
Yes the interleaving of actions scared me a little bit. I am going to
study this a little bit further ...

Thanks

Eric
