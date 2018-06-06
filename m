Received: from eggs.gnu.org ([2001:4830:134:3::10]:33254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fQdOh-0001aN-Tk
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fQdOe-00047t-43
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:43:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1fQdOd-00046s-Tr
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:43:00 -0400
Date: Thu, 7 Jun 2018 00:12:51 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20180606090957.kivrxdpmchodoa2j@var.youpi.perso.aquilenet.fr>
Message-ID: <nycvar.YSQ.7.76.1806070008330.14945@wniryva>
References: <20180605180836.21485-1-ppandit@redhat.com>
	<20180605180836.21485-2-ppandit@redhat.com>
	<20180606090957.kivrxdpmchodoa2j@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/2] slirp: correct size computation while
 concatenating mbuf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>

  Hello Samuel,

+-- On Wed, 6 Jun 2018, Samuel Thibault wrote --+
| > From: Prasad J Pandit <pjp@fedoraproject.org>
| > 
| > While reassembling incoming fragmented datagrams, 'm_cat' routine
| > extends the 'mbuf' buffer, if it has insufficient room. It computes
| > a wrong buffer size, which leads to overwriting adjacent heap buffer
| > area. Correct this size computation in m_cat.
| > 
| > Reported-by: ZDI Disclosures <zdi-disclosures@trendmicro.com>
| > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| 
| Applied to my tree with a couple documentation improvements, thanks!

  -> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01144.html

This is patch v1 with indentation fix flagged by checkpatch.pl. In case you 
prefer this one.

Thank you.
--
 - P J P
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
