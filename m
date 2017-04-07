Received: from eggs.gnu.org ([2001:4830:134:3::10]:45305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cwVYW-0002zq-QH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cwVYV-0001zl-U8
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:12:08 -0400
Received: from mail-lf0-x232.google.com ([2a00:1450:4010:c07::232]:34419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cwVYV-0001zU-Mh
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:12:07 -0400
Received: by mail-lf0-x232.google.com with SMTP id z15so43784446lfd.1
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 08:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-10-git-send-email-amarnath.valluri@intel.com>
	<20170407144100.GL26896@redhat.com>
In-Reply-To: <20170407144100.GL26896@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 07 Apr 2017 15:11:55 +0000
Message-ID: <CAJ+F1CJ1wfP_RS25=gokRvk2y0+-_7pX8adzmBUMZPpaz=AOgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 9/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>
Cc: qemu-devel@nongnu.org, patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com

Hi

On Fri, Apr 7, 2017 at 4:41 PM Daniel P. Berrange

> > +        .name =3D "data-path",
> > +        .type =3D QEMU_OPT_STRING,
> > +        .help =3D "Socket path to use for data exhange",
> > +    },
> > +    {
> > +        .name =3D "ctrl-path",
> > +        .type =3D QEMU_OPT_STRING,
> > +        .help =3D "Socket path to use for out-of-band control messages=
",
> > +    },
>
> I'm still not convinced by the need for 2 separate UNIX sockets, unless
> there's a performance reason, but that looks unlikely.
>
>
We would also need something more than an implementation of the protocol
that qemu is going to rely on as an external dependency.  A protocol
specification would help to start the discussion. Alternatively, I would
suggest to not rely on a public protocol, and implement the helper as part
of qemu with a private protocol (but still documented).

--=20
Marc-Andr=C3=A9 Lureau
