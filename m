Received: from eggs.gnu.org ([2001:4830:134:3::10]:49975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRJoG-00056A-Tz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRJoB-0007rQ-8W
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:00:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fRJoB-0007rA-3w
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:00:11 -0400
Date: Fri, 8 Jun 2018 19:00:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608185945-mutt-send-email-mst@kernel.org>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-3-ross.zwisler@linux.intel.com>
	<20180608021134-mutt-send-email-mst@kernel.org>
	<5b2dafa6-1206-bef3-10d7-eac9910baa85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2dafa6-1206-bef3-10d7-eac9910baa85@redhat.com>
Subject: Re: [Qemu-devel] [qemu PATCH 3/5] hw/i386: Update SSDT table used
 by "make check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Cornelia Huck <cohuck@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Fri, Jun 08, 2018 at 09:24:49AM -0500, Eric Blake wrote:
> On 06/07/2018 06:14 PM, Michael S. Tsirkin wrote:
> > On Thu, Jun 07, 2018 at 04:31:09PM -0600, Ross Zwisler wrote:
> > > This commit:
> > > 
> > > commit aa78a16d8645 ("hw/i386: Rename 2.13 machine types to 3.0")
> > > 
> > > updated the name used to create the q35 machine, which in turn changed the
> > > SSDT table which is generated when we run "make check":
> > > 
> > >    acpi-test: Warning! SSDT mismatch. Actual [asl:/tmp/asl-QZDWJZ.dsl,
> > >    aml:/tmp/aml-T8JYJZ], Expected [asl:/tmp/asl-DTWVJZ.dsl,
> > >    aml:tests/acpi-test-data/q35/SSDT.dimmpxm].
> > > 
> > > Here's the only difference, aside from the checksum:
> > > 
> > >    <     Name (MEMA, 0x07FFF000)
> > >    ---
> > >    >     Name (MEMA, 0x07FFE000)
> > 
> > Weird. How come the phys address changes just because of machine name?
> 
> "2.13" is a different length than "3.0"; depending on whatever other
> alignment coincidences or sharing of similar substrings are in place, this
> obviously shuffled enough data that the one byte change then reflects into
> an entire page boundary difference.

I don't think we expose the version number to guests though - do we?

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
