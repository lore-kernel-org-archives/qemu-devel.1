Received: from eggs.gnu.org ([2001:4830:134:3::10]:40191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2eQ9-0007ru-AM
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2eQ8-0005F8-5P
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:52:53 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2eQ7-0005El-VS
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:52:52 -0400
Received: by mail-wm0-x231.google.com with SMTP id u65so23739313wmu.1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 06:52:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424133624.GP20809@redhat.com>
References: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
	<20170424125016.GM20809@redhat.com>
	<CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
	<20170424133624.GP20809@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 14:52:30 +0100
Message-ID: <CAFEAcA_LrsgToPR842redVqG7VnntTdg2ANgkDpnFAWiEqQVVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] error: qcrypto_random_bytes() tried to read from
 /dev/[u]random, even on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: GM.Ijewski@web.de, QEMU Developers <qemu-devel@nongnu.org>

On 24 April 2017 at 14:36, Daniel P. Berrange <berrange@redhat.com> wrote:
> FYI, both gnutls and openssl use these CryptAcquireContext/CryptGenRandom
> methods, so I'd prefer to stick with that.

They probably need the full crypto API anyway, though...

> It seems we merely need to set CRYPT_SILENT in the flags to prevent any
> chance of interactive prompts.
>
> https://msdn.microsoft.com/en-us/library/windows/desktop/aa379886(v=vs.85).aspx

How about CRYPT_VERIFYCONTEXT? The docs say "in most cases this flag
should be set".

This kind of discussion puts me off the Crypt* APIs though -- they're
a complicated API that can easily be misused. "Please just fill
this buffer with randomness" is a simple API that's hard to call
wrongly...

thanks
-- PMM
