Received: from eggs.gnu.org ([2001:4830:134:3::10]:44023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1d6I06-0001V0-EP
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1d6I03-0003lq-Am
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1d6I03-0003kz-4j
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:44:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A58CC2316FD
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 14:44:57 +0000 (UTC)
Date: Thu, 4 May 2017 10:44:56 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2066796871.7142556.1493909096748.JavaMail.zimbra@redhat.com>
In-Reply-To: <87lgqcadh8.fsf@dusky.pond.sub.org>
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
	<20170504125432.21653-3-marcandre.lureau@redhat.com>
	<87lgqcadh8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] qmp-shell: ignore query-commands error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

----- Original Message -----
> I'd like to rephrase "ignore query-commands error" to "Cope with
> query-commands error" on commit, if you don't mind.
>=20

No, please do :)
thanks

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > qemu-ga doesn't implement it.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qmp/qmp-shell | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> > index f80d02312a..04b8fa3eae 100755
> > --- a/scripts/qmp/qmp-shell
> > +++ b/scripts/qmp/qmp-shell
> > @@ -126,7 +126,10 @@ class QMPShell(qmp.QEMUMonitorProtocol):
> >          return arg
> > =20
> >      def _fill_completion(self):
> > -        for cmd in self.cmd('query-commands')['return']:
> > +        cmds =3D self.cmd('query-commands')
> > +        if cmds.has_key('error'):
> > +            return
> > +        for cmd in cmds['return']:
> >              self._completer.append(cmd['name'])
> > =20
> >      def __completer_setup(self):
>=20
