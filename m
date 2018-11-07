Received: from eggs.gnu.org ([2001:4830:134:3::10]:40799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKJ0a-00039F-7h
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 03:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKJ0T-0000u4-PA
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 03:16:14 -0500
Date: Wed, 7 Nov 2018 09:15:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181107081556.kymoaeozwfbrogyd@sirius.home.kraxel.org>
References: <20181106102335.20027-1-kraxel@redhat.com>
	<20181106102335.20027-3-kraxel@redhat.com>
	<20181106142611.GQ12503@habkost.net>
	<d21f46f3-0cb3-bb4f-2e4b-48752dff440a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21f46f3-0cb3-bb4f-2e4b-48752dff440a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>

  Hi,

> >> +# @experimental: in development, can be unstable or incomplete.
> > 
> > People reading this document would ask: what would appear on
> > MAINTAINERS if SupportState is `experimental`?
> 
> Probably Maintained.  It's something that is on its way towards becoming
> "supported", but still too immature ("unstable or incomplete").

Yep.  For the user there isn't much of a difference between
"experimental" and "unsupported" though, except that "experimental"
indicates that someone is working on it and the chances are higher that
it'll transition to "supported" at some point in the future.  So I'm not
fully sure it makes sense to list that as separate category.

> >> +# @obsolete: is obsolete, still present for compatibility reasons,
> >> +#            will likely be removed at some point in the future.
> 
> I am not sure this is necessarily true.  I don't see Cirrus or adlib or
> pcnet disappearing anytime soon.

So s/will likely/might/ ?

cheers,
  Gerd
