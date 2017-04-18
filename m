Received: from eggs.gnu.org ([2001:4830:134:3::10]:37456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d0PMZ-0006eL-Jz
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d0PMW-0002yF-HW
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:23:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d0PMW-0002wp-BV
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:23:52 -0400
Message-ID: <1492507428.27392.0.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 18 Apr 2017 11:23:48 +0200
In-Reply-To: <d00b49ff-f541-78c8-2d68-4fa4e76ae8de@twiddle.net>
References: <20170404102315.24923-1-kraxel@redhat.com>
	<20170404102315.24923-4-kraxel@redhat.com>
	<d00b49ff-f541-78c8-2d68-4fa4e76ae8de@twiddle.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 03/10] vga: add vga_scanline_invalidated
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

> > +static bool vga_scanline_invalidated(VGACommonState *s, int y)
> > +{
> > +    if (y >=3D VGA_MAX_HEIGHT) {
> > +        return false;
> > +    }
> > +    return s->invalidated_y_table[y >> 5] |=3D 1 << (y & 0x1f);
> > +}

> The return stmt doesn't match what you're replacing.  Are you really inte=
nding=20
> to modify invalidated_y_table here?

No.  Really stupid cut&paste bug.  Fixed.

thanks,
  Gerd
