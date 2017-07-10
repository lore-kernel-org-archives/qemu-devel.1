Received: from eggs.gnu.org ([2001:4830:134:3::10]:57973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dUUa9-00035G-KA
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dUUa5-0007ec-Nt
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:02:17 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:59828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dUUa5-0007eD-HE
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:02:13 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 7DB886AAC0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 11:02:10 +0200 (CEST)
Date: Mon, 10 Jul 2017 11:02:02 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170710110202.4933fd05@bahia.lan>
In-Reply-To: <20170707121214.GS12152@localhost.localdomain>
References: <20170706183014.GH12152@localhost.localdomain>
	<1499396048-21657-1-git-send-email-peterx@redhat.com>
	<20170707121214.GS12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/gqewtQyfgNGBRa2.+3YB5W5";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2.2 3/4] doc: add item for "-M
 enforce-config-section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, lvivier@redhat.com, quintela@redhat.com, dgilbert@redhat.com

--Sig_/gqewtQyfgNGBRa2.+3YB5W5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Jul 2017 09:12:14 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Jul 07, 2017 at 10:54:08AM +0800, Peter Xu wrote:
> > It's never documented, and now we have one more parameter for it (which
> > obsoletes this one). Document it properly.
> >=20
> > Although now when enforce-config-section is set, it'll override the
> > other "-global" parameter, that is not necessarily a rule. Forbid that
> > usage in the document. =20
>=20
> This paragraph looks obsolete now, as now the documentation
> doesn't explicitly forbid mixing the two options.  If it gets
> removed:
>=20

Same for me.

> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20

Reviewed-by: Greg Kurz <groug@kaod.org>

> Juan, will you queue it through your tree?
>=20
> Thanks!
>=20
> >=20
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > v2.1 -> v2.2
> > - remove the last two lines of document [Eduardo]
> >=20
> >  qemu-options.hx | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 297bd8a..cd95516 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -85,6 +85,12 @@ Enables or disables NVDIMM support. The default is o=
ff.
> >  @item s390-squash-mcss=3Don|off
> >  Enables or disables squashing subchannels into the default css.
> >  The default is off.
> > +@item enforce-config-section=3Don|off
> > +If @option{enforce-config-section} is set to @var{on}, force migration
> > +code to send configuration section even if the machine-type sets the
> > +@option{migration.send-configuration} property to @var{off}.
> > +NOTE: this parameter is deprecated. Please use @option{-global}
> > +@option{migration.send-configuration}=3D@var{on|off} instead. =20
>=20


--Sig_/gqewtQyfgNGBRa2.+3YB5W5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlljQooACgkQAvw66wEB28L6EgCfWPn5L0xxMQFgIb5RMgj0JQm6
CscAoJOKm57TnVvPE0ZxhcOjxuzwafxC
=jkZx
-----END PGP SIGNATURE-----

--Sig_/gqewtQyfgNGBRa2.+3YB5W5--
