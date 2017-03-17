Received: from eggs.gnu.org ([2001:4830:134:3::10]:55836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1corsy-0003YB-B0
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1corsx-0004JA-EC
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:25:40 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1corsx-0004IP-72
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:25:39 -0400
Received: by mail-wm0-x235.google.com with SMTP id t189so15893836wmt.1
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 06:25:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <95e695ba-3ecc-5254-721e-b35ed08b8074@redhat.com>
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
	<20170317114953.GF8050@redhat.com>
	<CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
	<95e695ba-3ecc-5254-721e-b35ed08b8074@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 13:25:17 +0000
Message-ID: <CAFEAcA8R1bf6kRB6L=uyQAoQJBPaDxK7pG2C-9ApW9BLdR_oiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

On 17 March 2017 at 13:19, Thomas Huth <thuth@redhat.com> wrote:
> So could you maybe change your patch that it does not warn when the user
> has run configure with the "--enable-tcg-interpreter" option?

Nope. I specifically don't want to enable support for TCI on random
who-knows-what-this-is architectures. It eats up too much time
causing people to worry about "what if this is some weird thing"
when they're trying to refactor code, when in practice nobody
is really using QEMU on oddball host CPUs.

If somebody wants to support QEMU as a TCI-only setup on a
new host architecture, they can submit a patch to configure
that specifically recognizes the host architecture (even
if we don't have a tcg backend for it).

thanks
-- PMM
