Received: from eggs.gnu.org ([2001:4830:134:3::10]:58576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVgg7-0000xw-Sk
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVgg4-0008Mx-9q
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:37:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVgg4-0008Mt-3P
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:37:04 -0500
Date: Mon, 23 Jan 2017 15:36:59 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170123153658.GJ2853@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170123142629.11110-1-berrange@redhat.com>
	<CAFEAcA_NSRk3wj3iZvhTbR5hxyUVe_4V_dgow=-dPb7KPFCeLQ@mail.gmail.com>
	<CAFEAcA9mrojabfsFfkw+Yb0jRUyB0gs6+SHeLu4sDku1gmfrRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9mrojabfsFfkw+Yb0jRUyB0gs6+SHeLu4sDku1gmfrRA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 0/8] Merge io/ 2017-01-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jan 23, 2017 at 03:24:08PM +0000, Peter Maydell wrote:
> On 23 January 2017 at 14:46, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> > On 23 January 2017 at 14:26, Daniel P. Berrange <berrange@redhat.com>=
 wrote:
> >> The following changes since commit 598cf1c805271564686f2d732b36f50c3=
c40dcdd:
> >>
> >>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' i=
nto staging (2017-01-20 16:42:07 +0000)
> >>
> >> are available in the git repository at:
> >>
> >>   git://github.com/berrange/qemu tags/pull-qio-2017-01-23-1
> >>
> >> for you to fetch changes up to 19f3cc22d364b57315e171090ee2e499b5877=
5b4:
> >>
> >>   io: introduce a DNS resolver API (2017-01-23 11:28:09 +0000)
> >>
> >> ----------------------------------------------------------------
> >> Merge io/ 2017-01-23
> >>
> >> Daniel P. Berrange (8):
> >>   sockets: add ability to disable DNS resolution for InetSocketAddre=
ss
> >>   io: stop incrementing reference in qio_task_get_source
> >>   io: fix typo in docs for QIOTask
> >>   io: add ability to associate an opaque "result" with with a task
> >>   io: add ability to associate an error with a task
> >>   io: change the QIOTask callback signature
> >>   io: remove Error parameter from QIOTask thread worker
> >>   io: introduce a DNS resolver API
> >
> > Fails to build, OSX:
>=20
> Also w32:
> /home/petmay01/linaro/qemu-for-merges/util/qemu-sockets.c: In function
> =E2=80=98inet_listen_saddr=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/util/qemu-sockets.c:145:41:
> error: =E2=80=98AI_NUMERICSERV=E2=80=99 undeclared (first use in this f=
unction)
>          ai.ai_flags |=3D AI_NUMERICHOST | AI_NUMERICSERV;
>                                          ^
> /home/petmay01/linaro/qemu-for-merges/util/qemu-sockets.c:145:41:
> note: each undeclared identifier is reported only once for each
> function it appears in

Ok, that's fairly harmless if missing, so I'll defined it to 0 if
not found.

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
