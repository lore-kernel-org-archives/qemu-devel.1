Received: from eggs.gnu.org ([2001:4830:134:3::10]:33651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEeiu-0005kn-Pe
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEeis-00054P-Lt
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gEeiq-0004wT-IA
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:14:36 -0400
Date: Mon, 22 Oct 2018 23:44:13 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <4d7675ee.374e.1669bb366e4.Coremail.liqsub1@163.com>
Message-ID: <nycvar.YSQ.7.76.1810222342500.19988@xnncv>
References: <20181022120908.13285-1-ppandit@redhat.com>
	<4d7675ee.374e.1669bb366e4.Coremail.liqsub1@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/3] arm: check bit index before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liqsub1 <liqsub1@163.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Moguofang <moguofang@huawei.com>

+-- On Mon, 22 Oct 2018, liqsub1 wrote --+
| +        if (bit < sizeof(s->handler) / sizeof(s->handler[0])) { 
| 
| Maybe you can use ARRAY_SIZE here.

Yes, sent patch v1.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
