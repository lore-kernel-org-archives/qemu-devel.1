Received: from eggs.gnu.org ([2001:4830:134:3::10]:44283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVaDO-0004MF-De
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 03:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVaDL-0000cI-9L
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 03:43:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVaDL-0000c8-3M
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 03:42:59 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9630B4E4C4
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 08:42:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1485069471-3680-1-git-send-email-pagupta@redhat.com> (Pankaj
	Gupta's message of "Sun, 22 Jan 2017 12:47:51 +0530")
References: <1485069471-3680-1-git-send-email-pagupta@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Jan 2017 09:42:55 +0100
Message-ID: <8760l6cgkw.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Change name of live migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

Pankaj Gupta <pagupta@redhat.com> wrote:
> Change the name of live migration thread from 'migration' 
> to 'qemu_vm_migration' to identify it clearly. 'migration'
> is a generic word and kernel also has  tasks for process
> migration with the name 'migration/cpu#'.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Once here, I will change the name of the compression threads.

Thanks, Juan.
