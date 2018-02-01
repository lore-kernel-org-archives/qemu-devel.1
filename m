Received: from eggs.gnu.org ([208.118.235.92]:46957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehKf0-0004YT-3F
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehKdw-0001eu-60
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:36:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehKdv-0001eL-Q5
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:35:31 -0500
References: <20180201040608-mutt-send-email-mst@kernel.org>
	<8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
	<20180201121009.GR26425@localhost.localdomain>
	<bac4ac10-72ef-679e-69e6-95cdda32d2ab@redhat.com>
	<20180201135340.GU26425@localhost.localdomain>
	<db40e5ca-9a15-4faf-4675-f29b0ee4ab22@redhat.com>
	<20180201182108.GE26425@localhost.localdomain>
	<f87b5810-6d87-bd92-be70-dd620501a29d@redhat.com>
	<20180201185129.GI21702@localhost.localdomain>
	<3e5610ec-16d7-2a00-267e-935c1b3ea3af@redhat.com>
	<20180201192108.GF26425@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5deb74db-19c7-6c5c-2089-22578cf17ad5@redhat.com>
Date: Thu, 1 Feb 2018 14:35:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180201192108.GF26425@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 1/4] mem: add share parameter to
 memory-backend-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, imammedo@redhat.com

On 01/02/2018 14:21, Eduardo Habkost wrote:
>> The device looks at its own private page tables, and not
>> to the OS ones.
> I'm still confused by your statement that the device builds its
> own [IOVA->PA] page table.  How would the device do that if it
> doesn't have access to the CPU MMU state?  Isn't the IOVA->PA
> translation table built by the OS?

The driver builds a page table for the device, either when it pins the
pages or by using MMU notifiers.

Paolo
