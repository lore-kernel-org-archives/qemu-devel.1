Received: from eggs.gnu.org ([2001:4830:134:3::10]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJR5-0001iB-To
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJJI-0005ah-4M
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:22:52 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:39828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gEJJH-0005a0-UN
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:22:48 -0400
Date: Sun, 21 Oct 2018 21:22:45 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181021192244.ep6kyqjvmt4xytyk@function>
References: <20180914072616.17771-1-famz@redhat.com>
	<20180914072616.17771-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914072616.17771-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] slirp: Add sanity check for str
 option length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Hello,

Fam Zheng, le ven. 14 sept. 2018 15:26:15 +0800, a ecrit:
> When user provides a long domainname or hostname that doesn't fit in the
> DHCP packet, we mustn't overflow the response packet buffer. Instead,
> report errors, following the g_warning() in the slirp->vdnssearch
> branch.
> 
> Also check the strlen against 256 when initializing slirp, which limit
> is also from the protocol where one byte represents the string length.
> This gives an early error before the warning which is harder to notice
> or diagnose.

Applied to my tree, thanks!

Samuel
