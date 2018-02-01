Received: from eggs.gnu.org ([2001:4830:134:3::10]:50536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehHmB-0007hq-Uh
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 11:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehHm6-000678-D1
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 11:31:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ehHm6-00065O-7I
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 11:31:46 -0500
Date: Thu, 1 Feb 2018 14:31:32 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180201163132.GV26425@localhost.localdomain>
References: <20180117095421.124787-1-marcel@redhat.com>
	<20180117095421.124787-2-marcel@redhat.com>
	<20180131204059.GG21702@localhost.localdomain>
	<20180131230607-mutt-send-email-mst@kernel.org>
	<20180131233422.GP26425@localhost.localdomain>
	<20180201040608-mutt-send-email-mst@kernel.org>
	<8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
	<20180201121009.GR26425@localhost.localdomain>
	<bac4ac10-72ef-679e-69e6-95cdda32d2ab@redhat.com>
	<20180201150254-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201150254-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On Thu, Feb 01, 2018 at 04:24:30PM +0200, Michael S. Tsirkin wrote:
[...]
> The full fix would be to allow QEMU to map a list of
> pages to a guest supplied IOVA.

Thanks, that's what I expected.

While this is not possible, the only requests I have for this
patch is that we clearly document:
* What's the only purpose of share=on on a host-memory-backend
  object (due to pvrdma limitations).
* The potential undesirable side-effects of setting share=on.
* On the commit message and other comments, clearly distinguish
  HVAs in the QEMU address-space from IOVAs, to avoid confusion.

-- 
Eduardo
