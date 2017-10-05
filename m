Received: from eggs.gnu.org ([2001:4830:134:3::10]:37097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e075o-0003Oi-J2
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e075k-0004wU-LI
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e075k-0004vl-Ei
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:25:36 -0400
Date: Thu, 5 Oct 2017 10:24:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171005142459.GE10969@stefanha-x1.localdomain>
References: <20171004154420.34596-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004154420.34596-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: fix incompatibility with old
 perl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, berrange@redhat.com

On Wed, Oct 04, 2017 at 06:44:20PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Do not use '/r' modifier which was introduced in perl 5.14.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan
