Received: from eggs.gnu.org ([2001:4830:134:3::10]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dfobI-0007zM-07
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dfobE-0003Dp-TB
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:38:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dfobE-0003CJ-ND
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:38:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E6B081E17
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 14:38:09 +0000 (UTC)
Date: Thu, 10 Aug 2017 15:38:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170810143803.GA2544@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Odd character rendering/refresh behaviour?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

I'm seeing something odd with character rendering and I can't quite put
my finger on it.

Generally I'm booting a Fedora26 guest and I'm seeing as I type
the characters appear in sections, and you see the rest of the
character appear shortly after (i.e. parts of each character,
not obviously top/bottom etc, but much more random)

I've not been able to get a consistent feel for when this happens;
but it feels like it's only started happening recently.

So far I can't with confidence say if it's in any way related to guest
type, video emulation or what.

Anyone else seeing this?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
