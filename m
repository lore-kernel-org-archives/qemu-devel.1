Received: from eggs.gnu.org ([2001:4830:134:3::10]:52580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXPQt-0001yA-AB
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXPQs-0000XR-Nu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:45:35 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXPQs-0000X6-IT
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:45:34 -0500
Received: by mail-oi1-x243.google.com with SMTP id u18so1352871oie.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:45:34 -0800 (PST)
MIME-Version: 1.0
References: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 11:45:22 +0000
Message-ID: <CAFEAcA8tG-mXv63dDuJ-DFNDmxvv=AzK2rJXVFG5mnpPadGjGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 13 Dec 2018 at 11:37, Li Qiang <liq3ea@gmail.com> wrote:
>
> Also add diagnostics info in 'qemu_set_cloexec' so that we can know
> what happen when error occurs.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
> Change since v1: add diagnostics info

We need to fix the assert in the test suite first...

thanks
-- PMM
