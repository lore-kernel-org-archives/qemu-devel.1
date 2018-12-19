Received: from eggs.gnu.org ([2001:4830:134:3::10]:35023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZifU-0001dF-Fo
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZifL-0005QD-Ez
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:42:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZifL-0005Pv-6t
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:42:03 -0500
References: <CAKXe6SK+Pm8hGh=BXQ8FosVd=s4S+oc4moxJOjOq5HNeoG5Jcw@mail.gmail.com>
	<CAKXe6SK8SXVKZ23c+QNJLEGYOkY57ovFHKNwT3byTTZai3bdaw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3b72adf-86c0-6a45-026c-838e4b7187da@redhat.com>
Date: Wed, 19 Dec 2018 21:41:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAKXe6SK8SXVKZ23c+QNJLEGYOkY57ovFHKNwT3byTTZai3bdaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question about aio_poll and glib aio_ctx_dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, stefanha@redhat.com, fam@euphon.net, Qemu Developers <qemu-devel@nongnu.org>, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>

On 19/12/18 11:05, Li Qiang wrote:
> Sent it to qemu-devel.
>=20
> Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>> =E4=BA=8E2018=E5=B9=
=B412=E6=9C=8819=E6=97=A5=E5=91=A8
> =E4=B8=89 =E4=B8=8B=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     Hello Paolo, Stefan, Fam and all,
>=20
>     Here I have a question about 'aio_poll'.
>     IIUC the 'aio_poll' is (mostly) used for=C2=A0synchronous IO
>     as I see a lot of code like this:=C2=A0
>     while(condition)
>     =C2=A0aio_poll();
>=20
>     However it seems the 'aio_poll' and 'aio_ctx_dispatch' both poll th=
e fd.
>     So what happened when the 'fd' has events, which function will be
>     wakeup?

Roughly speaking, aio_poll is used for synchronous IO and within I/O
threads; aio_ctx_dispatch is used within the main thread.

Both end up calling aio_dispatch_handlers and timerlistgroup_run_timers.

Paolo
