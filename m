Received: from eggs.gnu.org ([2001:4830:134:3::10]:39506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsZQ0-0006f5-JR
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsZPv-0007vk-O2
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:03:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsZPv-0007uq-Ig
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B7CA356F0
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 19:03:14 +0000 (UTC)
Date: Thu, 14 Sep 2017 20:03:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170914190306.GC3280@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] 087 failing without aio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: qemu-devel@nongnu.org

Hi Kevin,
  087 fails if you've not built with aio, do we have
any easy tests that let us skip it?

(I was building on a cleanly installed borrowed farm box for a different
architecture and hadn't installed the full set).

=== aio=native without O_DIRECT ===

Testing:
QMP_VERSION
{"return": {}}
{"error": {"class": "GenericError", "desc": "aio=native was specified, but is not supported in this build."}}
{"return": {}}
{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
