Received: from eggs.gnu.org ([2001:4830:134:3::10]:41585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7Q02-0006Wi-3A
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7Q00-0006x5-HG
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:06:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g7Q00-0006ww-As
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:06:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id 193-v6so3245746wme.3
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 12:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-11-marcandre.lureau@redhat.com>
	<87o9dhiiuj.fsf@dusky.pond.sub.org>
	<CAMxuvazFSTzR_2fZpLCVciHnBcJKTAmnUto81Z7Tup+m6T_CHg@mail.gmail.com>
In-Reply-To: <CAMxuvazFSTzR_2fZpLCVciHnBcJKTAmnUto81Z7Tup+m6T_CHg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Oct 2018 23:06:11 +0400
Message-ID: <CAJ+F1CJU=APrieMmfXLw02BjEX6hiWXpzwFghp1uDJKtREBE3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/10] qmp: common 'id' handling & make
 QGA conform to QMP spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Sat, Sep 1, 2018 at 4:06 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> On Sat, Sep 1, 2018 at 12:59 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> >> Let qmp_dispatch() copy the 'id' field. That way any qmp client will
> >> conform to the specification, including QGA. Furthermore, it
> >> simplifies the work for qemu monitor.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> >> ---
> >>  monitor.c           | 33 ++++++++++++---------------------
> >>  qapi/qmp-dispatch.c | 10 ++++++++--
> >>  tests/test-qga.c    | 13 +++++--------
> >>  3 files changed, 25 insertions(+), 31 deletions(-)
> >
> > Let's squash in
> >
> > diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
> > index 8f7da0245d..5fdfb2a4d0 100644
> > --- a/docs/interop/qmp-spec.txt
> > +++ b/docs/interop/qmp-spec.txt
> > @@ -109,6 +109,7 @@ or
> >    command execution, it is optional and will be part of the response
> >    if provided.  The "id" member can be any json-value.  A json-number
> >    incremented for each successive command works fine.
> > +- Older versions of the QEMU Guest agent do not support "id".
>
> Good idea. Are you taking and updating the patch, or Michael?
>

any of you taking the patch?

thanks

--=20
Marc-Andr=C3=A9 Lureau
