Received: from eggs.gnu.org ([209.51.188.92]:46666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gm8mO-0002ew-R9
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gm8mJ-0000ra-8c
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:00:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gm8mH-0000hR-5k
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:00:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 950A7C04B2F9
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 03:00:21 +0000 (UTC)
Date: Tue, 22 Jan 2019 22:00:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190122215941-mutt-send-email-mst@kernel.org>
References: <20190122200740.GC2241@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122200740.GC2241@work-vm>
Subject: Re: [Qemu-devel] of apci_1_compatible in CPUHotplugFeatures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org

On Tue, Jan 22, 2019 at 08:07:41PM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   I noticed that the acpi_1_compatible flag was misspelt as
>                      apci_1_compatible
> 
> so have a trivial patch to fix that, but looking at it - are
> thre any cases where a[cp]i_1_compatible can possibly be false?
> 
> Dave

legacy_cpu_hotplug so machine 2.6 and older - no?

> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
