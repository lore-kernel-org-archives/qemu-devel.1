Received: from eggs.gnu.org ([2001:4830:134:3::10]:53071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dmGrO-0005PL-0A
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dmGrK-0006mx-3K
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:01:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1dmGrJ-0006lw-Tp
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:01:30 -0400
Date: Mon, 28 Aug 2017 15:31:14 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20170825230504.4y4uychn3sqoljoc@var.youpi.perso.aquilenet.fr>
Message-ID: <nycvar.YSQ.7.76.1708281527210.14537@wniryva>
References: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
	<20170825230504.4y4uychn3sqoljoc@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] slirp: fix clearing ifq_so from pending
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, jan.kiszka@siemens.com, thuth@redhat.com, wjjzhang@tencent.com

  Hello Samuel,

+-- On Sat, 26 Aug 2017, Samuel Thibault wrote --+
| So Wjjzhang and PJP, can you confirm that this fixes your uses?

Yes, I confirm the patch fixes the use-after-free issue.

Thank you so much.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
