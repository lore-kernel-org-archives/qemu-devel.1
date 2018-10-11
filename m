Received: from eggs.gnu.org ([2001:4830:134:3::10]:44008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAf0W-0005pQ-FE
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAf0T-0005pl-55
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:44:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAf0S-0005ni-Ue
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:44:17 -0400
Date: Thu, 11 Oct 2018 18:43:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181011174352.GC29526@work-vm>
References: <CGME20181008160317eucas1p12156552c6876786bd3087d3922d49399@eucas1p1.samsung.com>
	<20181008160536.6332-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008160536.6332-1-i.maximets@samsung.com>
Subject: Re: [Qemu-devel] [RFC 0/2] vhost+postcopy fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

* Ilya Maximets (i.maximets@samsung.com) wrote:
> Sending as RFC because it's not fully tested yet.

Since we've bothed Review-by it, I've queued it.

Dave

> Ilya Maximets (2):
>   migration: Stop postcopy fault thread before notifying
>   vhost-user: Fix userfaultfd leak
> 
>  hw/virtio/vhost-user.c   |  7 +++++++
>  migration/postcopy-ram.c | 11 ++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
