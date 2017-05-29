Received: from eggs.gnu.org ([2001:4830:134:3::10]:44774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFJbi-00033k-BT
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFJbf-00030B-7L
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:17:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFJbf-0002zS-1P
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:17:07 -0400
Message-ID: <1496060222.5201.0.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 May 2017 14:17:02 +0200
In-Reply-To: <20170526233816.47627-1-ianloic@google.com>
References: <20170526233816.47627-1-ianloic@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian McKellar <ianloic@google.com>, qemu-devel@nongnu.org

On Fri, 2017-05-26 at 16:38 -0700, Ian McKellar wrote:
> I had two problems with QEMU on macOS:
> =C2=A01) Sometimes when alt-tabbing to QEMU it would act as if the 'a' ke=
y
> =C2=A0=C2=A0=C2=A0=C2=A0was pressed so I'd get 'aaaaaaaaa....'.
> =C2=A02) Using Sikuli to programatically send keys to the QEMU window tex=
t
> =C2=A0=C2=A0=C2=A0=C2=A0like "foo_bar" would come out as "fooa-bar".
>=20
> They looked similar and after much digging the problem turned out to
> be
> the same. When QEMU's ui/cocoa.m received an NSFlagsChanged NSEvent
> it
> looked at the keyCode to determine what modifier key changed. This
> usually works fine but sometimes the keyCode is 0 and the app should
> instead be looking at the modifierFlags bitmask. Key code 0 is the
> 'a'
> key.
>=20
> I added code that handles keyCode =3D=3D 0 differently. It checks the
> modifierFlags and if they differ from QEMU's idea of which modifier
> keys are currently pressed it toggles those changed keys.
>=20
> This fixes my problems and seems work fine.

Added to ui queue.

thanks,
  Gerd
