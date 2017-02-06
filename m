Received: from eggs.gnu.org ([2001:4830:134:3::10]:52317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cae98-0006XN-AX
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 02:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cae94-0005Ud-7d
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 02:55:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cae94-0005UJ-1r
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 02:55:30 -0500
Date: Mon, 6 Feb 2017 13:25:22 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20170131122416.10284-1-ppandit@redhat.com>
Message-ID: <alpine.LFD.2.20.1702061324260.23650@wniryva>
References: <20170131122416.10284-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 0/2] sd: sdhci: correct transfer mode
 register usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>

+-- On Tue, 31 Jan 2017, P J P wrote --+
| In SDHCI emulation, the 'Block Count Enable' bit of the Transfer Mode
| register is used to control 's->blkcnt' value. One, this bit is not
| relevant in single block transfers. Second, Transfer Mode register
| value could be set such that 's->blkcnt' would not see an update
| during multi block transfers. Thus leading to an infinite loop.
| 
| This patch set attempts to correct 'Block Count Enable' bit usage.
| 
| Thank you.
| --
| Prasad J Pandit (2):
|   sd: sdhci: check transfer mode register in multi block transfer
|   sd: sdhci: block count enable not relevant in single block transfer

Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
