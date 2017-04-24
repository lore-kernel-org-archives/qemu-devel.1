Received: from eggs.gnu.org ([2001:4830:134:3::10]:43667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2ecy-0003a2-1s
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2ecs-00022M-IM
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:06:08 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2ecs-000212-5d
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:06:02 -0400
Received: by mail-wr0-x236.google.com with SMTP id z52so50925009wrc.2
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:06:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424135749.GR20809@redhat.com>
References: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
	<20170424125016.GM20809@redhat.com>
	<CAFEAcA_p7rWmuRZ20PHBPfXoKswz95PtOjG866kaC2ooKx70PQ@mail.gmail.com>
	<20170424133624.GP20809@redhat.com>
	<CAFEAcA_LrsgToPR842redVqG7VnntTdg2ANgkDpnFAWiEqQVVw@mail.gmail.com>
	<20170424135749.GR20809@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 15:05:40 +0100
Message-ID: <CAFEAcA8YyeQ3NOGQkr8xVZ9S5F7RmdeDwcRkLGSyNci3hf4OCw@mail.gmail.com>
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

On 24 April 2017 at 14:57, Daniel P. Berrange <berrange@redhat.com> wrote:
> This is the extent of gnutls's code in this area
>
> https://gitlab.com/gnutls/gnutls/blob/master/lib/nettle/sysrng-windows.c
>
> Our API has the same usage scenario as this, hence my preference to mirror
> what gnutls & other crypto libraries are using.

I see that only calls CryptAcquireContext once, not twice.
I also think we should do what that code does and use a static
variable to avoid calling CryptAcquireContext repeatedly.

If we want to follow gnutls we should just borrow that code
(tweaking the function names etc as appropriate) and credit it:
gnutls is LGPL2.1 so no problem doing that.

thanks
-- PMM
