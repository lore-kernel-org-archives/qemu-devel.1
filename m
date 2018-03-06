Received: from eggs.gnu.org ([2001:4830:134:3::10]:49804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etAcZ-0001ja-5g
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etAcV-0001Ip-UM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:19:03 -0500
Date: Tue, 6 Mar 2018 12:18:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180306111838.GD7139@localhost.localdomain>
References: <20180118103143.11780-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118103143.11780-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: implement the bdrv_reopen_prepare
 helper for LUKS driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 18.01.2018 um 11:31 hat Daniel P. Berrange geschrieben:
> If the bdrv_reopen_prepare helper isn't provided, the qemu-img commit
> command fails to re-open the base layer after committing changes into
> it. Provide a no-op implementation for the LUKS driver, since there
> is not any custom work that needs doing to re-open it.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin
