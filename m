Received: from eggs.gnu.org ([2001:4830:134:3::10]:33034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fQi2f-0006rH-R6
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fQi2e-00070t-Od
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:40:37 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1fQi2e-0006xd-JL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:40:36 -0400
Received: by mail-ot0-x241.google.com with SMTP id i19-v6so9356661otk.10
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 16:40:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB1169403448C8AA5FF267F6A6AB650@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180521163203.26590-4-ross.zwisler@linux.intel.com>
	<20180605182243-mutt-send-email-mst@kernel.org>
	<20180605164205.GA21034@linux.intel.com>
	<CAPcyv4jSoFifTc05WGgxkEX6i7b12zYyB+VchJVW_+QPQzO7Fg@mail.gmail.com>
	<20180605213547-mutt-send-email-mst@kernel.org>
	<20180605220700.GB16066@linux.intel.com>
	<CAPcyv4irudGth3+WZtgF4TjGL53s8mN70aVXpGWjj_Lc=7AMVg@mail.gmail.com>
	<AT5PR8401MB1169403448C8AA5FF267F6A6AB650@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 6 Jun 2018 16:40:31 -0700
Message-ID: <CAPcyv4gwsasnnt=LpU5wgbjvL8=w+fErCPtNHyRDGO1iQukYnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Jun 6, 2018 at 4:20 PM, Elliott, Robert (Persistent Memory)
<elliott@hpe.com> wrote:
>
>> > Okay, we can move to the symbolic names.  Do you want them to be that
>> long, or
>> > would:
>> >
>> > nvdimm-cap-cpu
>> > nvdimm-cap-mem-ctrl
>> > nvdimm-cap-mirroring
>>
>> Wait, why is mirroring part of this?
>
> This data structure is intended to report any kind of platform capability, not
> just platform persistence capabilities.

Yes, but here's nothing actionable that a qemu guest OS can do with
that mirroring information, so there's no need at this time to add cli
cruft and code to support it.
