Received: from eggs.gnu.org ([2001:4830:134:3::10]:44258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPRTk-0002Ic-Lu
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPRTj-0001XH-TL
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:42:48 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPRTj-0001Wy-MK
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:42:47 -0400
Received: by mail-wr0-x234.google.com with SMTP id k67so141894165wrc.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 03:42:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170626103756.22974-1-berrange@redhat.com>
References: <20170626103756.22974-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 11:42:25 +0100
Message-ID: <CAFEAcA80E514buuMMTTq5+OR-bRqWp0CC98RO-NHQ4v=Y67P8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] sockets: avoid formatting buffer that
 may not be NUL terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 26 June 2017 at 11:37, Daniel P. Berrange <berrange@redhat.com> wrote:
> The 'sun_path' field in the sockaddr_un struct is not required
> to be NUL termianted, so when reporting an error, we must use

"terminated", but hopefully whoever applies the patch can fix the typo?

> the separate 'path' variable which is guaranteed terminated.
>
> Fixes a bug spotted by coverity that was introduced in
>
>   commit ad9579aaa16d5b385922d49edac2c96c79bcfb62
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Thu May 25 16:53:00 2017 +0100
>
>     sockets: improve error reporting if UNIX socket path is too long
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
