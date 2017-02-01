Received: from eggs.gnu.org ([2001:4830:134:3::10]:59032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYwDt-00006V-UC
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYwDp-0002zd-MN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:49:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cYwDp-0002zI-Fw
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:49:21 -0500
Date: Wed, 1 Feb 2017 16:49:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170201164701-mutt-send-email-mst@kernel.org>
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
	<CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
	<20170131165802-mutt-send-email-mst@kernel.org>
	<fe787fcc-0c92-5842-1a67-b50466b6f38f@redhat.com>
	<20170131201333-mutt-send-email-mst@kernel.org>
	<20170201123739.387de47b@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170201123739.387de47b@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Feb 01, 2017 at 12:37:39PM +0100, Igor Mammedov wrote:
> On Tue, 31 Jan 2017 20:17:02 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Jan 31, 2017 at 05:28:57PM +0100, Laszlo Ersek wrote:
> > > The ACPI 6.1 spec says,
> > > 
> > > - DSDT: [...] If the X_DSDT field contains a non-zero value then this
> > >   field must be zero.
> > > - X_DSDT: [...] If the DSDT field contains a non-zero value then this
> > >   field must be zero.  
> > 
> > But that's only 6.1. 6.0 and earlier did not say this.
> > The errata they wanted to address was:
> > 1393 In FADT: if X_DSDT field is non-zero, DSDT
> > field should be ignored or deprecated
> > 
> > I would class this as a spec bug.
> > 
> 
> The same applies to X_PM1a_EVT_BLK and co,
> for example 5.1 spec "This is a required
> field."
> 
> And looks like Windows implemented it as mandatory
> to boot perhaps to be compatible with 5.1 and earlier
> specs.
> 
> It appears fw would be forced to fill fields depending
> on table revision.

Or just do what every hardware vendor does:
1. write according to spec
2. test a bunch of OSes, fix crashes


-- 
MST
