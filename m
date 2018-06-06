Received: from eggs.gnu.org ([2001:4830:134:3::10]:59257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elliott@hpe.com>) id 1fQhjp-000100-QB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elliott@hpe.com>) id 1fQhjk-0004o8-QT
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:21:09 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:37712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elliott@hpe.com>) id 1fQhjk-0004n2-J4
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:21:04 -0400
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Date: Wed, 6 Jun 2018 23:20:58 +0000
Message-ID: <AT5PR8401MB1169403448C8AA5FF267F6A6AB650@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180521163203.26590-4-ross.zwisler@linux.intel.com>
	<20180605182243-mutt-send-email-mst@kernel.org>
	<20180605164205.GA21034@linux.intel.com>
	<CAPcyv4jSoFifTc05WGgxkEX6i7b12zYyB+VchJVW_+QPQzO7Fg@mail.gmail.com>
	<20180605213547-mutt-send-email-mst@kernel.org>
	<20180605220700.GB16066@linux.intel.com>
	<CAPcyv4irudGth3+WZtgF4TjGL53s8mN70aVXpGWjj_Lc=7AMVg@mail.gmail.com>
In-Reply-To: <CAPcyv4irudGth3+WZtgF4TjGL53s8mN70aVXpGWjj_Lc=7AMVg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: 'Dan Williams' <dan.j.williams@intel.com>, Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu
	Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>


> > Okay, we can move to the symbolic names.  Do you want them to be that
> long, or
> > would:
> >
> > nvdimm-cap-cpu
> > nvdimm-cap-mem-ctrl
> > nvdimm-cap-mirroring
>=20
> Wait, why is mirroring part of this?

This data structure is intended to report any kind of platform capability, =
not=20
just platform persistence capabilities.

We could add a short symbolic name to the definitions in ACPI that matches
the ones selected for this command line option, if that'll help people
find the right names to use.

I recommend mc rather than mem-ctrl to keep dashes as special.
