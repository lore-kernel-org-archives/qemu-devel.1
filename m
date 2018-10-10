Received: from eggs.gnu.org ([2001:4830:134:3::10]:39937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gA9eS-0001bi-Qm
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gA9eN-0002Gx-UD
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:15:28 -0400
Date: Wed, 10 Oct 2018 10:14:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181010101453.4d1e4add.cohuck@redhat.com>
In-Reply-To: <20181009175226.22138-5-akrowiak@linux.vnet.ibm.com>
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-5-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 4/6] s390x/ap: base Adjunct Processor
 (AP) object model
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

On Tue,  9 Oct 2018 13:52:24 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
> new file mode 100644
> index 000000000000..fb6e35024c82
> --- /dev/null
> +++ b/hw/s390x/ap-device.c
> @@ -0,0 +1,39 @@
> +/*
> + * Adjunct Processor (AP) matrix device
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>

Do you also want this to use the vnet-less form instead?

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */

> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
> new file mode 100644
> index 000000000000..4fb3c9ab82f2
> --- /dev/null
> +++ b/include/hw/s390x/ap-device.h
> @@ -0,0 +1,23 @@
> +/*
> + * Adjunct Processor (AP) matrix device interfaces
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>

Same here.
