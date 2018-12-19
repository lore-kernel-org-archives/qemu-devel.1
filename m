Received: from eggs.gnu.org ([2001:4830:134:3::10]:58059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZiDR-0003TB-1v
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZiDN-0003hA-4a
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:13:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZiDM-0003gg-HT
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:13:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39C8885A04
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 20:13:07 +0000 (UTC)
References: <20181219085038.7729-1-peterx@redhat.com>
	<20181219085038.7729-3-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9e56e11-214f-552a-faea-cb5901392164@redhat.com>
Date: Wed, 19 Dec 2018 21:12:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181219085038.7729-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] q35: set split kernel irqchip as
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 19/12/18 09:50, Peter Xu wrote:
> Starting from QEMU 4.0, let's specify "split" as the default value for
> kernel-irqchip.
> 
> So for QEMU>=4.0 we'll have: allowed=Y,required=N,split=Y
>    for QEMU<=3.1 we'll have: allowed=Y,required=N,split=N
>    (omitting all the "kernel_irqchip_" prefix)
> 
> Note that this "split" is optional - we'll first try to enable split
> kernel irqchip, and we'll fall back to complete kernel irqchip if we
> found that the kernel capability is missing.

Please just fail completely and require a new kernel for the 4.0 machine
type.  There are subtle differences between kernel and QEMU irqchip, I
don't think we want to open that can of worms.

Paolo
