Received: from eggs.gnu.org ([2001:4830:134:3::10]:56433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRK8x-0005JR-SF
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRK8u-0002SD-Mc
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:21:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fRK8u-0002S1-HE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:21:36 -0400
Date: Fri, 8 Jun 2018 19:21:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608191941-mutt-send-email-mst@kernel.org>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-2-ross.zwisler@linux.intel.com>
	<20180608020724-mutt-send-email-mst@kernel.org>
	<5352d2fb-9244-78b0-4f4b-2818359a4425@redhat.com>
	<20180608153402.GA27156@linux.intel.com>
	<20180608185714-mutt-send-email-mst@kernel.org>
	<CAFEAcA943cBfMbjBJcheTWAL+mWa4vu5uL62LvKXS4agd+ZRMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA943cBfMbjBJcheTWAL+mWa4vu5uL62LvKXS4agd+ZRMA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Fri, Jun 08, 2018 at 05:14:09PM +0100, Peter Maydell wrote:
> On 8 June 2018 at 16:59, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The expected value tests are a debugging aid. They do not catch bugs and
> > aren't designed to. In particular the comparisons do not even run if
> > IASL isn't installed.
> 
> If they're not actually tests to catch bugs, maybe we shouldn't
> be running them in "make check" ?
> 
> thanks
> -- PMM

We are running tests to do basic things like verifying the
checksum of the tables. Failure on these causes make check to fail.

As long as we have the tables anyway, and assuming IASL is installed
(which most people who do not work on ACPI would not have) we compare to
the expected set, that is often helpful for debugging.

-- 
MST
