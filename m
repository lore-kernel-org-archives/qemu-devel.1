Received: from eggs.gnu.org ([2001:4830:134:3::10]:50980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e2l10-0004sl-DB
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e2l0x-0001Js-8i
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1e2l0x-0001Ih-1c
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:27:35 -0400
Date: Thu, 12 Oct 2017 17:27:28 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1893461099.19940340.1507843648978.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4jdWUeoF1PxWhXx3vciLmOL9AyW_yPq0W6DRFe3RP2fkA@mail.gmail.com>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-2-pagupta@redhat.com>
	<CAPcyv4jdWUeoF1PxWhXx3vciLmOL9AyW_yPq0W6DRFe3RP2fkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/2] pmem: Move reusable code to base header
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Jan Kara <jack@suse.cz>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Ross Zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, Qemu Developers <qemu-devel@nongnu.org>, Linux MM <linux-mm@kvack.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>


> 
> On Thu, Oct 12, 2017 at 8:50 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
> >  This patch moves common code to base header files
> >  so that it can be used for both ACPI pmem and VIRTIO pmem
> >  drivers. More common code needs to be moved out in future
> >  based on functionality required for virtio_pmem driver and
> >  coupling of code with existing ACPI pmem driver.
> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> [..]
> > diff --git a/include/linux/pmem_common.h b/include/linux/pmem_common.h
> > new file mode 100644
> > index 000000000000..e2e718c74b3f
> > --- /dev/null
> > +++ b/include/linux/pmem_common.h
> 
> This should be a common C file, not a header.

Sure! will create a common C file to put all the common code there.

> 
> 
