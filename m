Received: from eggs.gnu.org ([2001:4830:134:3::10]:39015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUZUi-0006jV-F5
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUZUe-0001QT-BX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:53:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gUZUe-0001Pg-5P
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:53:44 -0500
Date: Wed, 5 Dec 2018 08:53:38 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181205085338.358dc9bd@x1.home>
In-Reply-To: <87y394wd9p.fsf@dusky.pond.sub.org>
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394077749.28192.1229512133780284321.stgit@gimli.home>
	<87y394wd9p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 3/9] qapi: Define PCIe link
 speed and width properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>

On Wed, 05 Dec 2018 10:09:38 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Alex Williamson <alex.williamson@redhat.com> writes:
>=20
> > Create properties to be able to define speeds and widths for PCIe
> > links.  The only tricky bit here is that our get and set callbacks
> > translate from the fixed QAPI automagic enums to those we define
> > in PCI code to represent the actual register segment value. =20
>=20
> QAPI can only generate enumerations with values 0, 1, 2, ...  You want
> different enumeration values, namely the actual register values.  You
> still want QAPI to get its standard mapping to and from strings.
>=20
> This patch's solution is to define a non-QAPI enumeration type with the
> values you want [PATCH 1/9], then map between the enumerations in the
> PropertyInfo methods.  Works.
>=20
> You could instead use the encoding chosen by QAPI for the properties,
> and map it to the register values on use.  Differently ugly.  Might be
> simpler.  Your choice to make.

As we discussed offline, I personally don't like using the magic macros
that QAPI generates outside of QAPI code; I can't git grep for them and
I need to remember to build the tree before using cscope in order to
find them.  Therefore I prefer to keep the translation to standard
macros within the QAPI code to make things more obvious, thus the
approach chosen.  I appreciate the feedback and alternative ideas.

> We could extend QAPI to permit specification of the enumeration values.
> Marc-Andr=C3=A9's work to permit conditionals makes the syntax flexible
> enough to support that.  Of course, adding QAPI features is worthwhile
> only if we get sufficient mileage out of them to result in an overall
> improvement.  Even if we decided to do it right now, I'd recommend not
> to wait for it, but instead plan to simplify after the feature lands.

Good to know.

> > Cc: Eric Blake <eblake@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com> =20
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!

Alex
