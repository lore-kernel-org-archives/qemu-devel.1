Received: from eggs.gnu.org ([2001:4830:134:3::10]:37348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTshi-0002JW-Jy
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTshd-00074O-EC
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cTshd-00074C-87
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:13 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DF0745DB7
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:03:13 +0000 (UTC)
Date: Wed, 18 Jan 2017 16:03:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170118160308.GC2085@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] kvmclock in wrong compat macro?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mtosatti@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

Hi Marcelo,
   In commit 6053a86 'kvmclock: reduce kvmclock differences on migration'
you add a 'x-mach-use-reliable-get-clock' and a compatibility entry
that turns it off; if I'm reading it right though it got merged
after 2.8.0 was released but the entry has gone into PC_COMPAT_2_7
where I guess it should have gone into PC_COMPAT_2_8.

Also, why is it x86 specific?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
