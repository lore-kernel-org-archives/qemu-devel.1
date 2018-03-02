Received: from eggs.gnu.org ([2001:4830:134:3::10]:55300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermNL-0006X1-J2
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermNH-0003cW-JO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:13:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermNH-0003cE-DS
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:13:31 -0500
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-4-git-send-email-yi.l.liu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d038bf4-4333-f010-4280-8c5ca26b2acd@redhat.com>
Date: Fri, 2 Mar 2018 16:13:17 +0100
MIME-Version: 1.0
In-Reply-To: <1519900415-30314-4-git-send-email-yi.l.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/12] hw/core: introduce
 IOMMUSVAContext for virt-SVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On 01/03/2018 11:33, Liu, Yi L wrote:
> +void iommu_sva_notifier_unregister(IOMMUSVAContext *sva_ctx,
> +                                   IOMMUSVANotifier *notifier)
> +{
> +    IOMMUSVANotifier *cur, *next;
> +
> +    QLIST_FOREACH_SAFE(cur, &sva_ctx->sva_notifiers, node, next) {
> +        if (cur == notifier) {
> +            QLIST_REMOVE(cur, node);
> +            break;
> +        }
> +    }
> +}

It's enough to just do QLIST_REMOVE(notifier, node) here.

Paolo
