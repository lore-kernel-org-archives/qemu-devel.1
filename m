Received: from eggs.gnu.org ([2001:4830:134:3::10]:47668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cybpW-0003o5-4u
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 06:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cybpR-0002tJ-IQ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 06:18:22 -0400
Received: from mail-lf0-x232.google.com ([2a00:1450:4010:c07::232]:33480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cybpR-0002tA-5m
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 06:18:17 -0400
Received: by mail-lf0-x232.google.com with SMTP id h125so27259730lfe.0
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 03:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-3-git-send-email-mst@redhat.com>
	<CAJ+F1C+kLB5VCsSakbd6+CKx4uNbxZNqd+vNMAWte4yKqcbw9Q@mail.gmail.com>
	<FFF7A2B4-A481-455B-8692-9F4486EB84BD@skyportsystems.com>
	<CAJ+F1CLyBwaCrL=HwDJLRc3BsRX1hDQKdfv44ZFsPVjf4UoFWw@mail.gmail.com>
	<9CD33C23-31A4-408C-883C-FD9160CB4A9D@skyportsystems.com>
	<CAJ+F1C+mNEFi235OKq6oVASFKZUyY0Z0SWvmbBpaiqp7QqthGA@mail.gmail.com>
	<F46E145D-006E-40EB-9871-D53E6F686D4F@skyportsystems.com>
	<CAJ+F1CK1ob6raJNQSAv-kDHKjS_g3=ohgXPsYKmYtwfiikLxtA@mail.gmail.com>
In-Reply-To: <CAJ+F1CK1ob6raJNQSAv-kDHKjS_g3=ohgXPsYKmYtwfiikLxtA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 13 Apr 2017 10:18:04 +0000
Message-ID: <CAJ+F1CLY+VW+Fx2roKMW4c7z98Z5gOPqohuN9Wa3k60mY3OTLg@mail.gmail.com>
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

On Thu, Apr 13, 2017 at 1:17 AM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Thu, Apr 13, 2017 at 1:03 AM Ben Warren <ben@skyportsystems.com> wrote=
:
>
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
>
> Not necessarily a bug, if the guid can be changed when starting a "new"
> VM, which I think should work.
>
> However, I didn't manage to get your driver noticing the acpi event. I
> tried to migrate/save & restore, and no vmgenid_notify kernel messages ca=
me
> out, nor notices got incremented. How did you test it?
>
>

Actually I was using an old bios, now I can change the guid and the guest
notices the change.

 { "execute": "qom-set", "arguments": { "path":
"/machine/peripheral-anon/device[1]", "property": "guid", "value": "..." } =
}

works, the guest noticed the change and the new value can be read. I don't
know what else would be required (except a better API) to allow QMP to
modify it.

thanks
--=20
Marc-Andr=C3=A9 Lureau
