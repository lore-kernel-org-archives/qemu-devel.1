Received: from eggs.gnu.org ([2001:4830:134:3::10]:49243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etHnB-0003SX-V9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etHnB-0005s4-5N
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:58:30 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:32783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etHnB-0005rm-0I
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:58:29 -0500
Received: by mail-oi0-x243.google.com with SMTP id e9so488169oii.0
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 10:58:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306172250.3049-1-stefanha@redhat.com>
References: <20180306172250.3049-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 18:58:07 +0000
Message-ID: <CAFEAcA96TRY1oFJaVYSkoWgfQG2_2AYWLW5m1605GMk5Z_+PVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] trace: fix ARM TrustZone PPC hwaddr type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2018 at 17:22, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Commit 9eb8040c2d2b ("hw/misc/tz-ppc: Model TrustZone peripheral
> protection controller") added trace events with hwaddr type arguments.
>
> This is not allowed and leads to the following compiler errors when
> building with ./configure --enable-trace-backends=3Dust:
>
>   trace-ust-all.h:11847:20: error: unknown type name =E2=80=98hwaddr=E2=
=80=99; did you mean =E2=80=98h_addr=E2=80=99?
>     TP_ARGS(int, n, hwaddr, offset, bool, secure, bool, user),
>
> Generated LTTng UST tracepoint definitions cannot include declarations
> for all QEMU types and therefore docs/devel/tracing.txt requires using
> only primitive or stdint.h types.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Thanks -- Dan sent a patch for this already which I've committed
to master as commit f32408f3b472a08.

-- PMM
