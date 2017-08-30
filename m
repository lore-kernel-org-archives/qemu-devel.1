Received: from eggs.gnu.org ([2001:4830:134:3::10]:60644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn3Nr-0005Q7-Mw
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn3Nn-0003Kt-AG
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:50:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dn3Nn-0003KT-4P
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:50:15 -0400
Date: Wed, 30 Aug 2017 15:50:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170830155008.1babd407@nial.brq.redhat.com>
In-Reply-To: <e3552801-588d-a192-1da4-0cefee5aa483@amsat.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817172249.31cf5e3d@nial.brq.redhat.com>
	<e3552801-588d-a192-1da4-0cefee5aa483@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/8] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, James Hogan <james.hogan@imgtec.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 18 Aug 2017 17:08:29 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 08/17/2017 12:22 PM, Igor Mammedov wrote:
> > On Thu, 17 Aug 2017 01:30:54 -0300
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote: =20
> [...]
> >> Also I couldn't test it with KVM. =20
> > Tested in TCG mode (boots debian mips/mips64 kernel with different cpu =
types),
> > and new CPU leaf types show up on QOM tree as expected (QOMifycation is=
 done as expected) =20
>=20
> you mean the "info qom-tree" output?
>=20
> > and '-cpu help' also works as expected,
> > so with checkpatch issues fixed you may add to patches my
> >=20
> > Tested-by: Igor Mammedov <imammedo@redhat.com> =20
>=20
> ok thanks for the testing!
>=20
> I'll wait to see if there is some KVM feedback from imgtec folks before=20
> spaming a v2.

Philippe,

Are you going to respin series soon?
