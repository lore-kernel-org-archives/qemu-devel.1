Received: from eggs.gnu.org ([2001:4830:134:3::10]:35184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQqhX-0000lR-1i
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 02:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQqhS-0004ll-96
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 02:18:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQqhS-0004lf-2o
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 02:18:30 -0500
Message-ID: <1484032706.19018.82.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Jan 2017 08:18:26 +0100
In-Reply-To: <CAFEAcA_npQNeiSosYGEX2N4OofNaYk_nuti9rhYk12HByVPfFQ@mail.gmail.com>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA_npQNeiSosYGEX2N4OofNaYk_nuti9rhYk12HByVPfFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PULL v2 00/11] ui patch queue
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

  Hi,

> >   git://git.kraxel.org/qemu tags/pull-ui-20170109-1

> Hi. I'm afraid this fails to build on OSX:
>=20
> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:688:21: error: use of
> undeclared identifier 'MOUSE_EVENT_WHEELUP'
>                     MOUSE_EVENT_WHEELUP : MOUSE_EVENT_WHEELDN;
>                     ^
> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:710:45: error: use of
> undeclared identifier 'MOUSE_EVENT_WHEELUP'
>                 [INPUT_BUTTON_WHEEL_UP]   =3D MOUSE_EVENT_WHEELUP,
>                                             ^
> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:711:45: error: use of
> undeclared identifier 'MOUSE_EVENT_WHEELDN'
>                 [INPUT_BUTTON_WHEEL_DOWN] =3D MOUSE_EVENT_WHEELDN,

Pushed new tag:

  git://git.kraxel.org/qemu tags/pull-ui-20170110-1

Dropped offending patch (8/11), no other changes.

cheers,
  Gerd
