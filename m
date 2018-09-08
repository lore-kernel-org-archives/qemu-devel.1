Received: from eggs.gnu.org ([2001:4830:134:3::10]:34724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fyfVO-0000pE-3W
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 11:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fyfGH-0002Ww-Ht
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 11:35:03 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fyfGF-0002NH-Pq
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 11:35:00 -0400
Received: by mail-oi0-x241.google.com with SMTP id l82-v6so32591952oih.11
	for <qemu-devel@nongnu.org>; Sat, 08 Sep 2018 08:34:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180908141528.71260-1-jaywang0.tw@gmail.com>
References: <20180908141528.71260-1-jaywang0.tw@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Sep 2018 16:34:36 +0100
Message-ID: <CAFEAcA-AX9V+OGMGf+JD9dnFEiSfStuSrmEGGuhFhNQjTyrJcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: fix the wrong result of
 find_allocation() in macOS.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan-Jie Wang <jaywang0.tw@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 8 September 2018 at 15:15, Yan-Jie Wang <jaywang0.tw@gmail.com> wrote:
> In macOS, lseek with SEEK_DATA behaves differently.
> It seeks to the next data region even though offset is in the middle of
> a data region. In addition, there may be many data regions without any
> hole among them, like this: |---Data---|---Data---|
>
> Because of this, qemu-img convert with raw images as input may create
> corrupted images in macOS especially for large files, and qemu-img
> map may also report wrong things. This patch fixes this undesired
> behaviors.

Hi. I have two general questions here:
(1) is this behaviour of SEEK_DATA specific to macOS, or do the
other BSDs (FreeBSD, OpenBSD, NetBSD) also have it ?
(2) is there a way to determine which flavour of SEEK_DATA we
have as a configure-time test rather than having to hardcode
an OS-specific #ifdef ?

thanks
-- PMM
