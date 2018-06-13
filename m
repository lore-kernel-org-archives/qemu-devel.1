Received: from eggs.gnu.org ([2001:4830:134:3::10]:48565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTC1e-0002tO-12
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTC1Z-0000Gy-31
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTC1Y-0000GN-To
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:05:45 -0400
Date: Wed, 13 Jun 2018 17:05:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613200534.GL7451@localhost.localdomain>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<20180612140643.6f6ed34d@redhat.com>
	<HK2PR06MB0531F10A69CBFC1D41402F19EB7F0@HK2PR06MB0531.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR06MB0531F10A69CBFC1D41402F19EB7F0@HK2PR06MB0531.apcprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH V6 0/7] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Junyan He <junyan.he@gmx.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, Junyan He <junyan.he@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

On Tue, Jun 12, 2018 at 01:38:08PM +0000, Junyan He wrote:
> He have pmem_persist and pmem_memcpy_persist stub functions.
> 
> If no libpmem and user really specify pmem=on, we just do nothing or just memcpy.
> 
> Real persistent memory always require libpmem support its load/save.
> 
> If pmem=on and without libpmem, we can think that user want to imitate
> 
> pmem=on while the HW environment is without real persistent memory existing.
> 
> It may help debug on some machine without real pmem.

What exactly it would help debug?  Is there any difference
between testing the code with pmem=off and pmem=on if libptest is
unavailable?

I would prefer to simply not let the user set pmem=on if libptest
is not available.

-- 
Eduardo
