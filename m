Received: from eggs.gnu.org ([2001:4830:134:3::10]:32876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dsI6G-0007K0-Di
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dsI6D-0003wl-AG
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:33:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:21189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dsI6D-0003vJ-1P
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:33:45 -0400
Date: Thu, 14 Sep 2017 08:33:41 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170914003341.h4t7swxcgkum7twi@hz-desktop>
References: <20170913135418.GA14243@stefanha-x1.localdomain>
	<dbd4caa3-71e2-5ea0-c7b1-8aee774eec30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd4caa3-71e2-5ea0-c7b1-8aee774eec30@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] QEMU -M nvdimm=on and hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On 09/13/17 17:28 +0200, Michal Privoznik wrote:
> 
> BTW: I ran a migration from no nvdimm qemu to one that had -M nvdimm=on
> and guest migrated happily. So looks like guest ABI is stable (or at
> least stable enough not to crash). But since ACPI table is changed I
> doubt that.

One example that may cause trouble is that
1/ Guest OS got a pointer to an ACPI table A on the source host (w/o nvdimm=on)
2/ After migrating to the destination host (w/ nvdimm=on), the
   location of ACPI table A is occupied by NFIT. If guest OS tries to
   access ACPI table A via the pointer in step 1/, then it will access
   the wrong table.

> 
> Also, I found that hotunplug is not implemented yet?

So far there is no public specification defining NVDIMM hotunplug, so
we didn't implement it.


Haozhong


> 
> error: internal error: unable to execute QEMU command 'device_del':
> nvdimm device hot unplug is not supported yet.
> 
> Michal
