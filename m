Received: from eggs.gnu.org ([2001:4830:134:3::10]:58062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRHEi-0001RA-N0
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRHEb-0005rD-GK
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eRHEb-0005nt-7R
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:43:01 -0500
References: <20171214202220.20379-1-stefanha@redhat.com>
	<20171214202220.20379-3-stefanha@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <38786deb-5db1-69a9-e2e8-155a615ae702@redhat.com>
Date: Tue, 19 Dec 2017 13:42:51 +0100
MIME-Version: 1.0
In-Reply-To: <20171214202220.20379-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost-user: document memory accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>



On 12/14/2017 09:22 PM, Stefan Hajnoczi wrote:
> The vhost-user protocol specification does not define "guest address"
> and "user address".  It does not explain how to access memory given such
> addresses.
> 
> This patch explains how memory access works, including the IOTLB.
> 
> Cc: Michael S. Tsirkin<mst@redhat.com>
> Cc: Maxime Coquelin<maxime.coquelin@redhat.com>
> Cc: Wei Wang<wei.w.wang@intel.com>
> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> ---
>   docs/interop/vhost-user.txt | 33 ++++++++++++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 3 deletions(-)

Thanks for this spec clarification Stefan:

Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Maxime
