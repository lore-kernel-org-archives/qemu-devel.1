Received: from eggs.gnu.org ([2001:4830:134:3::10]:48751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evNI7-0001J9-NJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evNI4-0000rC-GH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:15:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evNI4-0000qT-A1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:15:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73BFC4000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 13:14:56 +0000 (UTC)
Date: Mon, 12 Mar 2018 13:14:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312131445.GS3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180312124939.20562-1-berrange@redhat.com>
	<c9bbe182-4a13-0063-4ce8-98151f1bd228@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9bbe182-4a13-0063-4ce8-98151f1bd228@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Enable passing pre-opened chardev
 socket FD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Mar 12, 2018 at 08:12:44AM -0500, Eric Blake wrote:
> On 03/12/2018 07:49 AM, Daniel P. Berrang=C3=A9 wrote:
> > An update of:
> >=20
> >    v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04618=
.html
> >    v2: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04706=
.html
> >    v3: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04892=
.html
> >    v4: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00950=
.html
> >=20
> > This enables fixing a long standing problem that libvirt has with
> > starting up QEMU. It has to busy-wait retrying connect() on the QMP
> > monitor socket until QEMU finally creates & listens on it, but at sam=
e
> > time must be careful to not wait forever if QEMU exits.
> >=20
> > With this patch series, libvirt can simply pass in a pre-opened UNIX =
domain
> > socket file descriptor, which it can immediately connect to with no b=
usy-wait.
> >=20
> > NB, this will generate one expected failure with patchew / checkpatch=
.pl
>=20
> >=20
> > Changed in v5:
> >=20
> >    - Docs typo (Eric)
> >    - Fix errno setting in int parsing code (Eric)
> >=20
>=20
> > Daniel P. Berrang=C3=A9 (9):
> >    char: don't silently skip tn3270 protocol init when TLS is enabled
> >    cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned in=
t
> >      types
> >    sockets: pull code for testing IP availability out of specific tes=
t
> >    sockets: strengthen test suite IP protocol availability checks
> >    sockets: move fd_is_socket() into common sockets code
> >    sockets: check that the named file descriptor is a socket
> >    sockets: allow SocketAddress 'fd' to reference numeric file
> >      descriptors
> >    char: refactor parsing of socket address information
> >    char: allow passing pre-opened socket file descriptor at startup
>=20
> Whose tree should this go through?  It's got some QAPI impact, so I'm o=
kay
> including it in my QAPI pull request later today, if there is no better
> tree...

These days I usually send PR for stuff touching sockets code myself. So
unless someone else strongly prefers to take it via their tree for sake
of any easy of conflict / merge resolution, I can do a PR once acked.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
