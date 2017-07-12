Received: from eggs.gnu.org ([2001:4830:134:3::10]:46338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVJHU-0004HE-Jv
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVJHR-0005pg-Pu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dVJHR-0005ow-In
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:10:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A05ADC04B93E
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 15:10:20 +0000 (UTC)
Date: Wed, 12 Jul 2017 18:10:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170712180550-mutt-send-email-mst@kernel.org>
References: <20170712094149.23069-1-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712094149.23069-1-jfreimann@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/3] tests/pxe-testt: add testcase
 using vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com

On Wed, Jul 12, 2017 at 11:41:46AM +0200, Jens Freimann wrote:
> This implements a testcase for pxe-test using the vhost-user interface. Spawn a
> vhost-user-bridge process and connect it to the qemu process.
> 
> It is send as an RFC because: 
>  - Patch 3/3: there must be cleaner way to do this.
>  - Does Patch 1/3 make sense or should I just redirect all output to /dev/null? 
>  - don't hardcode port numbers in qemu cmdline, create socket and pass 
>     fd to -netdev (need to figure out how to do this)

Doesn't this work?

-netdev socket,id=str[,fd=h]


> Jens Freimann (3):
>   tests/vhost-user-bridge: disable debug output by default
>   tests/pxe-test: add testcase using vhost-user-bridge
>   libvhost-user: quit when no more data received
> 
>  contrib/libvhost-user/libvhost-user.c |  12 +++-
>  contrib/libvhost-user/libvhost-user.h |   1 +
>  tests/Makefile.include                |   4 +-
>  tests/pxe-test.c                      | 106 +++++++++++++++++++++++++++++++++-
>  tests/vhost-user-bridge.c             |   2 +-
>  5 files changed, 121 insertions(+), 4 deletions(-)
> 
> -- 
> 2.9.4
