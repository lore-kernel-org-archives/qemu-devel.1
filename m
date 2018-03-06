Received: from eggs.gnu.org ([2001:4830:134:3::10]:54366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etCwD-0005nn-1V
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etCwC-0001e3-5G
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:47:29 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etCwB-0001dV-W3
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:47:28 -0500
Received: by mail-oi0-x241.google.com with SMTP id g5so14837980oiy.8
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:47:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306134317.836-1-berrange@redhat.com>
References: <20180306134317.836-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 13:47:06 +0000
Message-ID: <CAFEAcA84nJvwBZhrkZdoHjLerD7_ixfXf8HqiXE9aZnvGe=+WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] misc: don't use hwaddr as a type in
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 6 March 2018 at 13:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> Use types that are defined by QEMU in trace events caused build failures
> for the UST trace backend:
>
>   In file included from trace-ust-all.c:13:0:
>   trace-ust-all.h:11844:206: error: unknown type name =E2=80=98hwaddr=E2=
=80=99
>
> It only knows about C built-in types, and any types that are pulled in
> from includs of qemu-common.h and lttng/tracepoint.h. This does not
> include the 'hwaddr' type, so replace it with a uint64_t which is what
> exec/hwaddr.h defines 'hwaddr' as. This fixes the build failure
> introduced by
>
>   commit 9eb8040c2d2b38e1a40bb6129b1b668fa178fcab
>   Author: Peter Maydell <peter.maydell@linaro.org>
>   Date:   Fri Mar 2 10:45:39 2018 +0000
>
>     hw/misc/tz-ppc: Model TrustZone peripheral protection controller
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll apply this to master, since it will fix the travis build.

thanks
-- PMM
