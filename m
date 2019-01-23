Received: from eggs.gnu.org ([209.51.188.92]:48386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmGFf-0002b7-BU
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmGFc-0005DE-Uc
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:59:23 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmGFb-0005Aa-6N
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:59:20 -0500
Received: by mail-oi1-x243.google.com with SMTP id r62so1459081oie.1
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 02:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
In-Reply-To: <379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jan 2019 10:59:05 +0000
Message-ID: <CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>

On Wed, 23 Jan 2019 at 10:37, Kamil Rytarowski <n54@gmx.com> wrote:
> OSS is the portable UNIX audio backend. We could point some flaws in it,
> but it's a good enough for portable UNIX applications. The question is
> what UNIX-like desktop OS does not implement it or removed it.

If your desktop's native audio API is pulse, like Linux's often
is, then you want to use pulse directly, because the compat layers
are (or were last time I looked) not great, and typically add
in an extra thread and an extra layer of buffering, which means
more latency or more audio dropouts or both.

thanks
-- PMM
