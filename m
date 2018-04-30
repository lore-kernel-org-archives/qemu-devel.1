Received: from eggs.gnu.org ([2001:4830:134:3::10]:45118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD3ao-0007aJ-JS
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD3an-0005Tt-TE
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:51:26 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD3an-0005TW-NV
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:51:25 -0400
Received: by mail-oi0-x244.google.com with SMTP id c203-v6so6692198oib.7
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 00:51:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525073205-22394-1-git-send-email-thuth@redhat.com>
References: <1525073205-22394-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 08:51:04 +0100
Message-ID: <CAFEAcA9B5x0ddFyy2Le+51HrmpivvYzs9wQzgAxVjZx1g3jSsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] net: Fix memory leak in net_param_nic()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 30 April 2018 at 08:26, Thomas Huth <thuth@redhat.com> wrote:
> The early exits in case of errors leak the memory allocated for nd_id.
> Fix it by using a "goto out" to the cleanup at the end of the function
> instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
