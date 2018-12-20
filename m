Received: from eggs.gnu.org ([2001:4830:134:3::10]:58782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZqvq-0001Lw-Bj
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZqvm-0000HD-C0
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:31:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gZqvm-0000Fd-6E
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:31:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B00DC058CBD
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 05:31:32 +0000 (UTC)
Date: Thu, 20 Dec 2018 13:31:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181220053120.GE16723@xz-x1>
References: <20181219085038.7729-1-peterx@redhat.com>
	<20181219085038.7729-3-peterx@redhat.com>
	<c9e56e11-214f-552a-faea-cb5901392164@redhat.com>
	<20181219212418.GJ19442@habkost.net>
	<2b60279a-26bc-1569-3f3c-da507fed2c44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b60279a-26bc-1569-3f3c-da507fed2c44@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On Wed, Dec 19, 2018 at 10:45:40PM +0100, Paolo Bonzini wrote:
> On 19/12/18 22:24, Eduardo Habkost wrote:
> > On Wed, Dec 19, 2018 at 09:12:55PM +0100, Paolo Bonzini wrote:
> >> On 19/12/18 09:50, Peter Xu wrote:
> >>> Starting from QEMU 4.0, let's specify "split" as the default value for
> >>> kernel-irqchip.
> >>>
> >>> So for QEMU>=4.0 we'll have: allowed=Y,required=N,split=Y
> >>>    for QEMU<=3.1 we'll have: allowed=Y,required=N,split=N
> >>>    (omitting all the "kernel_irqchip_" prefix)
> >>>
> >>> Note that this "split" is optional - we'll first try to enable split
> >>> kernel irqchip, and we'll fall back to complete kernel irqchip if we
> >>> found that the kernel capability is missing.
> >>
> >> Please just fail completely and require a new kernel for the 4.0 machine
> >> type.  There are subtle differences between kernel and QEMU irqchip, I
> >> don't think we want to open that can of worms.
> > 
> > This would make existing VMs that are runnable with pc-q35-3.1.0
> > not runnable by only updating the machine-type.
> > 
> > The good news is that we can make this a non-issue by clearly
> > documenting that QEMU needs a more recent kernel (just like we'll
> > do for RDTSCP[1]).
> 
> Right, RDTSCP is exactly what came to mind.

Ok so I think I'll just make it even simpler by dropping patch 1.
Also I noticed that the documentation on linux kernel version
requirement has not yet reached master but I'll assume it'll be there
some day very soon so I'll ignore that part.

Thanks everyone!  I'll repost soon.

-- 
Peter Xu
