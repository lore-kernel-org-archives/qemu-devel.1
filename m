Received: from eggs.gnu.org ([2001:4830:134:3::10]:40792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKwt-0005H1-6w
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKws-0004fS-7h
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:13:55 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWKws-0004fK-1n
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:13:54 -0400
Received: by mail-oi0-x244.google.com with SMTP id 188-v6so5907246oid.12
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 05:13:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5db29b95-c79b-9766-81c8-360cdd0a5b94@redhat.com>
References: <20180621145749.191944-1-eblake@redhat.com>
	<CAFEAcA_6aJ705HdAD6b4m3fsGBGa6gEQXet5dkgc5aELxeknBw@mail.gmail.com>
	<CAFEAcA_0xjKVuSrUh5twc07=d-HPVoUc8JH9xunAapWCgpNreQ@mail.gmail.com>
	<5db29b95-c79b-9766-81c8-360cdd0a5b94@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:13:32 +0100
Message-ID: <CAFEAcA_DR6xftAT0wjbHaD=8FxJF0BmS7x=8SmgWtRW+m=-Fcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/9] bitmap export over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 June 2018 at 13:12, Eric Blake <eblake@redhat.com> wrote:
> Uurgh. It's a false positive (the compiler is complaining that the variable
> is uninitialized, which can only happen if the while loop is not executed;
> but the preconditions guarantee the loop executes at least once).  The
> assert() that I added was enough to silence gcc 7.3.1 on my Fedora 27
> system, but docker-mingw@fedora is using gcc-8.1.1-1.fc28.x86_64. This
> should silence things (another way to silence would be rewriting while{}
> into do{}while).  I'll submit this as a formal patch if I can reproduce the
> problem/fix on docker.

Huh. I had thought this was an old-gcc problem, not a new-gcc
one. Might be worth submitting to the gcc folks as a regression...

thanks
-- PMM
