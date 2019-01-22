Received: from eggs.gnu.org ([209.51.188.92]:59068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gm2Kr-0004gB-GW
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gm2Kq-00046a-Sm
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:07:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gm2Kq-00046C-Mt
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:07:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B504DC04BD46
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 20:07:47 +0000 (UTC)
Date: Tue, 22 Jan 2019 20:07:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190122200740.GC2241@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] of apci_1_compatible in CPUHotplugFeatures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org

Hi,
  I noticed that the acpi_1_compatible flag was misspelt as
                     apci_1_compatible

so have a trivial patch to fix that, but looking at it - are
thre any cases where a[cp]i_1_compatible can possibly be false?

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
