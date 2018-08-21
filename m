Received: from eggs.gnu.org ([2001:4830:134:3::10]:57067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fs3ft-000687-Be
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fs3fp-0000Q7-GY
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:14:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fs3fn-0000OJ-Kv
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:14:04 -0400
Date: Tue, 21 Aug 2018 11:13:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180821101357.GJ7370@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<CAJ+F1CKHrOyD91HLk16eQFjV4JfWpH6poq_Svdihav15kJ62yw@mail.gmail.com>
	<20180821075130.tlqk6hv2dbry2iem@sirius.home.kraxel.org>
	<CAJ+F1CLboeQZXWs5gVoc+Ugwq6A7bGdQ=Twg05i_1iXg445oEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLboeQZXWs5gVoc+Ugwq6A7bGdQ=Twg05i_1iXg445oEg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/29] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Tue, Aug 21, 2018 at 12:10:46PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Aug 21, 2018 at 9:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote=
:
> >
> >   Hi,
> >
> > > > Feedback welcome,
> > >
> > > ping
> >
> > Cherry-picked two patches for the ui pull request.
>=20
> thanks
>=20
> >
> > What is the plan for the command line handling, specifically the patc=
h
> > tagged with HACK?
>=20
> The RFC libvirt series doesn't use it.
>=20
> However, it's very convenient for qemu command line users. Daniel
> doesn't want g_shell_parse_argv(), but he would like the -object json:
> command line form instead. I don't know what is the status about
> supporting that syntax.

IIRC the last suggestion I saw was to not allow custom ARGV at all ?
ie define a standard contract that all scripts must follow, as we
have done with the ifup scripts.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
