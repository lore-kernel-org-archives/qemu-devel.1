Received: from eggs.gnu.org ([2001:4830:134:3::10]:47561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr9gP-0002oz-JU
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr9gN-000287-Ui
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:50:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cr9gN-00026w-PM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:50:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2BAA61D36
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:50:07 +0000 (UTC)
Date: Thu, 23 Mar 2017 21:50:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170323205000.GB28118@noname.redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-3-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490266548-22500-3-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/5] rbd: Clean up
 qemu_rbd_create()'s detour through QemuOpts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com, eblake@redhat.com

Am 23.03.2017 um 11:55 hat Markus Armbruster geschrieben:
> The conversion from QDict to QemuOpts is pointless.  Simply get the
> stuff straight from the QDict.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
