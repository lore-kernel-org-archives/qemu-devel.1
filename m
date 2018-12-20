Received: from eggs.gnu.org ([2001:4830:134:3::10]:43547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZv88-0003g0-A1
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZv83-0005t8-Cn
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:00:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZv83-0005sd-2t
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:00:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DB10804E4
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 10:00:30 +0000 (UTC)
References: <20181220054037.24320-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be579ef2-4722-f986-cc2f-1acab8a92335@redhat.com>
Date: Thu, 20 Dec 2018 11:00:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181220054037.24320-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] q35: change defaults for kernel
 irqchip and IR
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

On 20/12/18 06:40, Peter Xu wrote:
> For old versions of QEMU: we used machine compat properties.
> 
> For old kernels (<4.4): if user didn't specify split kernel irqchip,
> we'll take it only as the first priority if it's supported by the
> kernel; otherwise, we will continue with complete kernel irqchip.
> 
> Both of these parameters should be good to have (split irqchip gains
> more security, while IR gets it too but even more, like x2apic).  So
> let's try to make them as default if capable.

This is not correct anymore, but the commit message in patch 1 is
correct, so

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
