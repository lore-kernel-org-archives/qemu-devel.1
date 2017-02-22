Received: from eggs.gnu.org ([2001:4830:134:3::10]:42812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgcUD-0002o4-1O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgcUB-0002fw-1S
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:22:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgcUA-0002fV-Qw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:21:58 -0500
Date: Wed, 22 Feb 2017 16:21:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170222192155.GF28403@thinpad.lan.raisama.net>
References: <20161229223815.13705-1-ehabkost@redhat.com>
	<20161230152834.6d1fa963@Igors-MacBook-Pro.local>
	<20161230182308.GK3441@thinpad.lan.raisama.net>
	<20170103140252.1a2df147@nial.brq.redhat.com>
	<20170103142223.GB3315@thinpad.lan.raisama.net>
	<e27ac12b-9e41-f145-ca05-385d4edd2738@redhat.com>
	<20170103175327.61778555@Igors-MacBook-Pro.local>
	<20170103170602.GD3315@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170103170602.GD3315@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH] qdev: Make "hotplugged" property read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Tue, Jan 03, 2017 at 03:06:02PM -0200, Eduardo Habkost wrote:
> (CCing libvir-list and Laine)
> 
> On Tue, Jan 03, 2017 at 05:53:27PM +0100, Igor Mammedov wrote:
> > On Tue, 3 Jan 2017 17:10:15 +0100
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > > 
> > > 
> > > On 03/01/2017 15:22, Eduardo Habkost wrote:
> > > >> I didn't know that. Is this documented somewhere?
> > > >> Is it actually used by any existing software?
> > > > not that I know of. But users should be fixed if they are not using it.
> > > > 
> > > > I see. The problem is that the mechanism is undocumented,
> > > > untested, and seems very likely to trigger bugs in device code.
> > > 
> > > I agree.  Why can't hotplugged be migrated?
> > It's probably not migrated because of it's not runtime/guest modified
> > state so we don't have to migrate it as it's know in advance.
> > 
> > For now it should set manually on CLI (-device) with the rest of
> > hotplugged device properties.
> 
> As this recommendation has the potential to trigger hidden bugs
> (and known to trigger a bug in QEMU <= 2.8), I would like it to
> be properly documented, and the documentation/recommendations
> reviewed following the usual patch review process.
> 
> While we don't do that, setting "hotplugged=true" on the
> command-line is an unused, undocumented, untested (and
> unsupported?) feature.

As the ability to set hotplugged=true is still unused and
undocumented, I will resubmit this patch to disable the feature
in QEMU 2.9.

-- 
Eduardo
