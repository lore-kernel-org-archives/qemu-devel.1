Received: from eggs.gnu.org ([2001:4830:134:3::10]:36124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehJyC-0002hI-5B
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehJy7-0007i8-15
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:52:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ehJy6-0007hg-Rh
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:52:18 -0500
Date: Thu, 1 Feb 2018 20:52:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180201204527-mutt-send-email-mst@kernel.org>
References: <20180131230607-mutt-send-email-mst@kernel.org>
	<20180131233422.GP26425@localhost.localdomain>
	<20180201040608-mutt-send-email-mst@kernel.org>
	<8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
	<20180201121009.GR26425@localhost.localdomain>
	<bac4ac10-72ef-679e-69e6-95cdda32d2ab@redhat.com>
	<20180201135340.GU26425@localhost.localdomain>
	<db40e5ca-9a15-4faf-4675-f29b0ee4ab22@redhat.com>
	<20180201182108.GE26425@localhost.localdomain>
	<f87b5810-6d87-bd92-be70-dd620501a29d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87b5810-6d87-bd92-be70-dd620501a29d@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On Thu, Feb 01, 2018 at 08:31:09PM +0200, Marcel Apfelbaum wrote:
> Theoretically is possible to send any contiguous IOVA instead of
> process's one but is not how is working today.

It works this way today in hardware but it's not hardware that limits
it to work this way - it's a software limitation.

-- 
MST
