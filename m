Received: from eggs.gnu.org ([2001:4830:134:3::10]:34635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clFUp-0004Ij-Ds
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clFUl-0008A4-I2
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:49:47 -0500
Date: Tue, 7 Mar 2017 14:49:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170307134937.GN5871@noname.str.redhat.com>
References: <20170305214435.19656-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170305214435.19656-1-krzk@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] block: Constify data passed by pointer to
 blk_name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 05.03.2017 um 22:44 hat Krzysztof Kozlowski geschrieben:
> blk_name() is not modifying data passed to it through pointer and it
> returns also a pointer to const so the argument can be made const for
> code safeness.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, applied to block-next for qemu 2.10.

Kevin
