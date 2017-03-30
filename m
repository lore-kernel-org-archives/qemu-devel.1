Received: from eggs.gnu.org ([2001:4830:134:3::10]:47105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctamk-0002n1-OR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctamg-00018l-KX
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ctamg-00017Y-FE
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B90E6A6D0
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 14:10:41 +0000 (UTC)
Message-ID: <1490883039.28523.25.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Mar 2017 16:10:39 +0200
In-Reply-To: <20170330122354.GF2800@work-vm>
References: <20170330122354.GF2800@work-vm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] xhci migration breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

  Hi,

> I guess maybe there's a kick needed pre/post migrate?

Sure, but it is there already (post_load arms kick_timer for active
endpoints), so it isn't *that* simple.

Looking at this I have no idea offhand, guess I have to schedule some
debugging for tomorrow.  Keep me posted in case you continue digging.

cheers,
  Gerd
