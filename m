Received: from eggs.gnu.org ([2001:4830:134:3::10]:59679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVOIs-00021l-Dy
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVOIp-00088f-9F
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:32:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dVOIo-00087T-VZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:32:07 -0400
Date: Wed, 12 Jul 2017 23:31:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170712232214-mutt-send-email-mst@kernel.org>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712145121.GF6020@localhost.localdomain>
	<20170712181652-mutt-send-email-mst@kernel.org>
	<20170712201550.GN6020@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712201550.GN6020@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, Jul 12, 2017 at 05:15:50PM -0300, Eduardo Habkost wrote:
> On Wed, Jul 12, 2017 at 06:17:55PM +0300, Michael S. Tsirkin wrote:
> > On Wed, Jul 12, 2017 at 11:51:21AM -0300, Eduardo Habkost wrote:
> > > On Wed, Jul 12, 2017 at 10:22:33AM +0200, Thomas Huth wrote:
> > > > We don't want to carry along old machine types forever. If we are able to
> > > > remove the pc machines up to 0.13 one day for example, this would allow
> > > > us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
> > > > BARs directly to low memory). Everything up to pc-1.2 is also known to
> > > > have issues with migration.  So let's start with a deprecation message
> > > > for the old machine types so that the (hopefully) few users of these old
> > > > systems start switching over to newer machine types instead.
> > > > 
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > 
> > > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > > 
> > > I suggest changing "-machine help" too.  Today it looks like this:
> > > 
> > >   Supported machines are:
> > >   pc-i440fx-2.9        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-2.8        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-2.7        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-2.6        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-2.5        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-2.4        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-2.3        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-2.2        Standard PC (i440FX + PIIX, 1996)
> > >   pc                   Standard PC (i440FX + PIIX, 1996) (alias of pc-i440fx-2.10)
> > >   pc-i440fx-2.10       Standard PC (i440FX + PIIX, 1996) (default)
> > >   pc-i440fx-2.1        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-2.0        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-1.7        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-1.6        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-1.5        Standard PC (i440FX + PIIX, 1996)
> > >   pc-i440fx-1.4        Standard PC (i440FX + PIIX, 1996)
> > >   pc-1.3               Standard PC (i440FX + PIIX, 1996)
> > >   pc-1.2               Standard PC (i440FX + PIIX, 1996)
> > >   pc-1.1               Standard PC (i440FX + PIIX, 1996)
> > >   pc-1.0               Standard PC (i440FX + PIIX, 1996)
> > >   pc-0.15              Standard PC (i440FX + PIIX, 1996)
> > >   pc-0.14              Standard PC (i440FX + PIIX, 1996)
> > >   pc-0.13              Standard PC (i440FX + PIIX, 1996)
> > >   pc-0.12              Standard PC (i440FX + PIIX, 1996)
> > >   pc-0.11              Standard PC (i440FX + PIIX, 1996)
> > >   pc-0.10              Standard PC (i440FX + PIIX, 1996)
> > >   pc-q35-2.9           Standard PC (Q35 + ICH9, 2009)
> > >   pc-q35-2.8           Standard PC (Q35 + ICH9, 2009)
> > >   pc-q35-2.7           Standard PC (Q35 + ICH9, 2009)
> > >   pc-q35-2.6           Standard PC (Q35 + ICH9, 2009)
> > >   pc-q35-2.5           Standard PC (Q35 + ICH9, 2009)
> > >   pc-q35-2.4           Standard PC (Q35 + ICH9, 2009)
> > >   q35                  Standard PC (Q35 + ICH9, 2009) (alias of pc-q35-2.10)
> > >   pc-q35-2.10          Standard PC (Q35 + ICH9, 2009)
> > >   isapc                ISA-only PC
> > >   none                 empty machine
> > 
> > Any chance we can sort them reasonably too?
> 
> If we use strverscmp(), it will be sorted in a more reasonable
> way.  We could copy the gnulib version on systems without glibc.
> Life is too short for writing configure checks by hand, though; I
> will add this to the end of my wish-todo list.  If somebody wants
> to volunteer, be my guest.
> 
> I'm CCing Eric in case he has suggestions that would help import
> the gnulib module in an easy way.
> 
> -- 
> Eduardo

As we never have leading zeroes, and input comes from QEMU so
it's safe, it's probably easier to just open-code it:

/* compare string numerically: shorter strings give smaller numbers */
int mstcmp(const char *s1, const char *s2)
{
	int l1, l2;

	l1 = strlen(s1);
	l2 = strlen(s2);
	return l1 == l2 ? strcmp(s1, s2) : l1 - l2;
}

feel free to rename and include.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

-- 
MST
