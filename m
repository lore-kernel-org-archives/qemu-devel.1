Received: from eggs.gnu.org ([2001:4830:134:3::10]:46359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clCmc-00048B-GM
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clCmZ-0002mX-9Y
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:55:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clCmZ-0002mJ-31
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:55:55 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F9D080461
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 10:55:55 +0000 (UTC)
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
Date: Tue, 7 Mar 2017 11:55:52 +0100
MIME-Version: 1.0
In-Reply-To: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com



On 07/03/2017 09:47, Jason Wang wrote:
> We don't destroy region cache during reset which can make the maps
> of previous driver leaked to a buggy or malicious driver that don't
> set vring address before starting to use the device.

I'm still not sure as to how this can happen.  Reset does clear
desc/used/avail, which should then be checked before accessing the caches.

Paolo

> Fix this by
> destroy the region cache during reset and validate it before trying to
> use them. While at it, also validate address_space_cache_init() during
> virtio_init_region_cache() to make sure we have a correct region
> cache.
