Received: from eggs.gnu.org ([2001:4830:134:3::10]:43347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7IMu-0006O4-Pr
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7IKg-0005cW-FQ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:55:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g7IKf-0005bc-Ui
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:55:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id z3-v6so1633692wrr.13
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<120d75f8-24f7-641a-9b30-4a1ebfbca34d@redhat.com>
In-Reply-To: <120d75f8-24f7-641a-9b30-4a1ebfbca34d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Oct 2018 14:54:59 +0400
Message-ID: <CAJ+F1CKjf6APRYSJVmRCf04vVHDyLSjHxsKr+KGFL+jcLEN68Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/12] Various qemu command line options
 help improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi

On Tue, Sep 11, 2018 at 5:17 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/09/2018 09:59, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > This is a compilation of patches I have to improve command line help
> > support. The "qemu-option" patches have already been sent earlier, I
> > modified the first to fix an issue reported by Markus. The other
> > patches add support for -object help. A few related patches for QOM,
> > to fix/improve some minor issues.
> >
> > v2: after Eric Blake review
> > - add "qdev-monitor: print help to stdout"
> > - add "cutils: add qemu_pstrcmp"
> > - use consistently "arg=3Dtype - desc" help format
>
> Feel free to send a pull request yourself with the minor fixes requested
> during review.

It would be nice to get some more review before :)

Andreas, as QOM maintainer, do you have time to take a look?

Anybody else interested to improve the CLI?

thanks

> Paolo
>
> > Marc-Andr=C3=A9 Lureau (12):
> >   qdev-monitor: print help to stdout
> >   cutils: add qemu_pstrcmp
> >   qemu-option: add help fallback to print the list of options
> >   qemu-option: improve qemu_opts_print_help() output
> >   qom/object: fix iterating properties over a class
> >   qom/object: register 'type' property as class property
> >   tests/qom-proplist: check duplicate "bv" property registration failed
> >   tests/qom-proplist: check properties are not listed multiple times
> >   tests/qom-proplist: check class properties iterator
> >   vl: handle -object help
> >   hostmem: add some properties description
> >   vl: list user creatable properties when 'help' is argument
> >
> >  include/monitor/monitor.h  |  2 ++
> >  include/qemu/cutils.h      | 12 +++++++
> >  backends/hostmem-memfd.c   |  9 +++++
> >  backends/hostmem.c         | 14 ++++++++
> >  monitor.c                  | 16 +++++++--
> >  qdev-monitor.c             | 32 ++++++++++-------
> >  qom/object.c               |  9 ++---
> >  qom/object_interfaces.c    |  6 ++--
> >  tests/check-qom-proplist.c | 58 ++++++++++++++++++++-----------
> >  util/cutils.c              |  5 +++
> >  util/qemu-option.c         | 71 +++++++++++++++++++++++++++++++-------
> >  vl.c                       | 53 ++++++++++++++++++++++++++--
> >  12 files changed, 227 insertions(+), 60 deletions(-)
> >
>
>


--=20
Marc-Andr=C3=A9 Lureau
