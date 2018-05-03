Received: from eggs.gnu.org ([2001:4830:134:3::10]:39592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fEEWH-0005PP-Ct
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fEEWE-0001K5-2K
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:43:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fEEWD-0001Jh-UA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:43:33 -0400
Date: Thu, 3 May 2018 15:43:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
	<CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, May 03, 2018 at 10:26:40AM +0100, Peter Maydell wrote:
> On 3 May 2018 at 10:07, Daniel P. Berrang=E9 <berrange@redhat.com> wrot=
e:
> > On Thu, May 03, 2018 at 08:21:00AM +0100, Stefan Hajnoczi wrote:
> >> I don't see an issue with time-based numbering schemes.  Ubuntu made=
 it
> >> popular and other projects (like DPDK) are doing the same thing now.
> >>
> >> The convention is YY.MM though, not YYMM.
> >
> > It feels like we've got quite a strong backing for time based version=
ing
> > amongst people replying here. I'd be happy with YY.MM
>=20
> I'm not hugely in favour mostly because I don't much like
> changing version numbering formats -- does it really gain
> us anything? But I guess it's a bit of a bikeshed-colour question.

Well, major/minor numbers don't mean anything.  So I think it makes
sense to give them a meaning, and given we do time-based releases it
surely makes sense to use a time-based scheme.  Major indicating the
year is the obvious and common choice here.  Various variants are in
use:

  (a) major equals year, minor equals month (ubuntu style).
  (b) major equals year, minor counts up (mesa style).
  (c) major is bumped each year, but doesn't equal year (libvirt style).

If we don't want give them a meaning, how about:

  (d) just drop the minor and count up major each release (systemd style)=
?

My personal preference would be (a) or (b), because it is easy to see
when a version was released.  (b) looks more like a classic version
number, we would have 18.0, 18.1, ... instead of 18.04, 18.08, ...

cheers,
  Gerd
