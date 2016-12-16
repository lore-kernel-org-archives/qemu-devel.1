Received: from eggs.gnu.org ([2001:4830:134:3::10]:48329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cHwmE-0003dp-4n
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cHwmA-0007SI-WE
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:58:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cHwmA-0007RS-Qs
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:58:34 -0500
References: <CAOgv841deahTvPZ3rNvuGUh7xjtvJBRLSWwmCmMU2Ei3MmTrKA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b42d4aff-4ea4-a254-1534-191d50c4fb15@redhat.com>
Date: Fri, 16 Dec 2016 12:58:31 -0500
MIME-Version: 1.0
In-Reply-To: <CAOgv841deahTvPZ3rNvuGUh7xjtvJBRLSWwmCmMU2Ei3MmTrKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Nesting QEMU Question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joey Connelly <joeyconnelly@u.boisestate.edu>, qemu-devel@nongnu.org



On 12/14/2016 10:03 PM, Joey Connelly wrote:
> Hey QEMU dev group,
>=20
> I have a few questions related to nesting QEMU processes, but first her=
e is
> my system setup:
>=20
>=20
>=20
>    - *HOST MACHINE:* GNU/Linux release 4.5.5 (KVM version follows), Dis=
tro
>    Fedora 24, x86_64 arch, supports Intel VT-x, QEMU 2.6.2, libvirt 1.3=
.3
>=20
>=20
>    - *GUEST ISO:* GNU/Linux release 2.6.13 (KVM version follows), Distr=
o
>    SliTaz 4.0, i686 32-bit arch, does not appear to support Intel VT-x,=
 QEMU
>    0.12.5, does not have libvirt
>=20

I'm not sure what you might mean by a guest OS having KVM and QEMU
packages but not "supporting" VT-x. KVM on Intel platforms _is_ the
support for VT-x.

You might be discovering that when you launch this guest environment
that it does not think your virtual CPU has VT-x, but that's a different
matter. Try searching around for how to enable Nested Virt for KVM.

"by default" this is off, AFAIK:

https://fedoraproject.org/wiki/How_to_enable_nested_virtualization_in_KVM

(Also, QEMU 0.12.5 is practically Precambrian in its age -- I have
massive reservations about your ability to use it to accomplish nested
virt...)

>=20
> My question is primarily in response to this comment from your qemu-dev=
el
> threads:
>=20
> "qemu-system-x86_64 does not support KVM on a 32-bit host", Daniel Berr=
ange.
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2012-09/msg02186.html
>=20
>=20
>=20
>=20
>=20
> *[QUESTION#1.]*
>=20
> Since my guest OS is 32-bit, do I have to use qemu-system-i386 =E2=80=93=
enable-kvm
> on my host so that the guest can create a QEMU process of its own
> supporting KVM? Or are there additional qemu-system-i386 arguments I ne=
ed
> from my host: =E2=80=93cpu <???> -machine <???>
>=20
>=20
>=20
>=20
>=20
> *[QUESTION#2.]*
>=20
> Since my guest OS does not support Intel VT-x, can I force this with
> qemu-system-i386 arguments? I=E2=80=99m not sure how exactly to do this=
.
>=20
>=20
>=20
> Thanks,
>=20
> -Joey
>=20
