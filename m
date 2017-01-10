Received: from eggs.gnu.org ([2001:4830:134:3::10]:57935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQxlG-0007d9-CY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQxlE-0008D9-5V
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:50:54 -0500
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:36443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cQxlD-0008CJ-UI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:50:52 -0500
Received: by mail-yb0-x243.google.com with SMTP id l23so2338176ybj.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 06:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20170110110621.15287-1-marcandre.lureau@redhat.com>
	<bf314a15-d2aa-f0bb-8a59-5589e623d650@redhat.com>
In-Reply-To: <bf314a15-d2aa-f0bb-8a59-5589e623d650@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Jan 2017 14:50:38 +0000
Message-ID: <CAJ+F1CKOZwHaOUYU0ZXg1b51A=scmpXq3+7hnrEWvfq-UHKriw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] char: fix ctrl-a b not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: 1654137@bugs.launchpad.net, gson@gson.org

On Tue, Jan 10, 2017 at 12:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:



On 10/01/2017 12:06, Marc-Andr=C3=A9 Lureau wrote:
> CharDriverState.be should be updated to point to the current
> associated backend.
>
> Fix the regression introduced in the "mux" chardev from commit
> a4afa548fc6dd9842ed86639b4d37d4d1c4ad480.
>
> https://bugs.launchpad.net/bugs/1654137

Queued.

However, can you also simplify mux_chr_accept_input, mux_chr_can_read
and mux_chr_read to use d->be directly, with this change?


Yes, not a big improvement though. I'll consider it in the reactoring
series (https://github.com/elmarco/qemu/commits/chrfe)
--=20
Marc-Andr=C3=A9 Lureau
