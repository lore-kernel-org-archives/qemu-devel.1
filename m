Received: from eggs.gnu.org ([2001:4830:134:3::10]:33006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzeCo-0002tD-NW
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 03:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzeCk-0007pr-QX
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 03:34:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzeCk-0007p5-K1
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 03:34:54 -0400
Date: Wed, 4 Oct 2017 09:34:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171004093448.04bb57a9.cohuck@redhat.com>
In-Reply-To: <db7c3783d4987a0b9bf683fbfcf331228cb6e5d5.1506730372.git.alistair.francis@xilinx.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<db7c3783d4987a0b9bf683fbfcf331228cb6e5d5.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/47] hw/intc: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On Fri, 29 Sep 2017 17:15:54 -0700
Alistair Francis <alistair.francis@xilinx.com> wrote:

> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.

> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index d208cb81c4..e710bfdcda 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -83,7 +83,7 @@ static void flic_enable_pfault(KVMS390FLICState *flic)
>      rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  
>      if (rc) {
> -        fprintf(stderr, "flic: couldn't enable pfault\n");
> +        error_report("flic: couldn't enable pfault");
>      }
>  }
>  
> @@ -97,7 +97,7 @@ static void flic_disable_wait_pfault(KVMS390FLICState *flic)
>      rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  
>      if (rc) {
> -        fprintf(stderr, "flic: couldn't disable pfault\n");
> +        error_report("flic: couldn't disable pfault");
>      }
>  }
>  

s390x part:

Acked-by: Cornelia Huck <cohuck@redhat.com>
