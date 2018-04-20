Received: from eggs.gnu.org ([2001:4830:134:3::10]:43729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Yo9-0004e3-Kq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Yo8-0004eC-Vb
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:22:45 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9Yo8-0004cU-Qi
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:22:44 -0400
Received: by mail-ot0-x241.google.com with SMTP id h8-v6so10206071otj.7
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 09:22:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180420155045.18862-1-alex.bennee@linaro.org>
References: <20180420155045.18862-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 17:22:23 +0100
Message-ID: <CAFEAcA88tR+UnO8B91bfm0-WeOvJ8J7be=HGJuHVq4VkfE=qeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Convert softmmu-template into
 normal code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 20 April 2018 at 16:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>  accel/tcg/Makefile.objs      |   1 +
>  accel/tcg/cputlb.c           |  61 +----
>  accel/tcg/cputlb.h           |  20 ++
>  accel/tcg/softmmu.c          | 497 +++++++++++++++++++++++++++++++++++
>  accel/tcg/softmmu_template.h | 435 ------------------------------
>  5 files changed, 528 insertions(+), 486 deletions(-)
>  create mode 100644 accel/tcg/cputlb.h
>  create mode 100644 accel/tcg/softmmu.c
>  delete mode 100644 accel/tcg/softmmu_template.h

It's a shame there's no option to git to say "count lines inside
macro definitions as worth twice as much for the diffstat" :-)

thanks
-- PMM
