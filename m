Received: from eggs.gnu.org ([209.51.188.92]:53069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmF9L-00078G-U0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmF9J-0006Cs-IT
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:48:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gmF9J-00068Q-7M
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:48:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so1615039wrt.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 01:48:41 -0800 (PST)
Date: Wed, 23 Jan 2019 10:48:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190123094837.cnhcyigojauwzakm@steredhat>
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, Jan 23, 2019 at 09:56:01AM +0100, Thomas Huth wrote:
> The last user of blk_attach_dev_legacy() was the code in xen_disk which
> has recently been reworked. Now there is no user for this legacy function
> anymore. Thus we can finally remove all code related to the "legacy_dev"
> flag, too, and turn the related "void *" in block-backend.c into proper
> "DeviceState *" to fix some of the remaining TODOs there.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: xen_disk.c is gone, no need to update it anymore
> 
>  block/block-backend.c          | 54 +++++++-----------------------------------
>  include/sysemu/block-backend.h |  5 ++--
>  2 files changed, 11 insertions(+), 48 deletions(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
