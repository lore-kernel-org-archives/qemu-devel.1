Received: from eggs.gnu.org ([2001:4830:134:3::10]:48298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1csnHf-0003qH-V4
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1csnHf-0000za-1P
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:19:23 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:34820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1csnHe-0000zM-Mq
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:19:22 -0400
Received: by mail-lf0-x22a.google.com with SMTP id j90so34426222lfk.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 02:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <0342808A-63C6-40BE-91AB-B6088AD62CD2@redhat.com>
	<20170316145045.10840-1-vfeenstr@redhat.com>
	<20170316145045.10840-2-vfeenstr@redhat.com>
	<05ad6588-58c5-796c-48b5-05bb6c2dc612@redhat.com>
	<2267A6B3-1C16-406A-B83A-34F17E8D3F98@redhat.com>
	<4EA4009B-C060-4700-BB32-60F9A5254C0F@redhat.com>
In-Reply-To: <4EA4009B-C060-4700-BB32-60F9A5254C0F@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Mar 2017 09:19:09 +0000
Message-ID: <CAJ+F1CJgaZVQSU78Pn4d_AYKfyjCoD0a6jq-xziR0Vq0OtySRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-ga: add guest-get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz Feenstra <vfeenstr@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Hi

On Tue, Mar 28, 2017 at 7:15 AM Vinzenz Feenstra <vfeenstr@redhat.com>
wrote:

> Eric, what you think of this below way, instead?
>
> >
> > OK So how about something like this:
> >
> > {=E2=80=98struct=E2=80=99: =E2=80=98GuestWindowsVersionInfo=E2=80=99,
> >  =E2=80=98data=E2=80=99: {
> >       =E2=80=98version=E2=80=99: =E2=80=98str=E2=80=99,
> >         =E2=80=98name=E2=80=99: =E2=80=98str=E2=80=99,
> > } }
> >
> > {=E2=80=98struct=E2=80=99: =E2=80=98GuestLinuxOSRelease=E2=80=99,
> >  =E2=80=98data=E2=80=99: {
> >         =E2=80=98id=E2=80=99: =E2=80=98str=E2=80=99,
> >         =E2=80=98name=E2=80=99: =E2=80=98str'
> >       =E2=80=98*version=E2=80=99: =E2=80=98str=E2=80=99,
> >         =E2=80=98*variant=E2=80=99: =E2=80=98str=E2=80=99
> >         =E2=80=98*codename=E2=80=99: =E2=80=98str=E2=80=99
> > } }
> >
> > {=E2=80=98enum=E2=80=99: =E2=80=98GuestOSVersionInfo=E2=80=99,
> >  =E2=80=98data=E2=80=99: {=E2=80=98linux=E2=80=99: =E2=80=98 GuestLinux=
OSRelease=E2=80=99,
> >              =E2=80=98win=E2=80=99: =E2=80=98 GuestWindowsVersionInfo=
=E2=80=99
> > }}
> >
>

I think this will be rejected. You could instead use a flat 'union' with a
'type' (see SocketAddressFlat for ex).

Otherwise, I like the approach better if the various os-specific details
are needed.

Wouldn't it be nice instead to return xdg os-release content? On OS that
don't have it, it could be crafted manually. Just an idea..

> { 'struct': 'GuestOSInfo=E2=80=99,
> >     'data': {
> >       =E2=80=98machine': 'str=E2=80=99,
> >       =E2=80=99sysname': 'GuestOSType=E2=80=99,
> >       =E2=80=98release': =E2=80=98str=E2=80=99,
> >       =E2=80=98*version_info=E2=80=99: =E2=80=98GuestOSVersionInfo=E2=
=80=99,
> > } }
> >
>

--=20
Marc-Andr=C3=A9 Lureau
