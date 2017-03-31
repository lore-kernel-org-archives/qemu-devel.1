Received: from eggs.gnu.org ([2001:4830:134:3::10]:46118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctwbq-0000WO-My
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctwbp-0002aZ-PD
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:28:58 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctwbp-0002YT-IX
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:28:57 -0400
Received: by mail-wr0-x231.google.com with SMTP id l43so107958270wre.1
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 06:28:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5979a675-6077-50f8-0714-7e509a9bc492@amsat.org>
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
	<5979a675-6077-50f8-0714-7e509a9bc492@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Mar 2017 14:28:35 +0100
Message-ID: <CAFEAcA8fHU-xWeVMh76G9ODfjWpTdcr5DVBmBP4OvJXf0m1N=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/parallels.c: avoid integer overflow
 in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On 31 March 2017 at 14:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> Eduardo you seem skilled regarding Coccinelle scripts, is it possible to
> write one to find those overflows?

This is the final one that Coverity reports on the current
codebase.

> Peter having one more macro might help or confuses more?
>
> #define MULTIPLY64(a32, b32) ((int64_t)a32 * b32)

We've fixed them with casts generally in the past.

thanks
-- PMM
