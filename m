Received: from eggs.gnu.org ([2001:4830:134:3::10]:42665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cyPQ5-0007rB-72
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cyPQ2-0004ZR-0x
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:03:17 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:34863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cyPQ1-0004Y4-NZ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:03:13 -0400
Received: by mail-pf0-x233.google.com with SMTP id i5so19009657pfc.2
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 14:03:13 -0700 (PDT)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <F46E145D-006E-40EB-9871-D53E6F686D4F@skyportsystems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Wed, 12 Apr 2017 14:03:10 -0700
In-Reply-To: <CAJ+F1C+mNEFi235OKq6oVASFKZUyY0Z0SWvmbBpaiqp7QqthGA@mail.gmail.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-3-git-send-email-mst@redhat.com>
	<CAJ+F1C+kLB5VCsSakbd6+CKx4uNbxZNqd+vNMAWte4yKqcbw9Q@mail.gmail.com>
	<FFF7A2B4-A481-455B-8692-9F4486EB84BD@skyportsystems.com>
	<CAJ+F1CLyBwaCrL=HwDJLRc3BsRX1hDQKdfv44ZFsPVjf4UoFWw@mail.gmail.com>
	<9CD33C23-31A4-408C-883C-FD9160CB4A9D@skyportsystems.com>
	<CAJ+F1C+mNEFi235OKq6oVASFKZUyY0Z0SWvmbBpaiqp7QqthGA@mail.gmail.com>
Content-Type: text/plain;
	charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gal Hammer <ghammer@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>


> On Apr 12, 2017, at 1:47 PM, Marc-Andr=C3=A9 Lureau =
<marcandre.lureau@gmail.com> wrote:
>=20
> Hi
>=20
> On Thu, Apr 13, 2017 at 12:25 AM Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>> wrote:
>> On Apr 12, 2017, at 1:22 PM, Marc-Andr=C3=A9 Lureau =
<marcandre.lureau@gmail.com <mailto:marcandre.lureau@gmail.com>> wrote:
>>=20
>> Hi
>>=20
>> On Thu, Apr 13, 2017 at 12:17 AM Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>> wrote:
>>> On Apr 12, 2017, at 1:06 PM, Marc-Andr=C3=A9 Lureau =
<marcandre.lureau@gmail.com <mailto:marcandre.lureau@gmail.com>> wrote:
>>>=20
>>> +Device Usage:
>>> +-------------
>>> +
>>> +The device has one property, which may be only be set using the =
command line:
>>> +
>>> +  guid - sets the value of the GUID.  A special value "auto" =
instructs
>>> +         QEMU to generate a new random GUID.
>>> +
>>> +For example:
>>> +
>>> +  QEMU  -device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"=

>>> +  QEMU  -device vmgenid,guid=3Dauto
>>>=20
>>> The default will keep uuid to null, should it be documented? =
Wouldn't it make sense to default to auto?
>>=20
>> There is no default - you have to supply a value. It=E2=80=99s up to =
whatever software is managing VM lifecycle to decide what value to pass =
in.  Always setting to =E2=80=98auto=E2=80=99 will cause a lot of churn =
within Windows that may or may not be acceptable to your use case.
>>=20
>>=20
>> Why would you have a vmgenid device if it's always null? Does that =
please some windows use-cases as well?=20
>> =20
>=20
> I don=E2=80=99t get what you mean by this.  What device is always =
null?  Either the device is instantiated or it isn=E2=80=99t.  If not =
there, Windows will not find a device and I don=E2=80=99t know how =
derived objects (Invocation ID, etc.) are handled.
>=20
> If you start a VM without specifying guid argument, you'll always have =
a genid null uuid, event after a migration (this could have been handled =
by qemu without requiring management layer, no?). I don't understand why =
auto would create more churn than what the management layer would do by =
setting new uuid for each VM started. Could you explain?
>=20
Looks like there=E2=80=99s a bug.  GUID should be a mandatory parameter. =
 As for the churn, I=E2=80=99ll give you one example.  If an Active =
Directory Domain Controller (ADDC) detects a change in VM Generation ID, =
it takes this to mean that the VM has been rolled back in time, and so =
its replication sequence numbers are =E2=80=9Cdirty=E2=80=9D.  This has =
the effect of causing the Domain controller to perform a full =E2=80=9Cpul=
l replication=E2=80=9D with other ADDCs.  In large deployments this can =
be costly.  VM Generation ID is used by other applications besides AD.
>=20
>>> =20
>>> +The property may be queried via QMP/HMP:
>>> +
>>> +  (QEMU) query-vm-generation-id
>>> +  {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
>>> +
>>> +Setting of this parameter is intentionally left out from the =
QMP/HMP
>>> +interfaces.  There are no known use cases for changing the GUID =
once QEMU is
>>> +running, and adding this capability would greatly increase the =
complexity.
>>> =20
>>> Is this supposed to be not permitted?
>>>=20
>>> { "execute": "qom-set", "arguments": { "path": =
"/machine/peripheral-anon/device[1]", "property": "guid", "value": =
"auto" } }
>>>=20
>>> Is there any linux kernel support being worked on?
>>=20
>> This isn=E2=80=99t really relevant to the Linux kernel, at least in =
any way I can think of.  What did you have in mind?
>>=20
>> Testing, but apparently we do have RFE for RHEL as Laszlo pointed =
out.
>=20
> OK, so you mean a guest driver.  I do have one that needs work to go =
upstream, but has been helpful to me in testing.
> https://github.com/ben-skyportsystems/vmgenid-test =
<https://github.com/ben-skyportsystems/vmgenid-test>
>=20
> Thanks, that's exactly what I was looking for :)=20

Good.  I wish I had the time to integrate this upstream, but it=E2=80=99s =
one of those things that is good enough, and so will have to wait for =
another time.
> --=20
> Marc-Andr=C3=A9 Lureau
