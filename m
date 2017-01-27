Received: from eggs.gnu.org ([2001:4830:134:3::10]:50334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9kG-0000oz-1t
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9kF-0006Y3-9t
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:51:28 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:36102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX9kF-0006Xq-58
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:51:27 -0500
Received: by mail-ua0-x230.google.com with SMTP id 96so208999827uaq.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 08:51:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485534415-20887-2-git-send-email-mst@redhat.com>
References: <1485534415-20887-1-git-send-email-mst@redhat.com>
	<1485534415-20887-2-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 16:51:06 +0000
Message-ID: <CAFEAcA9RMUyM9RXTk5cyLJPCsujABujj2CfdyOm6uQN3EbjgAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/3] arm: add trailing ;
 after MISMATCH_CHECK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 January 2017 at 16:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> Macro calls without a trailing ; look weird in C, this works as a side
> effect of how QEMU_BUILD_BUG_ON is implemented. Fix this up.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  target/arm/kvm-consts.h | 96 ++++++++++++++++++++++++-------------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
