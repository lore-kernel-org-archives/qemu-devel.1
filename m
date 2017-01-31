Received: from eggs.gnu.org ([2001:4830:134:3::10]:58039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYT5n-0003Bp-UU
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 02:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYT5k-0004It-Ob
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 02:43:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYT5k-0004Ie-Ip
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 02:43:04 -0500
Message-ID: <1485848580.23903.14.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 08:43:00 +0100
In-Reply-To: <1327323310.207981.1485800296146.JavaMail.zimbra@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170123105502.GH29186@stefanha-x1.localdomain>
	<10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
	<20170124114302.GB17221@stefanha-x1.localdomain>
	<1305616133.813189.1485283397962.JavaMail.zimbra@redhat.com>
	<20170130134332.GB2118@stefanha-x1.localdomain>
	<1327323310.207981.1485800296146.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <mlureau@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

  Hi,

> > It would be nice for this series to evolve to a generic QMP jobs series
> > so that all background operations are visible to the client and a usefu=
l
> > subset of management primitives can be implemented on a per-command
> > basis.  Both live migration and existing block jobs could use this code
> > so that we don't have multiple copies of the same infrastructure.
>=20
> Indeed, but I would need to know what proposal or requirements the
> block layer have here, and I would appreciate if they took time to
> review mine.=20

Disclaimer:  Havn't looked into the qmp (especially block jobs) details
too much.

But I suspect we can have both, sharing most of the infrastructure,
without too much effort.

We have block jobs today.  Other areas in qemu can use that too.  So
moving the jobs infrastructure from block to qmp level makes perfect
sense to me.  Live migration and possibly others can start using it.

And once we have that building async commands on top of that is probably
easy.  It'll be just a primitive job which typically takes at most a few
seconds to finish, has no ->cancel() callback and sends a different kind
of completion notification ...

cheers,
  Gerd
