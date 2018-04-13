Received: from eggs.gnu.org ([2001:4830:134:3::10]:59441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f6s5i-00084N-Vq
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f6s5f-0002co-Rs
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:21:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1f6s5f-0002cR-M7
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:21:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A26BCEB6F6
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 06:21:31 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <0c14166c-28c4-a1ad-093b-ba63e373e790@redhat.com>
Date: Fri, 13 Apr 2018 08:21:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Purpose of memory-backend-file.discard-data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Eduardo et al,

I'm looking at 11ae6ed8affdd131e and I wanted to implement libvirt
support for that. But more I look at it less I understand it. My
understanding it is an optimization (although not very effective one
since madvise() is/should be immediately followed by munmap()). So any
application that is trying to keep track of guest memory  can stop doing
so as soon as it sees munmap(). Or does the optimization lies in fact
that madvise() is called sooner and thus the app can stop caring
slightly sooner?

Also, I don't quite understand why is this configurable. What's the harm
in turning it on by default? Yesterday I've posted some patches to
libvirt list [1] (although I have to admit I am still not fully
convinced about the design) and they implement just this - whenever qemu
supports the feature libvirt turns it on.

Michal

1: https://www.redhat.com/archives/libvir-list/2018-April/msg01066.html
