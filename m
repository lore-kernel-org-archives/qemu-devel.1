Received: from eggs.gnu.org ([2001:4830:134:3::10]:38237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHSWN-0001gS-2z
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHSWJ-0002La-7U
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:49:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gHSWJ-0002Kk-14
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:49:15 -0400
Date: Tue, 30 Oct 2018 17:19:09 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA_WduaLJZG-gu9oywCaUb2mR9DeBJ9WKqsTkKu4uGT7Uw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1810301716590.30516@xnncv>
References: <20181026073034.16648-1-ppandit@redhat.com>
	<CAFEAcA_WduaLJZG-gu9oywCaUb2mR9DeBJ9WKqsTkKu4uGT7Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] strongarm: mask off high[32:28] bits
 from dir and state registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Moguofang <moguofang@huawei.com>, liqsub1 <liqsub1@163.com>

+-- On Mon, 29 Oct 2018, Peter Maydell wrote --+
| >      switch (offset) {
| >      case GPDR:        /* GPIO Pin-Direction registers */
| > -        s->dir = value;
| > +        s->dir = value & 0x3fffff;
| 
| The commit message says it's masking [31:28], but the
| code is masking [31:22]. The SA1110 spec suggests the
| commit message is correct and the code is not.

Ouch, sorry! Sent revised patch v3.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
