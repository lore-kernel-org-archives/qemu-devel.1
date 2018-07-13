Received: from eggs.gnu.org ([2001:4830:134:3::10]:53015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5u3-000320-US
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5u3-0005YS-7r
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:47:04 -0400
Date: Fri, 13 Jul 2018 18:46:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713214654.GW31657@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-2-git-send-email-thuth@redhat.com>
	<20180713211636.GS31657@localhost.localdomain>
	<0a63f154-ac68-b6f0-ab6a-e0951c6ae8d5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0a63f154-ac68-b6f0-ab6a-e0951c6ae8d5@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/16] qom/object: Add a new function
 object_initialize_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Fri, Jul 13, 2018 at 11:29:17PM +0200, Andreas F=E4rber wrote:
> Am 13.07.2018 um 23:16 schrieb Eduardo Habkost:
> > I wonder if we should deprecate object_initialize() and support
> > only object_initialize_child() later.  Initializing an object
> > contained inside another one without making it a child of the
> > parent object is a recipe for trouble.
>=20
> The root container object needs to be initialized, too.

If the object is not embedded in another struct, I would expect
it to be created using object_new() instead of
object_initialize().

--=20
Eduardo
