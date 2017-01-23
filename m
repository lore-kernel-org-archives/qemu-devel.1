Received: from eggs.gnu.org ([2001:4830:134:3::10]:47092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cVXNE-0005yJ-7x
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 00:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cVXNB-0001et-6u
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 00:41:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit.shah@redhat.com>)
	id 1cVXNB-0001eV-0f
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 00:40:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3467D61B91
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 05:40:56 +0000 (UTC)
Date: Mon, 23 Jan 2017 11:10:52 +0530
From: Amit Shah <amit.shah@redhat.com>
Message-ID: <20170123054052.GA1679@amit-lp.rh>
References: <1485069471-3680-1-git-send-email-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485069471-3680-1-git-send-email-pagupta@redhat.com>
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

On (Sun) 22 Jan 2017 [12:47:51], Pankaj Gupta wrote:
> Change the name of live migration thread from 'migration' 
> to 'qemu_vm_migration' to identify it clearly. 'migration'
> is a generic word and kernel also has  tasks for process
> migration with the name 'migration/cpu#'.

Makes sense.

Reviewed-by: Amit Shah <amit.shah@redhat.com>

		Amit
