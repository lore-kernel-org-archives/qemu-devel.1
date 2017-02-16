Received: from eggs.gnu.org ([2001:4830:134:3::10]:49654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceLMD-0004pb-Ec
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceLMC-0003tK-OC
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:40:21 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceLMC-0003tB-Hn
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:40:20 -0500
Received: by mail-wr0-x229.google.com with SMTP id z61so10741688wrc.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 04:40:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 12:39:58 +0000
Message-ID: <CAFEAcA-qsMk4Hbn6iNZq5cFdSWSrsWrHqP8MisMgP_yrY+Oiow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/5] A few VLAN-related bugfixes for RX
 packet abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, P J P <ppandit@redhat.com>

On 16 February 2017 at 12:29, Dmitry Fleytman <dmitry@daynix.com> wrote:
> This series fix a few issues related
> to processing of RX packets with VLAN headers.
>
> See commit messages of specific patches
> for information regarding affected devices.

I think at least the "fix buffer overrun" parts of this
patchset should be cc:stable ?

thanks
-- PMM
