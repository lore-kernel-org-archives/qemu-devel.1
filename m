Received: from eggs.gnu.org ([2001:4830:134:3::10]:50813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRJrD-0007Ej-IJ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRJr8-0001ga-PT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:03:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fRJr8-0001g6-Jx
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:03:14 -0400
Date: Fri, 8 Jun 2018 19:03:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608190040-mutt-send-email-mst@kernel.org>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-2-ross.zwisler@linux.intel.com>
	<20180608020724-mutt-send-email-mst@kernel.org>
	<5352d2fb-9244-78b0-4f4b-2818359a4425@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5352d2fb-9244-78b0-4f4b-2818359a4425@redhat.com>
Subject: Re: [Qemu-devel] [qemu PATCH 2/5] acpi: "make check" should fail on
 asl mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Fri, Jun 08, 2018 at 07:17:51AM +0200, Thomas Huth wrote:
> On 08.06.2018 01:09, Michael S. Tsirkin wrote:
> > On Thu, Jun 07, 2018 at 04:31:08PM -0600, Ross Zwisler wrote:
> >> Currently if "make check" detects a mismatch in the ASL generated during
> >> testing, we print an error such as:
> >>
> >>   acpi-test: Warning! SSDT mismatch. Actual [asl:/tmp/asl-QZDWJZ.dsl,
> >>   aml:/tmp/aml-T8JYJZ], Expected [asl:/tmp/asl-DTWVJZ.dsl,
> >>   aml:tests/acpi-test-data/q35/SSDT.dimmpxm].
> >>
> >> but the testing still exits with good shell status.  This is wrong, and
> >> makes bisecting such a failure difficult.
> >>
> >> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > 
> > Failing would also mean that any change must update the expected files
> > at the same time.  And that in turn is problematic because expected
> > files are binary and can't be merged.
> > 
> > In other words the way we devel ACPI right now means that bisect will
> > periodically produce a diff, it's not an error.
> 
> But apparently the current way also allows that real bug go unnoticed
> for a while, until somebody accidentially spots the warning in the
> output of "make check". Wouldn't it be better to fail at CI time
> already? If a merge of the file is required, you can still resolve that
> manually (i.e. by rebasing one of the pull requests).
> 
>  Thomas

Pull requests are somewhat different, they are usually tested for lack
of warnings. This change didn't arrive as a result of a pull request
maybe that's why it slipped through the cracks. Peter?

Maybe we need a "pedantic" flag to fail on any warnings, or just catch
output to stderr.

-- 
MST
