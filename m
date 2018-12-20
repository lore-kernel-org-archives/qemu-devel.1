Received: from eggs.gnu.org ([2001:4830:134:3::10]:47482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZvOC-0007BB-GY
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZvO8-0005uT-BC
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:17:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gZvO8-0005tX-5a
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:17:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20D3E8E583
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 10:17:07 +0000 (UTC)
Date: Thu, 20 Dec 2018 18:16:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181220101658.GA24875@xz-x1>
References: <20181220054037.24320-1-peterx@redhat.com>
	<be579ef2-4722-f986-cc2f-1acab8a92335@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be579ef2-4722-f986-cc2f-1acab8a92335@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Thu, Dec 20, 2018 at 11:00:21AM +0100, Paolo Bonzini wrote:
> On 20/12/18 06:40, Peter Xu wrote:
> > For old versions of QEMU: we used machine compat properties.
> > 
> > For old kernels (<4.4): if user didn't specify split kernel irqchip,
> > we'll take it only as the first priority if it's supported by the
> > kernel; otherwise, we will continue with complete kernel irqchip.
> > 
> > Both of these parameters should be good to have (split irqchip gains
> > more security, while IR gets it too but even more, like x2apic).  So
> > let's try to make them as default if capable.
> 
> This is not correct anymore, but the commit message in patch 1 is
> correct, so

Indeed; I should remove the old cover letter to avoid confusion.

> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

-- 
Peter Xu
