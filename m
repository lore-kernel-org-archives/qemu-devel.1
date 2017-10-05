Received: from eggs.gnu.org ([2001:4830:134:3::10]:33863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e019X-000539-5S
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e019U-0007u2-1r
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e019T-0007tQ-Sc
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:05:03 -0400
Date: Thu, 5 Oct 2017 10:04:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171005100459.4189c06e.cohuck@redhat.com>
In-Reply-To: <20171004154647.7572-1-cohuck@redhat.com>
References: <20171004154647.7572-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/sclp: mark sclp-cpu-hotplug as
 non-usercreatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com

On Wed,  4 Oct 2017 17:46:47 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> A TYPE_SCLP_CPU_HOTPLUG device for handling cpu hotplug events
> is already created by the sclp event facility. Adding a second
> TYPE_SCLP_CPU_HOTPLUG device via -device sclp-cpu-hotplug creates
> an ambiguity in raise_irq_cpu_hotplug(), leading to a crash once
> a cpu is hotplugged.
> 
> To fix this, disallow creating a sclp-cpu-hotplug device manually.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/sclpcpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Queued to s390-next.
