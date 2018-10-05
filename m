Received: from eggs.gnu.org ([2001:4830:134:3::10]:54419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g8XRc-0003gu-AI
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g8XRR-0000jy-6a
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g8XQu-0000Tc-7t
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:15:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D3A3309179F
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 21:14:44 +0000 (UTC)
Date: Fri, 5 Oct 2018 18:14:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181005211442.GD5738@habkost.net>
References: <1538729067-7944-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538729067-7944-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/device-crash-test: Remove devices
 that are not user_creatable anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Oct 05, 2018 at 10:44:27AM +0200, Thomas Huth wrote:
> Devices that are derived from TYPE_SYS_BUS_DEVICE are not user_creatable
> anymore by default, and some others have been marked as non-user_creatable
> manually, so we can remove these devices from the "ignore"-list in the
> device-crash-test script.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, queued on python-next.

-- 
Eduardo
