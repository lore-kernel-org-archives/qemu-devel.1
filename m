Received: from eggs.gnu.org ([2001:4830:134:3::10]:41270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d0mx8-0005wE-Kw
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d0mx5-0000pc-Ew
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:35:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d0mx5-0000on-8P
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:35:11 -0400
Message-ID: <1492598104.6853.16.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Apr 2017 12:35:04 +0200
In-Reply-To: <87r30prlif.fsf@dusky.pond.sub.org>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
	<20170403141912.GA3539@stefanha-x1.localdomain>
	<87fuhf9kcz.fsf@dusky.pond.sub.org>
	<20170418095103.GF21261@stefanha-x1.localdomain>
	<1492516675.27392.45.camel@redhat.com>
	<7ae1e13f-b6a0-a735-3952-4e3833e34ad8@redhat.com>
	<87r30prlif.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> >> We probably want something like
> >>   -qom-set-property {objpath|alias}.prop=3Dvalue
>=20
> Makes sense to me.
>=20
> We should be able to desugar -net, ... to -qom-set-property then.
> However, the desugaring would be machine-specific in general.

Yes.  Establishing rules for alias names for builtin devices should
reduce the pain, and allow stuff like this:

  -netdev user,id=3Dmynetdev \
  -qom-set-property buildin-nic0.netdev=3Dmynetdev

We probably also want a shorter name for -qom-set-property, and maybe
also syntax which allows to set multiple properties in one go, so the
command line doesn't become too long.

cheers,
  Gerd
