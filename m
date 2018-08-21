Received: from eggs.gnu.org ([2001:4830:134:3::10]:41143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Oy-0004y3-Vp
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Ov-0004ws-Mh
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:48:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1Ov-0004wT-Cf
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:48:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA1DC8780F
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:48:28 +0000 (UTC)
Date: Tue, 21 Aug 2018 09:48:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821074828.vdkausyvfaq4hbtv@sirius.home.kraxel.org>
References: <1534786083-26559-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534786083-26559-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/display/ramfb: Compile the ramfb code
 only when CONFIG_FW_CFG_DMA is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Aug 20, 2018 at 07:28:03PM +0200, Thomas Huth wrote:
> According to the ramfb_setup() function, the ramfb device needs fw_cfg
> with DMA, so we should also only compile and link it into those targets
> which support it, to avoid that the device shows up on systems where it
> can not be used at all (e.g. s390x).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Added to vga queue.

thanks,
  Gerd
