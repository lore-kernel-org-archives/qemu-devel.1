Received: from eggs.gnu.org ([2001:4830:134:3::10]:45348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cH41y-0002S8-Rj
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cH41w-0004Dy-9W
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:31:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cH41w-0004Dl-46
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:31:12 -0500
Message-ID: <1481700666.8440.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Dec 2016 08:31:06 +0100
In-Reply-To: <7ba29954-e3ad-529c-9978-b10d2788f9e4@cendio.se>
References: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
	<1481616362.27088.74.camel@redhat.com>
	<7ba29954-e3ad-529c-9978-b10d2788f9e4@cendio.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] VNC LED state buggy, interop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Ossman <ossman@cendio.se>
Cc: qemu-devel@nongnu.org

On Di, 2016-12-13 at 14:10 +0100, Pierre Ossman wrote:
> On 13/12/16 09:06, Gerd Hoffmann wrote:
> >>   b) Remove the assumption from the code and the protocol.
> >
> > Patches are welcome.
> >
>=20
> I was just aiming for a consensus on the intended behaviour, rather than=
=20
> fix the bug right now. :)
> But all right, attached patch is an attempt.
>=20
> Btw, is there any client that implements this extension yet? I couldn't=
=20
> find anything.
>=20
> Regards

Can you send that with git send-email instead of a attachment?
I can quote the patch for commenting then, also various tools expect
patches that way.

Patch looks good.  Commit message is too short.  You are moving the led
tracking from vncstate to vncdisplay, which makes sense, but this shpuld
be explained in the commit message too.

thanks,
  Gerd
