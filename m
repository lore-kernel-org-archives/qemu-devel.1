Received: from eggs.gnu.org ([2001:4830:134:3::10]:47686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbKd5-0006FJ-UG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 00:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cbKd2-0004M3-Q8
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 00:17:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cbKd2-0004Lu-KI
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 00:17:16 -0500
Date: Wed, 8 Feb 2017 10:47:08 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAKmqyKNerMUco=iokdcWLMu14mFRvxkO81VV=JfqfHOOD_CVfQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1702081040410.17258@wniryva>
References: <20170131122416.10284-1-ppandit@redhat.com>
	<20170131122416.10284-2-ppandit@redhat.com>
	<CAKmqyKNerMUco=iokdcWLMu14mFRvxkO81VV=JfqfHOOD_CVfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/2] sd: sdhci: check transfer mode
 register in multi block transfer
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

  Hello Alistair,

+-- On Tue, 7 Feb 2017, Alistair Francis wrote --+
| As it doesn't look like we have ever supported an infinite transfer
| and we don't want infinite loops occurring I think we should add an
| unsupported print statement here saying that we don't support infinite
| transfers and then I'm ok with this patch.

  Okay, will do.
 
| > -        MASKED_WRITE(s->trnmod, mask, value);
| > +        MASKED_WRITE(s->trnmod, mask, value & 0x0037);
| 
| What is this change doing?

  It is possible to set 's->trnmod' to an invalid value(> 6 bits). Above 
mask(0x0037) would limit 'value' to the 6 bits mentioned in the spec.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
