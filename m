Received: from eggs.gnu.org ([2001:4830:134:3::10]:57473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdWWr-0002yb-9N
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdWWn-0005fW-CG
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:23:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cdWWn-0005f1-6N
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:23:53 -0500
Date: Tue, 14 Feb 2017 11:53:46 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAKmqyKPAFKfe8e56d5D302tzHKm5mppOwCe5fUWU2vLAWuyBfw@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1702141152580.25875@wniryva>
References: <20170211150701.23391-1-ppandit@redhat.com>
	<20170211150701.23391-3-ppandit@redhat.com>
	<CAKmqyKPAFKfe8e56d5D302tzHKm5mppOwCe5fUWU2vLAWuyBfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v3 2/4] sd: sdhci: mask transfer mode
 register value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>

+-- On Mon, 13 Feb 2017, Alistair Francis wrote --+
| > -        MASKED_WRITE(s->trnmod, mask, value);
| > +        MASKED_WRITE(s->trnmod, mask, value & 0x0037);
| 
| This looks good.
| 
| Can you use a macro for the value so then it is explained and easier
| to change in the future?

  Done, sent patch v4.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
