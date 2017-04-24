Received: from eggs.gnu.org ([2001:4830:134:3::10]:43289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2g8j-0004Qx-OF
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2g8j-0003it-07
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:43:01 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2g8i-0003in-OS
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:43:00 -0400
Received: by mail-wm0-x235.google.com with SMTP id m123so71681817wma.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 08:43:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424154117.GB7705@redhat.com>
References: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
	<20170424125016.GM20809@redhat.com>
	<CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
	<20170424133624.GP20809@redhat.com>
	<CAFEAcA_LrsgToPR842redVqG7VnntTdg2ANgkDpnFAWiEqQVVw@mail.gmail.com>
	<20170424135749.GR20809@redhat.com>
	<CAFEAcA8YyeQ3NOGQkr8xVZ9S5F7RmdeDwcRkLGSyNci3hf4OCw@mail.gmail.com>
	<20170424154117.GB7705@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 16:42:38 +0100
Message-ID: <CAFEAcA8noBf9VCZ+n24NMqVKGZC9D7KKMhLoacNyEA=WJ39uAg@mail.gmail.com>
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

On 24 April 2017 at 16:41, Daniel P. Berrange <berrange@redhat.com> wrote:
> We can have the existing qcrypto_init() call a qcrypto_random_init()
> method to do the one-time initialization task, since that's already
> required to run early in order to initialize gnutls when we use it.

Yep, that would work, or initialize-on-first-call.

thanks
-- PMM
