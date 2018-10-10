Received: from eggs.gnu.org ([2001:4830:134:3::10]:56440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAAge-00014H-PI
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAAgc-0007ns-QH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 05:21:48 -0400
Date: Wed, 10 Oct 2018 11:21:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181010112124.415a2011.cohuck@redhat.com>
In-Reply-To: <20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 5/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

On Tue,  9 Oct 2018 13:52:25 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97e8ed808bc0..29041da69237 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1209,6 +1209,7 @@ F: hw/s390x/ap-device.c
>  F: hw/s390x/ap-bridge.c
>  F: include/hw/s390x/ap-device.h
>  F: include/hw/s390x/ap-bridge.h
> +F: hw/vfio/ap.c
>  L: qemu-s390x@nongnu.org
>  
>  vhost

Can you please also add hw/vfio/ap.c to the overall s390 architecture
section in MAINTAINERS? The existing pattern does not catch it (but it
does catch the files added in the last patch, so that's ok.)
