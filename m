Received: from eggs.gnu.org ([2001:4830:134:3::10]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5lbN-0002HK-MD
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5lbK-0000dD-Fi
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:13:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f5lbK-0000cg-9g
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:13:50 -0400
Date: Tue, 10 Apr 2018 13:13:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180410051331.GB27604@xz-mi>
References: <20180409082323.29575-1-peterx@redhat.com>
	<20180409083154.GD18283@redhat.com>
	<CAFEAcA-VS=b31Z=WZEO3sDLntA97px81ErVRZbHcSTxRe1YNEA@mail.gmail.com>
	<5ff4301b-ffda-1b03-ef64-ec107572260f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ff4301b-ffda-1b03-ef64-ec107572260f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: don't warn GTK if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Apr 09, 2018 at 07:37:11PM +0200, Paolo Bonzini wrote:
> On 09/04/2018 11:24, Peter Maydell wrote:
> > On 9 April 2018 at 09:31, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >> Feels to me that since we've deprecated 2.0, we could just *never* a=
uto
> >> detect - just do     test -z "$gtkabi" && gtkabi=3D3.0
> >>
> >> Anyone who wants gtk2 should have to use an explicit --with-gtkabi=3D=
2.0
> >
> > I think if we still work with gtk2 then we should go ahead and
> > warn-but-use it.
>=20
> Both are valid choices of course.  Since we have Peter (Xu)'s patch, I
> think we should go for that and revisit in 2.13 whether to remove GTK+
> 2.0 support altogether, require an explicit configure argument, or leav=
e
> things as they are.

Thanks all. Please anyone let me know if a repost is needed. Otherwise
I'll keep it as is and I can try to post a similar one for SDL.

--=20
Peter Xu
