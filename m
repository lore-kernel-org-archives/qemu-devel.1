Received: from eggs.gnu.org ([2001:4830:134:3::10]:41358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dJLy0-0003Ku-1t
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dJLxz-0005kc-30
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:36:52 -0400
MIME-Version: 1.0
References: <20170609152017.7286-1-eblake@redhat.com>
	<20170609152017.7286-2-eblake@redhat.com>
	<CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
	<b3e66ce9-d503-bf6f-cd93-511097418480@redhat.com>
In-Reply-To: <b3e66ce9-d503-bf6f-cd93-511097418480@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 09 Jun 2017 15:36:38 +0000
Message-ID: <CAJ+F1CJTTjU_yLXabC5MaVktbmz6drZ6AwusdvEy15XAu_f7yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qobject: Update coccinelle script to
 catch Q{INC, DEC}REF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com

On Fri, Jun 9, 2017 at 7:33 PM Eric Blake <eblake@redhat.com> wrote:

> On 06/09/2017 10:28 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Jun 9, 2017 at 7:20 PM Eric Blake <eblake@redhat.com> wrote:
> >
> >> A recent patch submission was about to use qobject_decref(QOBJECT(E)),
> >> even though we already have QDECREF(E) for that purpose.  While our
> >> tree is currently free from the longhand form, we might as well update
> >>
> >
> > Oh?
> >
> >  $ git grep 'object_unref(OBJECT('  | wc -l
> > 152
>
> Quit mixing QOM and QObject ;)
>
> $ git grep qobject_'..cref(QOBJECT'
> include/qapi/qmp/qobject.h:    qobject_incref(QOBJECT(obj))
> scripts/coccinelle/qobject.cocci:- qobject_incref(QOBJECT(E));
> scripts/coccinelle/qobject.cocci:- qobject_decref(QOBJECT(E));
>
>
>
Yeah, I got mixed by your comments, my patch doesn't do
qobject_decref(QOBJECT(E)) but object_unref(OBJECT(E)), which doesn't have
macro helper afaik.


> Yes, we may want to add a script to clean QOM abuses, but that's a
> different project for a different day.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266 <+1%20919-301-3266>
> Virtualization:  qemu.org | libvirt.org
>
> --
Marc-Andr=C3=A9 Lureau
