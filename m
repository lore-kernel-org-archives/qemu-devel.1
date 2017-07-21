Received: from eggs.gnu.org ([2001:4830:134:3::10]:53287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZnE-0007aJ-5P
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZnD-0008QR-Ar
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:24:40 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:37172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYZnD-0008Pz-4a
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:24:39 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 33so27239577wrz.4
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:24:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499955697-28045-1-git-send-email-peter.maydell@linaro.org>
References: <1499955697-28045-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 16:24:17 +0100
Message-ID: <CAFEAcA_KWA=c0O7t5L+V3LngEUauRJREKFm8UyTnrMMhnTyBjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Drop ancient Solaris 9 and
 earlier support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 13 July 2017 at 15:21, Peter Maydell <peter.maydell@linaro.org> wrote:
> Solaris 9 was released in 2002, its successor Solaris 10 was
> released in 2005, and Solaris 9 was end-of-lifed in 2014.
> Nobody has stepped forward to express interest in supporting
> Solaris of any flavour, so removing support for the ancient
> versions seems uncontroversial.
>
> In particular, this allows us to remove a use of 'uname'
> in configure that won't work if you're cross-compiling.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not a big thing, but it's a start on cleaning out some
> of the untested and untestable cruft from configure...
>

Applied to master, thanks.

-- PMM
