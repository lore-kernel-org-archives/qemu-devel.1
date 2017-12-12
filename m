Received: from eggs.gnu.org ([2001:4830:134:3::10]:42101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eOcPD-0008PG-EB
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 23:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eOcPC-0006c5-Qt
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 23:42:59 -0500
Date: Tue, 12 Dec 2017 10:12:48 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA9=AzBE7CCGwHZtueyXzEGXXXSAb0ynhc-+6tzQfk5jrQ@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1712121012020.26173@wniryva>
References: <20171211105546.16466-1-ppandit@redhat.com>
	<CAFEAcA9=AzBE7CCGwHZtueyXzEGXXXSAb0ynhc-+6tzQfk5jrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] display: check irq handler index before
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Moguofang <moguofang@huawei.com>, qemu-arm <qemu-arm@nongnu.org>

+-- On Mon, 11 Dec 2017, Peter Maydell wrote --+
| It would be more sensible to just mask off the top bits of
| 'level' before starting the loop, rather than checking every
| time around the loop:
|    level &= MAKE_64BIT_MASK(0, TC6493XB_GPIOS);

Sent a revised patch v1. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
