Received: from eggs.gnu.org ([2001:4830:134:3::10]:59136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQwrG-00008j-Dl
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQwrC-0003yz-G6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:29:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fQwrC-0003yh-9E
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:29:46 -0400
Date: Thu, 7 Jun 2018 18:29:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180607182900-mutt-send-email-mst@kernel.org>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180521163203.26590-4-ross.zwisler@linux.intel.com>
	<20180605182243-mutt-send-email-mst@kernel.org>
	<20180605164205.GA21034@linux.intel.com>
	<CAPcyv4jSoFifTc05WGgxkEX6i7b12zYyB+VchJVW_+QPQzO7Fg@mail.gmail.com>
	<20180605213547-mutt-send-email-mst@kernel.org>
	<20180605220700.GB16066@linux.intel.com>
	<CAPcyv4irudGth3+WZtgF4TjGL53s8mN70aVXpGWjj_Lc=7AMVg@mail.gmail.com>
	<AT5PR8401MB1169403448C8AA5FF267F6A6AB650@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
	<CAPcyv4gwsasnnt=LpU5wgbjvL8=w+fErCPtNHyRDGO1iQukYnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gwsasnnt=LpU5wgbjvL8=w+fErCPtNHyRDGO1iQukYnw@mail.gmail.com>
Subject: Re: [Qemu-devel] [qemu PATCH v4 3/4] nvdimm,
 acpi: support NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Jun 06, 2018 at 04:40:31PM -0700, Dan Williams wrote:
> On Wed, Jun 6, 2018 at 4:20 PM, Elliott, Robert (Persistent Memory)
> <elliott@hpe.com> wrote:
> >
> >> > Okay, we can move to the symbolic names.  Do you want them to be that
> >> long, or
> >> > would:
> >> >
> >> > nvdimm-cap-cpu
> >> > nvdimm-cap-mem-ctrl
> >> > nvdimm-cap-mirroring
> >>
> >> Wait, why is mirroring part of this?
> >
> > This data structure is intended to report any kind of platform capability, not
> > just platform persistence capabilities.
> 
> Yes, but here's nothing actionable that a qemu guest OS can do with
> that mirroring information, so there's no need at this time to add cli
> cruft and code to support it.

I agree.

-- 
MST
