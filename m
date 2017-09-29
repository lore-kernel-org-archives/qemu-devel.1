Received: from eggs.gnu.org ([2001:4830:134:3::10]:44337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxqbp-0004nR-JR
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxqbk-00071B-2q
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxqbj-00070R-Ms
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:25:15 -0400
Date: Fri, 29 Sep 2017 10:25:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170929102507.76ade4d3.cohuck@redhat.com>
In-Reply-To: <986dcdfb-3316-85b2-5492-19e41262bbe6@de.ibm.com>
References: <20170927072030.35737-1-borntraeger@de.ibm.com>
	<20170927072030.35737-3-borntraeger@de.ibm.com>
	<986dcdfb-3316-85b2-5492-19e41262bbe6@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] s390x/ais: enable ais when
 migration is available
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <qemu-devel.nongnu.org>

On Fri, 29 Sep 2017 10:12:43 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Conny can you maybe defer this patch?
> 
> Turns out that this patch will enable the ais feature, so you can do -cpu z13,ais=on,
> but it will not enable ais for the none machine
> That means that libvirt will not enable ais for host-model or host-passthrough.
> 
> Reason seems to be that the flic interrupt controller is not created when the
> none machine is used.

Sigh :( Things are never easy...

I'll dequeue this again, thanks.
