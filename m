Received: from eggs.gnu.org ([2001:4830:134:3::10]:39050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVLkx-0000a8-Ka
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVLks-0006l0-O9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVLks-0006kL-Ec
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:48:54 -0400
Date: Wed, 12 Jul 2017 14:48:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170712174844.GH6020@localhost.localdomain>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712145121.GF6020@localhost.localdomain>
	<8760ex4q1x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8760ex4q1x.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 05:45:30PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
[...]
> > It could be changed to something like this:
> >
> >   Supported machines are:
> >   pc-i440fx-2.9        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-2.8        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-2.7        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-2.6        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-2.5        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-2.4        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-2.3        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-2.2        Standard PC (i440FX + PIIX, 1996)
> >   pc                   Standard PC (i440FX + PIIX, 1996) (alias of pc-i440fx-2.10)
> >   pc-i440fx-2.10       Standard PC (i440FX + PIIX, 1996) (default)
> >   pc-i440fx-2.1        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-2.0        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-1.7        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-1.6        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-1.5        Standard PC (i440FX + PIIX, 1996)
> >   pc-i440fx-1.4        Standard PC (i440FX + PIIX, 1996)
> >   pc-1.3               Standard PC (i440FX + PIIX, 1996)
> >   pc-q35-2.9           Standard PC (Q35 + ICH9, 2009)
> >   pc-q35-2.8           Standard PC (Q35 + ICH9, 2009)
> >   pc-q35-2.7           Standard PC (Q35 + ICH9, 2009)
> >   pc-q35-2.6           Standard PC (Q35 + ICH9, 2009)
> >   pc-q35-2.5           Standard PC (Q35 + ICH9, 2009)
> >   pc-q35-2.4           Standard PC (Q35 + ICH9, 2009)
> >   q35                  Standard PC (Q35 + ICH9, 2009) (alias of pc-q35-2.10)
> >   pc-q35-2.10          Standard PC (Q35 + ICH9, 2009)
> >   isapc                ISA-only PC
> >   none                 empty machine
> >
> >   Deprecated machines: pc-1.2, pc-1.1, pc-1.0, pc-0.15, pc-0.14, pc-0.13,
> >                        pc-0.12, pc-0.11, pc-0.10.
> 
> I'd add "(deprecated)" to the existing lines instead.  Probably simpler
> to code, because it's consistent with the existing format.

That would be good enough to me, and probably a one-line patch.
My intention was to hide the deprecated machines in a corner,
separated from the "Supported machines" list.

-- 
Eduardo
