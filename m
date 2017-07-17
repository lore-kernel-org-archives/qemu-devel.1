Received: from eggs.gnu.org ([2001:4830:134:3::10]:58387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dXApa-00044M-Az
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dXApX-0003nV-O9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:33:18 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:58102)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dXApX-0003mW-Gx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:33:15 -0400
Date: Mon, 17 Jul 2017 13:33:08 -0500
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170717183308.nmknfuotjkampxgr@var.youpi.perso.aquilenet.fr>
References: <20170717120326.27967-1-ppandit@redhat.com>
	<20170717144811.emvnjxsuulj6e3hw@var.youpi.perso.aquilenet.fr>
	<CAH4rwTL3H3_LJL3rmy+qkUJo6vKB+tx-ULp66CX+vhV9R7a=Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH4rwTL3H3_LJL3rmy+qkUJo6vKB+tx-ULp66CX+vhV9R7a=Fg@mail.gmail.com>
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
To: Reno Robert <renorobert@gmail.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>

Reno Robert, on lun. 17 juil. 2017 23:10:02 +0530, wrote:
> +            if (p + len > p_end) {
> 
> Shouldn't this be (p + len >= p_end) ?

No: if p_end-p is 1, len being 1 is fine.
 
Samuel
