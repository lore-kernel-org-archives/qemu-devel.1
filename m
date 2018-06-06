Received: from eggs.gnu.org ([2001:4830:134:3::10]:50402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQVvG-00019v-Jw
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQVvC-0005fG-Ne
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:44:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fQVvC-0005cf-J8
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:44:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64EDF40251BD
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 10:44:00 +0000 (UTC)
Date: Wed, 6 Jun 2018 18:43:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180606104357.GB3205@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] 100% host cpu with gtk3
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

Hi Gerd,

When using the gtk frontend, it seems there is a busy loop in libgtk repeatedly
calling recvmsg, causing 100% cpu on the main thread. This started to appear
after I upgraded to Fedora 28. Is this a known problem?

Any hints on how to track it down?

Fam
