Received: from eggs.gnu.org ([2001:4830:134:3::10]:56167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqwDT-0000if-76
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqwDQ-0001vn-It
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:31:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:28170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqwDQ-0001vT-7I
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:31:52 -0500
Date: Wed, 28 Feb 2018 15:31:48 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180228073148.6vvqfpp2jdkfr7mv@hz-desktop>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228072558.7434-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/8] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 02/28/18 15:25 +0800, Haozhong Zhang wrote:
> QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
> live migration. If the backend is on the persistent memory, QEMU needs
> to take proper operations to ensure its writes persistent on the
> persistent memory. Otherwise, a host power failure may result in the
> loss the guest data on the persistent memory.
>


> This v3 patch series is based on Marcel's patch "mem: add share
> parameter to memory-backend-ram" [1] because of the changes in patch 1.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html

I forgot to remove this part. v4 can be applied on the current master
branch now because above [1] has already been merged.
