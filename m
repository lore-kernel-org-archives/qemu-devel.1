Received: from eggs.gnu.org ([2001:4830:134:3::10]:40190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH59H-00078G-48
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH59G-0003Ui-CP
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:51:55 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:42882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH59F-0003Td-Sq
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:51:54 -0400
Received: by mail-oi1-x235.google.com with SMTP id h23-v6so6594859oih.9
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 03:51:53 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 10:51:32 +0000
Message-ID: <CAFEAcA8R6dPxEq=-6oZiHSzgkaMWfjyKvXip6FG4h5HWj4mtwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] could somebody who understands the block refcounting
 look at CID 1395870, CID 1395871?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

Hi; could somebody who understands the block layer refcounting have
a look at Coverity issues CID 1395870 and 1395871, please? In both
cases, Coverity reports a use-after-free because it thinks that a
sequence where a code path might (conditionally) end up calling
blk_deref() twice could be freeing the memory in the first call
and using it after. I'm not sure whether these are false positives
because the refcounting has confused Coverity, or genuine issues where
we have got refcounting logic wrong, so I don't know if we need a
fix or if we should squash the coverity bug as a false-positive...

thanks
-- PMM
