Received: from eggs.gnu.org ([2001:4830:134:3::10]:57647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey6GF-0001ND-9d
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey6GB-00055J-3q
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:40:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey6GA-00054Z-VN
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:40:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BACD4023BB3
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 01:40:07 +0000 (UTC)
Date: Tue, 20 Mar 2018 03:40:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320033919-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] pvrdma build with clang fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.a@redhat.com>

Marcel, could you pls try a pvrdma build with clang?
It seems to fail due to enum type mismatches.
I guess this is something worth fixing.

-- 
MST
