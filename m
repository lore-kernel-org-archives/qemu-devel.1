Received: from eggs.gnu.org ([2001:4830:134:3::10]:39478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffSTO-0005lo-7C
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffSTK-0007dm-Fq
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:05:10 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ffSTK-0007dK-6G
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:05:06 -0400
Received: by mail-pg1-x543.google.com with SMTP id r5-v6so646432pgv.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:05:06 -0700 (PDT)
References: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
	<1531809130-31088-4-git-send-email-junyan.he@gmx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4823f4cf-762e-f3cc-dae2-9e323a383f52@linaro.org>
Date: Tue, 17 Jul 2018 09:05:02 -0700
MIME-Version: 1.0
In-Reply-To: <1531809130-31088-4-git-send-email-junyan.he@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7 V10] configure: add libpmem support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On 07/16/2018 11:32 PM, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
> 
> Add a pair of configure options --{enable,disable}-libpmem to control
> whether QEMU is compiled with PMDK libpmem [1].
> 
> QEMU may write to the host persistent memory (e.g. in vNVDIMM label
> emulation and live migration), so it must take the proper operations
> to ensure the persistence of its own writes. Depending on the CPU
> models and available instructions, the optimal operation can vary [2].
> PMDK libpmem have already implemented those operations on multiple CPU
> models (x86 and ARM) and the logic to select the optimal ones, so QEMU
> can just use libpmem rather than re-implement them.
> 
> Libpem is a part of PMDK project(formerly known as NMVL).
> The project's home page is: http://pmem.io/pmdk/
> And the project's repository is: https://github.com/pmem/pmdk/
> 
> For more information about libpmem APIs, you can refer to the comments
> in source code of: pmdk/src/libpmem/pmem.c, begin at line 33.
> 
> Signed-off-by: Junyan He <junyan.he@intel.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  configure | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
