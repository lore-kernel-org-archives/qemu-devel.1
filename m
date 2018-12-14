Received: from eggs.gnu.org ([2001:4830:134:3::10]:47276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXkAm-00041k-G4
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXkAl-0004QQ-JY
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:54:20 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:43473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXkAl-0004Kg-4D
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:54:19 -0500
Received: by mail-oi1-x230.google.com with SMTP id u18so4065955oie.10
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 01:54:18 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 09:54:06 +0000
Message-ID: <CAFEAcA_=XAXoFRFUjZsDWb-8puO4b9CbB85DO+iRXiDrO9O7NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] patchew.org using expired https certificate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Connecting to https://patchew.org/ makes my browser complain:

# patchew.org uses an invalid security certificate.
# The certificate expired on 19 November 2017, 00:27:00 GMT.
# The current time is 14 December 2018, 09:52.
# Error code: SEC_ERROR_EXPIRED_CERTIFICATE

which is a bit odd, given I don't think this has been
broken since 2017. Did a cert-renewal script go wrong?

thanks
-- PMM
