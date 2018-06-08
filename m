Received: from eggs.gnu.org ([2001:4830:134:3::10]:36972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRDtM-0002iY-Fv
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRDtJ-0001tV-Ty
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:41:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fRDtJ-0001t0-OT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:41:05 -0400
Date: Fri, 8 Jun 2018 10:41:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180608094101.GG2671@work-vm>
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
	<a51fbf8b-9839-ebc1-cde5-5ae95656f918@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a51fbf8b-9839-ebc1-cde5-5ae95656f918@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

* Andreas F=E4rber (afaerber@suse.de) wrote:
> Am 01.06.2018 um 17:39 schrieb Ricardo Perez Blanco:
> > For debugging purposes it is very useful to:
> >  - See the description of the field. This information is already fill=
ed
> >    in but not shown in "qom-list" command.
>=20
> No objection on this part.
>=20
> >  - Display value of the field.
>=20
> That is by definition the qom-get operation, not qom-list. Just like th=
e
> ls command does not show file contents, there's cat etc. for that. For
> debugging purposes we had a qom-tree (?) command that would combine
> both.

I'm not too bothered about distinguishing between the two commands;
but it would be nice - one reason I'm not too bothered is because we've
failed to get a qom-get in multiple years of trying.


>       There might be unmerged patches on qemu-devel related to display
> of certain data types.

Which ones?

Dave

> Regards,
> Andreas
>=20
> >=20
> > Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
> > ---
> >  hmp.c          | 13 +++++++++++--
> >  qapi/misc.json |  6 ++++--
> >  qmp.c          |  7 +++++++
> >  qom/object.c   |  8 +++-----
> >  4 files changed, 25 insertions(+), 9 deletions(-)
> [snip]
>=20
> --=20
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=FCrnberg)
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
