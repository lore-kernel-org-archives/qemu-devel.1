Received: from eggs.gnu.org ([2001:4830:134:3::10]:54165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8YsY-0004Jc-KB
	for qemu-devel@nongnu.org; Wed, 10 May 2017 17:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8YsV-0000cp-D5
	for qemu-devel@nongnu.org; Wed, 10 May 2017 17:10:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8YsV-0000c1-7G
	for qemu-devel@nongnu.org; Wed, 10 May 2017 17:10:35 -0400
Date: Wed, 10 May 2017 18:10:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170510211028.GF3482@thinpad.lan.raisama.net>
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-2-ehabkost@redhat.com>
	<87efvw26nr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87efvw26nr.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] visitor: Add 'supported_qtypes'
 parameter to visit_start_alternate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <mlureau@redhat.com>

On Wed, May 10, 2017 at 03:16:56PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > This will allow visitors to make decisions based on the supported qty=
pes
> > of a given alternate type. The new parameter can replace the old
> > 'promote_int' argument, as qobject-input-visitor can simply check if
> > QTYPE_QINT is set in supported_qtypes.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> Might conflict with Marc-Andr=E9's work, which I haven't reviewed, yet.
> Should be easy enough to resolve, though.

This series is now low-priority for me, as I'm not sure about the
need for "feature=3Dforce" in x86. I won't mind having to rebase
this later.

--=20
Eduardo
