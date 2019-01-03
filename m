Received: from eggs.gnu.org ([208.118.235.92]:48237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf6xb-0006uQ-AP
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf6xa-00078R-IQ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:39:11 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:35321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf6xa-00077y-E6
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:39:10 -0500
Received: by mail-ot1-x335.google.com with SMTP id 81so30002286otj.2
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 09:39:10 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 17:38:58 +0000
Message-ID: <CAFEAcA_-wNGz_ftDziARUwzL2Lc+1kkoMTo0OxV4UVwbTr8EaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] can we update QEMU's version of u-boot.e500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

Hi; currently we ship with a u-boot.e500 which is from u-boot
v2017.07. It would be nice to move that forward, specifically
to at least v2017.11, which contains upstream u-boot's part of the
fix for https://bugs.launchpad.net/qemu/+bug/1714750 .
(There are more recent releases than that; it's just the first
that contains the fix.)

Then we could remove the workaround in scripts/make-release and
close out the bug.

I've cc'd David as the current maintainer of pc-bios/u-boot.e500
and Alex as the last person who did an update.

thanks
-- PMM
