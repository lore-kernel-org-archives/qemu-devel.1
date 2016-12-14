Received: from eggs.gnu.org ([2001:4830:134:3::10]:48614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cHCOx-0003kW-Ow
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cHCOs-0001lP-70
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:27:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cHCOs-0001lB-0a
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:27:26 -0500
References: <20161214161958.2958-1-maxime.coquelin@redhat.com>
	<20161214172448.7619816e.cornelia.huck@de.ibm.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <b683fbfa-041f-3df1-8733-a602c0e6782b@redhat.com>
Date: Wed, 14 Dec 2016 17:27:21 +0100
MIME-Version: 1.0
In-Reply-To: <20161214172448.7619816e.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] virtio-pci: Fix cross-version migration
 with older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: mdroth@linux.vnet.ibm.com, stefanha@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 12/14/2016 05:24 PM, Cornelia Huck wrote:
> On Wed, 14 Dec 2016 17:19:58 +0100
> Maxime Coquelin <maxime.coquelin@redhat.com> wrote:
>
>> > This patch fixes a cross-version migration regression introduced
>> > by commit d1b4259f ("virtio-bus: Plug devices after features are
>> > negotiated").
>> >
>> > The problem is encountered when host's vhost backend does not support
>> > VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
>> > QEMU version with virtio-pci modern capabilities enabled to a v2.8
>> > QEMU version.
>> >
>> > In this case, modern capabilities get exposed to the guest by the source,
>> > whereas the target will detect version 1 is not supported so will only
>> > expose legacy capabilities.
>> >
>> > The problem is fixed by introducing a new "x-modern-broken" property,
> wrong property name...
>

Whoops... v3 on its way.

Thanks,
Maxime
