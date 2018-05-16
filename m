Received: from eggs.gnu.org ([2001:4830:134:3::10]:44093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIqlQ-0006Rz-LE
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIqlN-0002Kx-I7
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:22:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fIqlN-0002KN-DF
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:22:17 -0400
Date: Wed, 16 May 2018 09:22:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180516092208.4461c748@redhat.com>
In-Reply-To: <20180515230351.GA741@linux.intel.com>
References: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
	<20180427215314.23168-3-ross.zwisler@linux.intel.com>
	<20180510152848.0f99ea07@redhat.com>
	<20180515230351.GA741@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] nvdimm: platform capabilities command
 line option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, linux-nvdimm <linux-nvdimm@lists.01.org>

On Tue, 15 May 2018 17:03:51 -0600
Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> On Thu, May 10, 2018 at 03:28:48PM +0200, Igor Mammedov wrote:
[...]
> 
> > Also an extra patch to for make check that will test setting 'cap'
> > would be nice (an extra testcase in tests/bios-tables-test.c)  
> 
> Hmm...I've been looking at this, and it doesn't look like there is any
> verification around a lot of the ACPI tables (NFIT, SRAT, etc).
as far as I recall NFIT and SRAT are verified against expected template
(limited but at least something)

Following commits can serve as an example:
 e0e5c85 test/acpi-test-data: add ACPI tables for dimmpxm test
 adae91c tests/bios-tables-test: add test cases for DIMM proximity

> I've verified my patch by interacting with a guest with various settings - is
> this good enough, or do you really want me to test the value (which I think
> would just be "do I get out what I put in at the command line") via the unit
> test infrastructure?
It would be better to add test especially for a new code.
The reason for it is to catch regressions down the road,
it also makes easier for maintainer to review/test series.

> Thank you for the review.
