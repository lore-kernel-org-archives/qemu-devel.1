Received: from eggs.gnu.org ([2001:4830:134:3::10]:36495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dX7Jt-0005To-Au
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dX7Jo-0001Wa-Gq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:21 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:57679)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dX7Jo-0001Ts-9G
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:16 -0400
Date: Mon, 17 Jul 2017 16:48:11 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170717144811.emvnjxsuulj6e3hw@var.youpi.perso.aquilenet.fr>
References: <20170717120326.27967-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717120326.27967-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: check len against dhcp options
 array end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>, Reno Robert <renorobert@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

P J P, on lun. 17 juil. 2017 17:33:26 +0530, wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While parsing dhcp options string in 'dhcp_decode', if an options'
> length 'len' appeared towards the end of 'bp_vend' array, ensuing
> read could lead to an OOB memory access issue. Add check to avoid it.
> 
> Reported-by: Reno Robert <renorobert@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Oops, sure, applied to my tree, thanks!

Samuel
