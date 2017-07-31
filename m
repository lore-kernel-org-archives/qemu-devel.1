Received: from eggs.gnu.org ([2001:4830:134:3::10]:39339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcHbZ-00069z-8S
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 16:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcHbU-0002xW-Dr
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 16:47:57 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dcHbU-0002xA-7T
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 16:47:52 -0400
Received: by mail-pf0-x243.google.com with SMTP id k72so24051428pfj.0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 13:47:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.6535001d6b9cd2357109d19b1060e3f6a2b958a7.1501506432.git-series.james.hogan@imgtec.com>
	<ad80a5d3ff807996b3cdf70504cab7efd66c4295.1501506432.git-series.james.hogan@imgtec.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <93cb4cb7-842c-1a37-c2dd-a7c522076a1d@twiddle.net>
Date: Mon, 31 Jul 2017 13:47:48 -0700
MIME-Version: 1.0
In-Reply-To: <ad80a5d3ff807996b3cdf70504cab7efd66c4295.1501506432.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] mips: Add KVM T&E segment support for
 TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>

On 07/31/2017 06:09 AM, James Hogan wrote:
> +static int mips_um_ksegs;
> +
>   uint64_t cpu_mips_kseg0_to_phys(void *opaque, uint64_t addr)
>   {
>       return addr & 0x1fffffffll;
> @@ -38,3 +40,13 @@ uint64_t cpu_mips_kvm_um_phys_to_kseg0(void *opaque, uint64_t addr)
>   {
>       return addr | 0x40000000ll;
>   }
> +
> +int mips_um_ksegs_enabled(void)

bool?

Otherwise,
Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
