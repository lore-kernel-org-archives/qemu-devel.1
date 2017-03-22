Received: from eggs.gnu.org ([2001:4830:134:3::10]:51044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqfKv-0008GL-RC
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqfKs-0003NB-M1
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cqfKs-0003Mt-Fm
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:25:54 -0400
Date: Wed, 22 Mar 2017 13:25:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170322132549.3d7e2a49@nial.brq.redhat.com>
In-Reply-To: <1f744cad-f67b-92d3-b4e4-32f8b05c643c@redhat.com>
References: <87bmstu19t.fsf@dusky.pond.sub.org>
	<1f744cad-f67b-92d3-b4e4-32f8b05c643c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Minimum RAM size for PC machines?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, seabios@seabios.org, =?UTF-8?B?TMOh?= =?UTF-8?B?c3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

On Wed, 22 Mar 2017 11:03:44 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 22.03.2017 10:08, Markus Armbruster wrote:
> [...]
> > Are we now ready to accept a simple & stupid patch that actually helps
> > users, say letting boards that care declare minimum and maximum RAM
> > size?  And make PC reject RAM size less than 1MiB, even though "someone"
> > might conceivably have firmware that works with less? =20
>=20
> I'd say enforce a minimum RAM size on the normal "pc" and "q35" machine,
> but still allow smaller sizes on the "isapc" machine. So if "someone"
> comes around and claims to have a legacy firmware that wants less memory
> than 1MiB, just point them to the isapc machine.
> Just my 0.02 =E2=82=AC.
We can print warning that minimum size will be enforced in 1-2 releases sin=
ce 2.9/10
and when it's enforced send users that need less to an old qemu version.

>  Thomas
>=20
>=20
