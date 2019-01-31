Received: from eggs.gnu.org ([209.51.188.92]:59364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCmU-0001dY-Ft
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCmS-0006GB-Cj
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:26 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpCmS-0006DU-3B
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:24 -0500
Received: by mail-oi1-x241.google.com with SMTP id w13so2740940oiw.9
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 05:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20190129121817.7109-1-jusual@mail.ru>
In-Reply-To: <20190129121817.7109-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 13:53:03 +0000
Message-ID: <CAFEAcA_XuPneKXWftxjkqDn4CVTPXD1M4jSh8tM0HjnrR5tkGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] arm: Clarify the logic of set_pc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 29 Jan 2019 at 12:18, Julia Suvorova <jusual@mail.ru> wrote:
>
> Until now, the set_pc logic was unclear, which raised questions about
> whether it should be used directly, applying a value to PC or adding
> additional checks, for example, set the Thumb bit in Arm cpu. Let's set
> the set_pc logic for =E2=80=9CConfigure the PC, as was done in the ELF fi=
le=E2=80=9D
> and implement synchronize_with_tb hook for preserving PC to cpu_tb_exec.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>


Applied to target-arm.next, thanks.

-- PMM
