Received: from eggs.gnu.org ([2001:4830:134:3::10]:55348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8lgi-0002kr-8c
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8lgf-0006oB-3j
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:55:48 -0400
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
	<CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
	<860de622-d4cc-d1bf-ae27-e4d70d5d22f0@redhat.com>
	<CAJ+F1C+eHYnjZkqh=cFSm7Dw8Udbf-g+-Ck2sgVkqxFQhLxXjA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a75a9c0-8cf5-5ec1-8edc-e768f360e96f@redhat.com>
Date: Wed, 18 Apr 2018 13:55:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+eHYnjZkqh=cFSm7Dw8Udbf-g+-Ck2sgVkqxFQhLxXjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 18/04/2018 13:35, Marc-Andr=C3=A9 Lureau wrote:
>> CharBackend is not the frontend, it is *used* by the front-end.  It is
>> the qemu_chr_* functions that are named wrong (they're named according
>> to the user rather than the recipient).
> If I follow you and the naming, you have this in mind:
>=20
> - Chardev: stdio, mux, ringbuf, pty, file, null etc..
> - CharBackend: the "user" end
> - frontend: the "user"

The frontend is the device, the monitor, etc.  The backend is how the
frontend sees a Chardev, it never talks to it directly.

Perhaps the confusing part is that the backend is also how the Chardev
talks to the frontend?

Paolo

> It is quite confusing to me that CharBackend is for the "user"
> frontend, and the backend of Chardev.
>
> You have to switch your mind
> depending on the context or the point of view.
>=20
>  I'd rather use that terminology:
>=20
> - ChardevBackend: stdio, mux, ringbuf, pty, file, null etc..
> - CharFrontend: the "user" end
> - frontend the "user"
>=20
> This way, there is only one direction from backend to frontend
> (regardless of the point of view from chardev to frontend)
