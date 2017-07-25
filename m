Received: from eggs.gnu.org ([2001:4830:134:3::10]:49192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1da7LU-00026f-Ln
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1da7LT-00030Y-F9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:26:24 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1da7LT-0002z4-8c
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:26:23 -0400
Received: by mail-wm0-x231.google.com with SMTP id m85so52345097wma.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 14:26:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADsqsq+0k+hZ0nsrOgPAc5H7EjYfe4TxSJ4hMUShFZ+FiKxJ_A@mail.gmail.com>
References: <CADsqsq+0k+hZ0nsrOgPAc5H7EjYfe4TxSJ4hMUShFZ+FiKxJ_A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 22:26:00 +0100
Message-ID: <CAFEAcA9wkyTqM27MLWFB8p-30C5b14H2osKRQQT9PRZXM0r4eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Regarding Tracing of machine instructions in qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shantanu Agarwal <shantanu16111994@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 July 2017 at 21:38, Shantanu Agarwal <shantanu16111994@gmail.com> wrote:
> I was wondering how to gather the machine instructions that were issued to
> a system through qemu. I tried using the simple backend tracing. But the
> results were not satisfactory. So do I have to understand the whole code of
> qemu and make changes to it. Or is there a provision to do so?

Do you want the instructions that the guest code tries to run,
or the host CPU instructions we turn them into?
In either case, these are available through the debug tracing
you can turn on with the -d option (where in_asm gives you
guest code and out_asm host code), but because these are
intended for debugging QEMU as much as anything else, they
can be confusing (in particular, they are printed when code
is *translated*, not when it is *executed*).

https://lists.nongnu.org/archive/html/qemu-discuss/2017-06/msg00004.html
has some discussion of guest instruction tracing and the
pitfalls involved here.

thanks
-- PMM
