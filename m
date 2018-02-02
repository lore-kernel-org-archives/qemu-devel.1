Received: from eggs.gnu.org ([2001:4830:134:3::10]:48314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ehcjb-0001MD-V2
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ehcjY-0000D1-44
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:54:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ehcjX-0000CI-Tx
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:54:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA3B467C54
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 10:05:18 +0000 (UTC)
Date: Fri, 2 Feb 2018 18:04:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180202100459.GB4666@xz-mi>
References: <20180201112028.23552-1-peterx@redhat.com>
	<90b4bc63-94cd-ec0f-32c8-c16df8ee84cf@redhat.com>
	<20180201211652-mutt-send-email-mst@kernel.org>
	<20180201194845.GN2457@work-vm>
	<33142d67-92b6-e1b1-b906-716a06efb1fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33142d67-92b6-e1b1-b906-716a06efb1fa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pcie-root-port: let it has higher migrate
 priority
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Thu, Feb 01, 2018 at 10:01:31PM +0200, Marcel Apfelbaum wrote:

[...]

> Root ports can't be nested, anyway, I suppose the migration should
> follow the bus numbering order.

Could I ask whether this is a must?  And if yes, why?

> 
> The question now is what happens if the migration is happening before
> the guest firmware finishes assigning numbers to buses...

Do you mean that vIOMMU may fetch wrong context entries too?

Note that as long as vIOMMU DMAR is off globally, vIOMMU will not
fetch context entries at all.  So IMHO this problem should not happen
during the firmware execution time (assuming that the firmware should
not enable vIOMMU at all).

Thanks,

-- 
Peter Xu
