Received: from eggs.gnu.org ([209.51.188.92]:60539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmFTc-0006Q1-9A
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmFTb-0003Tg-Lk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:09:44 -0500
Date: Wed, 23 Jan 2019 11:09:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190123100932.GA5748@linux.fritz.box>
References: <1548233761-19890-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548233761-19890-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] block: Remove blk_attach_dev_legacy() /
 legacy_dev code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 23.01.2019 um 09:56 hat Thomas Huth geschrieben:
> The last user of blk_attach_dev_legacy() was the code in xen_disk which
> has recently been reworked. Now there is no user for this legacy function
> anymore. Thus we can finally remove all code related to the "legacy_dev"
> flag, too, and turn the related "void *" in block-backend.c into proper
> "DeviceState *" to fix some of the remaining TODOs there.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to the block branch.

Kevin
