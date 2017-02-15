Received: from eggs.gnu.org ([2001:4830:134:3::10]:59024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdrfW-0000bv-D2
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 23:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdrfS-0005Ni-MS
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 23:58:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cdrfS-0005Ml-GR
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 23:58:14 -0500
Date: Wed, 15 Feb 2017 10:28:06 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAKmqyKPWncbASv=VD1YAzKokEHxdOVse+G41XNmv5LUwy-kfUQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1702151024310.11222@wniryva>
References: <20170214185225.7994-1-ppandit@redhat.com>
	<20170214185225.7994-3-ppandit@redhat.com>
	<CAKmqyKPWncbASv=VD1YAzKokEHxdOVse+G41XNmv5LUwy-kfUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v4 2/4] sd: sdhci: check transfer mode
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

+-- On Tue, 14 Feb 2017, Alistair Francis wrote --+
| On Tue, Feb 14, 2017 at 10:52 AM, P J P <ppandit@redhat.com> wrote:
| > From: Prasad J Pandit <pjp@fedoraproject.org>
| >
| > In the SDHCI protocol, the transfer mode register value
| > is used during multi block transfer to check if block count
| > register is enabled and should be updated. Transfer mode
| > register could be set such that, block count register would
| > not be updated, thus leading to an infinite loop. Add check
| > to avoid it.
| >
| > Reported-by: Wjjzhang <wjjzhang@tencent.com>
| > Reported-by: Jiang Xin <jiangxin1@huawei.com>
| > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| 
| Didn't I already review this?

Yes, you did. I resent it owing to thread

  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02898.html

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
