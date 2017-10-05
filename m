Received: from eggs.gnu.org ([2001:4830:134:3::10]:37198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e05ff-0001lt-Nc
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e05fa-0001V1-Sb
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:54:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e05fa-0001UN-Lu
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:54:30 -0400
Date: Thu, 5 Oct 2017 14:54:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171005145422.0d9f2e6b.cohuck@redhat.com>
In-Reply-To: <20171004162543.12233-1-cohuck@redhat.com>
References: <20171004162543.12233-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/tcg: initialize machine check queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com

On Wed,  4 Oct 2017 18:25:43 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Just as for external interrupts and I/O interrupts, we need to
> initialize mchk_index during cpu reset.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Trying a device_add with a ccw device under tcg currently insta-crashes
> qemu. Probably nobody ever tried the crw machine check support that I
> hacked in...
> 
> Needs more work to avoid a guest kernel panic next; but let's pick the
> low-hanging fruit first.
> 
> ---
>  target/s390x/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)

Queued to s390-next.
