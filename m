Received: from eggs.gnu.org ([2001:4830:134:3::10]:51826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctc9R-0002YG-Qa
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctc9O-0000n4-Lv
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:38:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctc9O-0000mi-Et
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:38:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77388437F7C
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 15:38:13 +0000 (UTC)
Date: Thu, 30 Mar 2017 18:38:12 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170330183737-mutt-send-email-mst@kernel.org>
References: <1490818790-3100-1-git-send-email-vyasevic@redhat.com>
	<20170330082419.GA2585@work-vm>
	<161e7bfe-2d0a-d69f-44ac-94fb62db1b4a@redhat.com>
	<20170330145334.GI2800@work-vm>
	<d2e41d4d-482a-2c27-6982-97920aeeada5@redhat.com>
	<20170330152639.GK2800@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330152639.GK2800@work-vm>
Subject: Re: [Qemu-devel] [PATCH] virtio-net: consolidate guest announcement
 with qemu_announce_self
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vlad Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org, gveitmic@redhat.com, Jason Wang <jasowang@redhat.com>

On Thu, Mar 30, 2017 at 04:26:40PM +0100, Dr. David Alan Gilbert wrote:
> How about:
>   a) Take Germano's patch
>   b) My patch
>   c) Something close to this patch you've already posted
>   d) And we add a call to qemu_announce_self at the point we start the
>      CPUs somewhere.

It would be nice to see it all in one place, at this
point I'm not sure I understand how it all interacts.

-- 
MST
