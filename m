Received: from eggs.gnu.org ([209.51.188.92]:54901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyHHA-00073L-R5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyHH3-0006in-Ml
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:30:33 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyHGw-0006cE-5m
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:30:25 -0500
Received: by mail-ot1-x344.google.com with SMTP id m1so7972566otf.5
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 06:30:20 -0800 (PST)
MIME-Version: 1.0
References: <1551095970-14645-1-git-send-email-thuth@redhat.com>
	<20190225140935.GE6320@linux.fritz.box>
In-Reply-To: <20190225140935.GE6320@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 14:30:08 +0000
Message-ID: <CAFEAcA9bbZKeM=-P7mh90-QH35Kn_oR-D0yTUbteKg8JEV+Tgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block/nvme: Remove QEMU_PACKED from
 naturally aligned NVMeRegs struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Max Reitz <mreitz@redhat.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

On Mon, 25 Feb 2019 at 14:09, Kevin Wolf <kwolf@redhat.com> wrote:
> Though I'm not sure why a compiler should warn if packed and non-packed
> result in the exact same layout anyway...

Packed implies "and any time you see a pointer to this struct
it might not be aligned". Non-packed implies "you can assume
that the base of the struct is aligned".

thanks
-- PMM
