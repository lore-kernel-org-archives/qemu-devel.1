Received: from eggs.gnu.org ([2001:4830:134:3::10]:43677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHV6f-0007YB-IC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHV6c-0000ik-20
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:34:57 -0400
Date: Tue, 30 Oct 2018 11:34:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181030143444.GU3902@habkost.net>
References: <20181030111348.14713-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030111348.14713-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] Introducing QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>

On Tue, Oct 30, 2018 at 12:13:44PM +0100, Gerd Hoffmann wrote:
> Trying to fill the need to be more finegrained on support status ...
> 
> Any hints/patches how to hook that into introspection so we get
> machine type / device support status to libvirt are welcome.

We have qom-list-types, but it returns info for all QOM types,
not just device types.

I see two possible approaches for this:

* Decide that every QOM type (devices, backend objects,
  machine-types) will have this flag, and just add it to
  qom-list-types.
* Add device-list-types or query-device-type commands,
  specific for TYPE_DEVICE.

I'm not sure which one is better.  The latter is more
conservative and safer, but will require duplicating the same
work for machine-types and backend objects later.

-- 
Eduardo
