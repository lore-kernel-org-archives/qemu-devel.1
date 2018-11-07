Received: from eggs.gnu.org ([2001:4830:134:3::10]:42132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKLuF-0004A4-JQ
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 06:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKLuE-0007vb-WD
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 06:21:55 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKLuE-0007v9-K7
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 06:21:54 -0500
Received: by mail-oi1-x232.google.com with SMTP id v83-v6so13496893oia.5
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 03:21:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181107025628.GB17134@xz-x1>
References: <20181030191620.32168-1-armbru@redhat.com>
	<CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
	<87sh0eyzb0.fsf@dusky.pond.sub.org> <20181107025628.GB17134@xz-x1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Nov 2018 11:21:32 +0000
Message-ID: <CAFEAcA_FhkA_1DiDM2PWDw27dupsAdP==kBUxRrw5rGDnLzMwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 7 November 2018 at 02:56, Peter Xu <peterx@redhat.com> wrote:
> Strange, "make check -j8" failed on my hosts (I tried two) with either
> Markus's pull tree or qemu master:
>
> hw/core/ptimer.o: In function `timer_new_tl':
> /home/xz/git/qemu/include/qemu/timer.h:536: undefined reference to `timer_init_tl'
> collect2: error: ld returned 1 exit status
> make: *** [/home/xz/git/qemu/rules.mak:124: tests/ptimer-test] Error 1
>
> Is that only happening on my hosts?

Commit 89a603a0c80ae3 changed things so that there is no
timer_new_tl() or timer_init_tl() any more, so if you have
an object file that's referring to it then it's probably
stale. Try a make clean.

thanks
-- PMM
