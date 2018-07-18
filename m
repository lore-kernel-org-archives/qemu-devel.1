Received: from eggs.gnu.org ([2001:4830:134:3::10]:44989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffoBD-0007IB-P3
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffoBA-0007qA-Kw
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:15:51 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ffoBA-0007pz-Cl
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:15:48 -0400
Received: by mail-pl0-x241.google.com with SMTP id b1-v6so2183349pls.5
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:15:48 -0700 (PDT)
References: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
	<1531900083-18167-6-git-send-email-junyan.he@gmx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4ec0c65c-8e83-b2f0-19eb-3da65c148ce3@linaro.org>
Date: Wed, 18 Jul 2018 08:15:44 -0700
MIME-Version: 1.0
In-Reply-To: <1531900083-18167-6-git-send-email-junyan.he@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7 V11] mem/nvdimm: ensure write
 persistence to PMEM in label emulation
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

On 07/18/2018 12:48 AM, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
> 
> Guest writes to vNVDIMM labels are intercepted and performed on the
> backend by QEMU. When the backend is a real persistent memort, QEMU
> needs to take proper operations to ensure its write persistence on the
> persistent memory. Otherwise, a host power failure may result in the
> loss of guest label configurations.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/mem/nvdimm.c     |  9 ++++++++-
>  include/qemu/pmem.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)
>  create mode 100644 include/qemu/pmem.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
