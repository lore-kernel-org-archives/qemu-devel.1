Received: from eggs.gnu.org ([2001:4830:134:3::10]:57580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fdynX-0005Zt-Ij
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fdynR-0007TD-Lu
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:11:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1fdynR-0007Os-CR
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:11:45 -0400
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
From: konrad.wilk@oracle.com
Message-ID: <830fab17-5ddf-fdcc-266c-27d40529b859@oracle.com>
Date: Fri, 13 Jul 2018 10:11:29 -0400
MIME-Version: 1.0
In-Reply-To: <1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, konrad.wilk@oracle.com
Cc: robert.hu@intel.com

(Apologies if this comes out as HTML, using Thunderbird instead of mutt here)..

> +    uint64_t pred_cmd;
> +    uint64_t arch_capabilities;

Could this be 'arch_cap' ?

>   
>       /* End of state preserved by INIT (dummy marker).  */
>       struct {} end_init_save;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 2d174f3..3aab182 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -93,6 +93,8 @@ static bool has_msr_hv_reenlightenment;
>   static bool has_msr_xss;
>   static bool has_msr_spec_ctrl;
>   static bool has_msr_virt_ssbd;
> +static bool has_msr_pred_cmd;
> +static bool has_msr_arch_capabilities;

Ditto here?
