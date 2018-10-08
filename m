Received: from eggs.gnu.org ([2001:4830:134:3::10]:37377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9PUZ-0007AB-Pi
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9PSM-00023V-6U
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:55:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g9PSL-00022Y-VB
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:55:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B4E0CD162
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 06:55:51 +0000 (UTC)
Date: Mon, 8 Oct 2018 14:55:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181008065536.GH18728@xz-x1>
References: <20181008064713.27349-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181008064713.27349-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] intel_iommu: handle invalid ce for
 shadow sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Pei Zhang <pezhang@redhat.com>

On Mon, Oct 08, 2018 at 02:47:11PM +0800, Peter Xu wrote:
> v2:
> - split patch into more, remove useless comment [Eric]
> - remove one error_report_once() when rework the code [Jason]
> 
> This series fixes a QEMU crash reported here:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1627272
> 
> Please review, thanks.

Sorry when splitting the patch I forgot to:

CC: QEMU Stable <qemu-stable@nongnu.org>

Regards,

-- 
Peter Xu
