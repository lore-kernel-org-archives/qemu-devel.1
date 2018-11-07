Received: from eggs.gnu.org ([2001:4830:134:3::10]:37253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKItS-0006h2-1M
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 03:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKIr0-000602-0t
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 03:06:25 -0500
Date: Wed, 7 Nov 2018 09:06:08 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181107080608.vvt5r2lzz3fhnmuq@sirius.home.kraxel.org>
References: <20181106102335.20027-1-kraxel@redhat.com>
	<20181106102335.20027-5-kraxel@redhat.com>
	<20181106093502-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106093502-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] Warn on obsolete and deprecated
 devices.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>

On Tue, Nov 06, 2018 at 09:36:44AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 06, 2018 at 11:23:33AM +0100, Gerd Hoffmann wrote:
> > Print a warning for deprecated and obsolete devices.
> > Also add support state to device listing.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Should we also add a runtime flag to block these?

Yes, probably.  My priority is to hash out the classification
first though, so it isn't in this series yet.

On the cmd line switches:  How much flexibility do we want on this?  We
can go for a simple -future switch, as suggested by armbru, disallowing
obsolete and deprecated devices.  We could go for a full-blown ...

  -policy {experimental,unsupported,...}={enable,warn,disable}

... or something inbetween.

Comments?  Other ideas?

cheers,
  Gerd
