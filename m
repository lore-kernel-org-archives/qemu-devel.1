Received: from eggs.gnu.org ([2001:4830:134:3::10]:59879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYVA6-0001UT-9j
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYVA5-0003nn-GP
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:27:58 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYVA5-0003mi-AM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:27:57 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 12so80790962wrb.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 03:27:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 11:27:35 +0100
Message-ID: <CAFEAcA_uaB3kJcqDNR9Gg=BS1Ae0iBTs3t3S524ikKkPfx59ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/4] bsd-user: silence warnings on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>

On 18 July 2017 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
> I've just managed to get an OpenBSD VM into my test set for processing
> pull requests. There are a handful of minor compiler warnings in
> bsd-user, which this patchset fixes, just to reduce the noise
> in my logs.
>
> thanks
> -- PMM
>
> Peter Maydell (4):
>   bsd-user/mmap.c: Move __thread attribute to right place
>   bsd-user/elfload.c: Fix set-but-not-used warnings
>   bsd-user/bsdload.c: Remove write-only id_change variable
>   bsd-user/main.c: Fix unused variable warning

I've applied patches 1 and 2 to master; patch 3 still awaiting
review and 4 review/reply to my response-to-review...

thanks
-- PMM
