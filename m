Received: from eggs.gnu.org ([2001:4830:134:3::10]:39495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8ACC-0004F6-GG
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8AC7-0007C7-Lq
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8AC7-0007Bt-FR
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:49:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30D5A61D24
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 18:49:10 +0000 (UTC)
Date: Tue, 9 May 2017 19:49:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170509184900.GI2089@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] VhostUserRequest # 20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, maxime.coquelin@redhat.com
Cc: qemu-devel@nongnu.org

Hi,
  libvhost-user.h defines:
   VHOST_USER_INPUT_GET_CONFIG = 20,
while
  vhost-user.c defines:
   VHOST_USER_NET_SET_MTU = 20,

who wins?

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
