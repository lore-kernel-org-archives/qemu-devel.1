Received: from eggs.gnu.org ([2001:4830:134:3::10]:59748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyOmg-0006Mq-9N
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyOmf-0001cA-49
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:22:34 -0400
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:35629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cyOme-0001bk-OY
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:22:33 -0400
Received: by mail-lf0-x235.google.com with SMTP id 75so20106244lfs.2
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 13:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-3-git-send-email-mst@redhat.com>
	<CAJ+F1C+kLB5VCsSakbd6+CKx4uNbxZNqd+vNMAWte4yKqcbw9Q@mail.gmail.com>
	<FFF7A2B4-A481-455B-8692-9F4486EB84BD@skyportsystems.com>
In-Reply-To: <FFF7A2B4-A481-455B-8692-9F4486EB84BD@skyportsystems.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Apr 2017 20:22:20 +0000
Message-ID: <CAJ+F1CLyBwaCrL=HwDJLRc3BsRX1hDQKdfv44ZFsPVjf4UoFWw@mail.gmail.com>
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

On Thu, Apr 13, 2017 at 12:17 AM Ben Warren <ben@skyportsystems.com> wrote:

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
Why would you have a vmgenid device if it's always null? Does that please
some windows use-cases as well?


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

Testing, but apparently we do have RFE for RHEL as Laszlo pointed out.

Thanks
--=20
Marc-Andr=C3=A9 Lureau
