Received: from eggs.gnu.org ([2001:4830:134:3::10]:59929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cS0zF-0002aQ-G5
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cS0zB-0003ss-Jp
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:29:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:2163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guangrong.xiao@linux.intel.com>)
	id 1cS0zB-0003rh-At
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:29:37 -0500
References: <20170113115651.17607-1-haozhong.zhang@intel.com>
From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Message-ID: <fc53e5d3-105b-55df-9f6d-afa3812748a5@linux.intel.com>
Date: Fri, 13 Jan 2017 20:20:13 +0800
MIME-Version: 1.0
In-Reply-To: <20170113115651.17607-1-haozhong.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386: check if nvdimm is enabled before
 plugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, imammedo@redhat.com



On 01/13/2017 07:56 PM, Haozhong Zhang wrote:
> The missing of 'nvdimm' in the machine type option '-M' means NVDIMM
> is disabled. QEMU should refuse to plug any NVDIMM device in this case
> and report the misconfiguration.

Thanks for your fix.

Reviewed-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
