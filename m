Received: from eggs.gnu.org ([2001:4830:134:3::10]:43107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7eus-0002un-0q
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7euq-0004Rr-3a
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:02:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7euo-0004QP-5F
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:02:02 -0400
References: <20180921082041.29380-1-rkagan@virtuozzo.com>
	<20180921082041.29380-5-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17d3d8f7-2e34-9ab0-a862-a2f5daccf9a0@redhat.com>
Date: Wed, 3 Oct 2018 13:01:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180921082041.29380-5-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] default-configs: collect
 CONFIG_HYPERV* in hyperv.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On 21/09/2018 10:20, Roman Kagan wrote:
> diff --git a/default-configs/hyperv.mak b/default-configs/hyperv.mak
> new file mode 100644
> index 0000000000..3d45e28403
> --- /dev/null
> +++ b/default-configs/hyperv.mak
> @@ -0,0 +1,2 @@
> +CONFIG_HYPERV=$(CONFIG_KVM)
> +CONFIG_HYPERV_TESTDEV=$(CONFIG_HYPERV)

By moving the test device to hy/hyperv, this can be just
CONFIG_HYPERV_TESTDEV=y.

Paolo
