Received: from eggs.gnu.org ([2001:4830:134:3::10]:51550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQwLc-0008Ls-LC
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQwLb-0003s6-Qb
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:57:08 -0400
Message-ID: <6d393743ee2358c900448a949734fc565a148050.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 07 Jun 2018 16:56:52 +0200
In-Reply-To: <20180607144527.GO2522@work-vm>
References: <39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
	<f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
	<20180607102257.GH28827@redhat.com>
	<2afb9305deb37c8ca4f930235eaf52486ab0153e.camel@redhat.com>
	<20180607123847.GL28827@redhat.com> <20180607134953.GN2522@work-vm>
	<63fece55c4708744d9289fedf42d67ebb1bccbdd.camel@redhat.com>
	<20180607144527.GO2522@work-vm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Thu, 2018-06-07 at 15:45 +0100, Dr. David Alan Gilbert wrote:
> * Andrea Bolognani (abologna@redhat.com) wrote:
> > On Thu, 2018-06-07 at 14:49 +0100, Dr. David Alan Gilbert wrote:
> > > Including the nvram and efi makes me nervous; but I can see why together
> > > they might work.  However, there's no guarantee that EFI has been tested
> > > with the QEMU it's used on and ... that could be trouble.
> > 
> > If the QEMU binary doesn't support EFI, then a guest expecting
> > EFI won't be able to start regardless of where the EFI ROM came
> > from.
> 
> No, I mean if the QEMU doesn't support that *particular* EFI.

I could be wrong, but I feel like it's significantly less likely
that a random QEMU binary won't like a random EFI ROM than it is
for a random EFI ROM to not like a random EFI NVRAM.

> > > Also, if we're going to start including the EFI rom then that would have
> > > to be migrated with the VM so that after a restart on a different host
> > > it's still using the right ROM that's compatible with it's varfile.
> > 
> > That's a problem that needs to be addressed anyway, because even
> > as it is now you could easily find yourself trying and failing
> > to migrate a guest between two hosts that have different and
> > incompatible EFI ROMs installed.
> 
> True; although I was working on the basis that vendors who cared about
> migration compatibility would couple the EFI versions with machine types
> to ensure that the variable data didn't become incompatible.

As far as I know, nobody is actually doing this at the moment.

-- 
Andrea Bolognani / Red Hat / Virtualization
