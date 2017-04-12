Received: from eggs.gnu.org ([2001:4830:134:3::10]:46007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyPdm-0001sG-QS
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyPdk-0000QG-U3
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:17:26 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:34426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cyPdk-0000M7-Ef
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:17:24 -0400
Received: by mail-lf0-x234.google.com with SMTP id t144so20778480lff.1
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 14:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-3-git-send-email-mst@redhat.com>
	<CAJ+F1C+kLB5VCsSakbd6+CKx4uNbxZNqd+vNMAWte4yKqcbw9Q@mail.gmail.com>
	<FFF7A2B4-A481-455B-8692-9F4486EB84BD@skyportsystems.com>
	<CAJ+F1CLyBwaCrL=HwDJLRc3BsRX1hDQKdfv44ZFsPVjf4UoFWw@mail.gmail.com>
	<9CD33C23-31A4-408C-883C-FD9160CB4A9D@skyportsystems.com>
	<CAJ+F1C+mNEFi235OKq6oVASFKZUyY0Z0SWvmbBpaiqp7QqthGA@mail.gmail.com>
	<F46E145D-006E-40EB-9871-D53E6F686D4F@skyportsystems.com>
In-Reply-To: <F46E145D-006E-40EB-9871-D53E6F686D4F@skyportsystems.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Apr 2017 21:17:12 +0000
Message-ID: <CAJ+F1CK1ob6raJNQSAv-kDHKjS_g3=ohgXPsYKmYtwfiikLxtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gal Hammer <ghammer@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi

On Thu, Apr 13, 2017 at 1:03 AM Ben Warren <ben@skyportsystems.com> wrote:

> On Apr 12, 2017, at 1:47 PM, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gma=
il.com>
> wrote:
>
> Hi
>
> On Thu, Apr 13, 2017 at 12:25 AM Ben Warren <ben@skyportsystems.com>
> wrote:
>
> On Apr 12, 2017, at 1:22 PM, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gma=
il.com>
> wrote:
>
> Hi
>
> On Thu, Apr 13, 2017 at 12:17 AM Ben Warren <ben@skyportsystems.com>
> wrote:
>
> On Apr 12, 2017, at 1:06 PM, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gma=
il.com>
> wrote:
>
> +Device Usage:
> +-------------
> +
> +The device has one property, which may be only be set using the command
> line:
> +
> +  guid - sets the value of the GUID.  A special value "auto" instructs
> +         QEMU to generate a new random GUID.
> +
> +For example:
> +
> +  QEMU  -device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
> +  QEMU  -device vmgenid,guid=3Dauto
>
>
> The default will keep uuid to null, should it be documented? Wouldn't it
> make sense to default to auto?
>
> There is no default - you have to supply a value. It=E2=80=99s up to what=
ever
> software is managing VM lifecycle to decide what value to pass in.  Alway=
s
> setting to =E2=80=98auto=E2=80=99 will cause a lot of churn within Window=
s that may or may
> not be acceptable to your use case.
>
>
> Why would you have a vmgenid device if it's always null? Does that please
> some windows use-cases as well?
>
>
> I don=E2=80=99t get what you mean by this.  What device is always null?  =
Either
> the device is instantiated or it isn=E2=80=99t.  If not there, Windows wi=
ll not
> find a device and I don=E2=80=99t know how derived objects (Invocation ID=
, etc.)
> are handled.
>
>
> If you start a VM without specifying guid argument, you'll always have a
> genid null uuid, event after a migration (this could have been handled by
> qemu without requiring management layer, no?). I don't understand why aut=
o
> would create more churn than what the management layer would do by settin=
g
> new uuid for each VM started. Could you explain?
>
> Looks like there=E2=80=99s a bug.  GUID should be a mandatory parameter.
>

Not necessarily a bug, if the guid can be changed when starting a "new" VM,
which I think should work.

However, I didn't manage to get your driver noticing the acpi event. I
tried to migrate/save & restore, and no vmgenid_notify kernel messages came
out, nor notices got incremented. How did you test it?


> As for the churn, I=E2=80=99ll give you one example.  If an Active Direct=
ory
> Domain Controller (ADDC) detects a change in VM Generation ID, it takes
> this to mean that the VM has been rolled back in time, and so its
> replication sequence numbers are =E2=80=9Cdirty=E2=80=9D.  This has the e=
ffect of causing
> the Domain controller to perform a full =E2=80=9Cpull replication=E2=80=
=9D with other
> ADDCs.  In large deployments this can be costly.  VM Generation ID is use=
d
> by other applications besides AD.
>
>

I start to understand better the use case and how the device should be used=
.

thanks again

>
>
>
> +The property may be queried via QMP/HMP:
> +
> +  (QEMU) query-vm-generation-id
> +  {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
> +
> +Setting of this parameter is intentionally left out from the QMP/HMP
> +interfaces.  There are no known use cases for changing the GUID once QEM=
U
> is
> +running, and adding this capability would greatly increase the complexit=
y.
>
>
> Is this supposed to be not permitted?
>
> { "execute": "qom-set", "arguments": { "path":
> "/machine/peripheral-anon/device[1]", "property": "guid", "value": "auto"=
 }
> }
>
> Is there any linux kernel support being worked on?
>
> This isn=E2=80=99t really relevant to the Linux kernel, at least in any w=
ay I can
> think of.  What did you have in mind?
>
>
> Testing, but apparently we do have RFE for RHEL as Laszlo pointed out.
>
> OK, so you mean a guest driver.  I do have one that needs work to go
> upstream, but has been helpful to me in testing.
> https://github.com/ben-skyportsystems/vmgenid-test
>
>
> Thanks, that's exactly what I was looking for :)
>
>
> Good.  I wish I had the time to integrate this upstream, but it=E2=80=99s=
 one of
> those things that is good enough, and so will have to wait for another ti=
me.
>
> --
> Marc-Andr=C3=A9 Lureau
>
> --
Marc-Andr=C3=A9 Lureau
