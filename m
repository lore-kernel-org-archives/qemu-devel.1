Received: from eggs.gnu.org ([2001:4830:134:3::10]:59727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dadpP-0004uY-JT
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dadpM-0002GI-7D
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:07:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dadpM-0002Fw-19
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:07:24 -0400
Date: Thu, 27 Jul 2017 10:07:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170727100719.564d2a72@gondolin>
In-Reply-To: <08f16288223244deeccbdc6e4d2fced5d379504d.1501084908.git.alistair.francis@xilinx.com>
References: <cover.1501084908.git.alistair.francis@xilinx.com>
	<08f16288223244deeccbdc6e4d2fced5d379504d.1501084908.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/5] Convert remaining error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com

On Wed, 26 Jul 2017 09:07:52 -0700
Alistair Francis <alistair.francis@xilinx.com> wrote:

> In a previous patch (3dc6f8693694a649a9c83f1e2746565b47683923) we
> converted uses of error_report("warning:"... to use warn_report()
> instead. This was to help standardise on a single method of printing
> warnings to the user.
> 
> There appears to have been some cases that slipped through in patch sets
> applied around the same time, this patch catches the few remaining
> cases.
> 
> All of the warnings were changed using this command:
>   find ./* -type f -exec sed -i \
>     's|error_report(".*warning[,:] |warn_report("|Ig' {} +
> 
> Indentation fixed up manually afterwards.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>

Hm, the automatic cc:ing does not seem to have worked.

> ---
> 
>  block/qcow2.c      | 10 +++++-----
>  target/s390x/kvm.c |  4 ++--
>  trace/control.c    |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 

> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index c4c5791d27..1084923adb 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -222,8 +222,8 @@ static void kvm_s390_enable_cmma(void)
>      };
>  
>      if (mem_path) {
> -        error_report("Warning: CMM will not be enabled because it is not "
> -                     "compatible to hugetlbfs.");
> +        warn_report("CMM will not be enabled because it is not "
> +                    "compatible to hugetlbfs.");
>          return;
>      }
>      rc = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);

s390x part:

Acked-by: Cornelia Huck <cohuck@redhat.com>
