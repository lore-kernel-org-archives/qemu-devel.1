Received: from eggs.gnu.org ([2001:4830:134:3::10]:47639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cyPlw-0002tF-NM
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cyPlt-0001gL-B0
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:25:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cyPlt-0001fN-03
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:25:49 -0400
Date: Thu, 13 Apr 2017 00:25:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170413002507-mutt-send-email-mst@kernel.org>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-3-git-send-email-mst@redhat.com>
	<CAJ+F1C+kLB5VCsSakbd6+CKx4uNbxZNqd+vNMAWte4yKqcbw9Q@mail.gmail.com>
	<FFF7A2B4-A481-455B-8692-9F4486EB84BD@skyportsystems.com>
	<CAJ+F1CLyBwaCrL=HwDJLRc3BsRX1hDQKdfv44ZFsPVjf4UoFWw@mail.gmail.com>
	<9CD33C23-31A4-408C-883C-FD9160CB4A9D@skyportsystems.com>
	<CAJ+F1C+mNEFi235OKq6oVASFKZUyY0Z0SWvmbBpaiqp7QqthGA@mail.gmail.com>
	<F46E145D-006E-40EB-9871-D53E6F686D4F@skyportsystems.com>
	<CAJ+F1CK1ob6raJNQSAv-kDHKjS_g3=ohgXPsYKmYtwfiikLxtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK1ob6raJNQSAv-kDHKjS_g3=ohgXPsYKmYtwfiikLxtA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/15] docs: VM Generation ID device
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org, Gal Hammer <ghammer@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Apr 12, 2017 at 09:17:12PM +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Apr 13, 2017 at 1:03 AM Ben Warren <ben@skyportsystems.com> wro=
te:
>=20
>         On Apr 12, 2017, at 1:47 PM, Marc-Andr=C3=A9 Lureau <
>         marcandre.lureau@gmail.com> wrote:
>=20
>         Hi
>=20
>         On Thu, Apr 13, 2017 at 12:25 AM Ben Warren <ben@skyportsystems=
.com>
>         wrote:
>=20
>                 On Apr 12, 2017, at 1:22 PM, Marc-Andr=C3=A9 Lureau <
>                 marcandre.lureau@gmail.com> wrote:
>=20
>                 Hi
>=20
>                 On Thu, Apr 13, 2017 at 12:17 AM Ben Warren <
>                 ben@skyportsystems.com> wrote:
>=20
>                         On Apr 12, 2017, at 1:06 PM, Marc-Andr=C3=A9 Lu=
reau <
>                         marcandre.lureau@gmail.com> wrote:
>=20
>=20
>                             +Device Usage:
>                             +-------------
>                             +
>                             +The device has one property, which may be =
only be
>                             set using the command line:
>                             +
>                             +=C2=A0 guid - sets the value of the GUID.=C2=
=A0 A special
>                             value "auto" instructs
>                             +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU to =
generate a new random GUID.
>                             +
>                             +For example:
>                             +
>                             +=C2=A0 QEMU=C2=A0 -device vmgenid,guid=3D
>                             "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>                             +=C2=A0 QEMU=C2=A0 -device vmgenid,guid=3Da=
uto
>=20
>=20
>                         The default will keep uuid to null, should it b=
e
>                         documented? Wouldn't it make sense to default t=
o auto?
>=20
>                     There is no default - you have to supply a value. I=
t=E2=80=99s up
>                     to whatever software is managing VM lifecycle to de=
cide
>                     what value to pass in.=C2=A0 Always setting to =E2=80=
=98auto=E2=80=99 will cause
>                     a lot of churn within Windows that may or may not b=
e
>                     acceptable to your use case.
>=20
>=20
>=20
>                 Why would you have a vmgenid device if it's always null=
? Does
>                 that please some windows use-cases as well?=C2=A0
>                 =C2=A0
>=20
>             I don=E2=80=99t get what you mean by this.=C2=A0 What devic=
e is always null?=C2=A0
>             Either the device is instantiated or it isn=E2=80=99t.=C2=A0=
 If not there,
>             Windows will not find a device and I don=E2=80=99t know how=
 derived objects
>             (Invocation ID, etc.) are handled.
>=20
>=20
>         If you start a VM without specifying guid argument, you'll alwa=
ys have
>         a genid null uuid, event after a migration (this could have bee=
n
>         handled by qemu without requiring management layer, no?). I don=
't
>         understand why auto would create more churn than what the manag=
ement
>         layer would do by setting new uuid for each VM started. Could y=
ou
>         explain?
>=20
>=20
>     Looks like there=E2=80=99s a bug.=C2=A0 GUID should be a mandatory =
parameter.=C2=A0
>=20
>=20
> Not necessarily a bug, if the guid can be changed when starting a "new"=
 VM,
> which I think should work.

I think spec does not allow for a special "invalid" guid value ATM.


> However, I didn't manage to get your driver noticing the acpi event. I =
tried to
> migrate/save & restore, and no vmgenid_notify kernel messages came out,=
 nor
> notices got incremented. How did you test it?
> =C2=A0
>=20
>     As for the churn, I=E2=80=99ll give you one example.=C2=A0 If an Ac=
tive Directory Domain
>     Controller (ADDC) detects a change in VM Generation ID, it takes th=
is to
>     mean that the VM has been rolled back in time, and so its replicati=
on
>     sequence numbers are =E2=80=9Cdirty=E2=80=9D.=C2=A0 This has the ef=
fect of causing the Domain
>     controller to perform a full =E2=80=9Cpull replication=E2=80=9D wit=
h other ADDCs.=C2=A0 In large
>     deployments this can be costly.=C2=A0 VM Generation ID is used by o=
ther
>     applications besides AD.
>=20
>=20
>=20
>=20
> I start to understand better the use case and how the device should be =
used.
> =C2=A0
> thanks again
>=20
>=20
>=20
>                         =C2=A0
>=20
>                             +The property may be queried via QMP/HMP:
>                             +
>                             +=C2=A0 (QEMU) query-vm-generation-id
>                             +=C2=A0 {"return": {"guid":
>                             "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
>                             +
>                             +Setting of this parameter is intentionally=
 left
>                             out from the QMP/HMP
>                             +interfaces.=C2=A0 There are no known use c=
ases for
>                             changing the GUID once QEMU is
>                             +running, and adding this capability would =
greatly
>                             increase the complexity.
>=20
>                         =C2=A0
>                         Is this supposed to be not permitted?
>=20
>                         { "execute": "qom-set", "arguments": { "path": =
"/
>                         machine/peripheral-anon/device[1]", "property":=
 "guid",
>                         "value": "auto" } }
>=20
>                         Is there any linux kernel support being worked =
on?
>=20
>                     This isn=E2=80=99t really relevant to the Linux ker=
nel, at least in
>                     any way I can think of.=C2=A0 What did you have in =
mind?
>=20
>=20
>                 Testing, but apparently we do have RFE for RHEL as Lasz=
lo
>                 pointed out.
>=20
>             OK, so you mean a guest driver.=C2=A0 I do have one that ne=
eds work to
>             go upstream, but has been helpful to me in testing.
>             https://github.com/ben-skyportsystems/vmgenid-test
>=20
>=20
>         Thanks, that's exactly what I was looking for :)=C2=A0
>=20
>=20
>     Good.=C2=A0 I wish I had the time to integrate this upstream, but i=
t=E2=80=99s one of
>     those things that is good enough, and so will have to wait for anot=
her
>     time.
>=20
>=20
>         --=C2=A0
>         Marc-Andr=C3=A9 Lureau
>=20
> --
> Marc-Andr=C3=A9 Lureau
