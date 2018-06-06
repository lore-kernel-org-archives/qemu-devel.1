Received: from eggs.gnu.org ([2001:4830:134:3::10]:56933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fQb6o-0000mI-RB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fQb6n-0002J8-J1
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:16:26 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:35612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fQb6n-0002I4-As
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:16:25 -0400
Date: Wed, 6 Jun 2018 11:09:57 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180606090957.kivrxdpmchodoa2j@var.youpi.perso.aquilenet.fr>
References: <20180605180836.21485-1-ppandit@redhat.com>
	<20180605180836.21485-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605180836.21485-2-ppandit@redhat.com>
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
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>

Hello,

P J P, le mar. 05 juin 2018 23:38:35 +0530, a ecrit:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While reassembling incoming fragmented datagrams, 'm_cat' routine
> extends the 'mbuf' buffer, if it has insufficient room. It computes
> a wrong buffer size, which leads to overwriting adjacent heap buffer
> area. Correct this size computation in m_cat.
> 
> Reported-by: ZDI Disclosures <zdi-disclosures@trendmicro.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Applied to my tree with a couple documentation improvements, thanks!

Samuel
