Received: from eggs.gnu.org ([2001:4830:134:3::10]:57646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gZYkJ-0002bd-Ic
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gZYkH-0003AI-Mk
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:06:31 -0500
Received: from mail-it1-x136.google.com ([2607:f8b0:4864:20::136]:56190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gZYkH-00039s-F8
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:06:29 -0500
Received: by mail-it1-x136.google.com with SMTP id m62so8786804ith.5
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 02:06:29 -0800 (PST)
MIME-Version: 1.0
References: <CAKXe6SK+Pm8hGh=BXQ8FosVd=s4S+oc4moxJOjOq5HNeoG5Jcw@mail.gmail.com>
In-Reply-To: <CAKXe6SK+Pm8hGh=BXQ8FosVd=s4S+oc4moxJOjOq5HNeoG5Jcw@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 19 Dec 2018 18:05:52 +0800
Message-ID: <CAKXe6SK8SXVKZ23c+QNJLEGYOkY57ovFHKNwT3byTTZai3bdaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, fam@euphon.net, Qemu Developers <qemu-devel@nongnu.org>, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>

Sent it to qemu-devel.

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=8819=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A

> Hello Paolo, Stefan, Fam and all,
>
> Here I have a question about 'aio_poll'.
> IIUC the 'aio_poll' is (mostly) used for synchronous IO
> as I see a lot of code like this:
> while(condition)
>  aio_poll();
>
> However it seems the 'aio_poll' and 'aio_ctx_dispatch' both poll the fd.
> So what happened when the 'fd' has events, which function will be wakeup?
>
> Thanks,
> Li Qiang
>
>
