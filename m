Received: from eggs.gnu.org ([2001:4830:134:3::10]:59606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYYM6-0006WN-40
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYYM2-0001Dz-5S
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:20:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cYYM1-0001Ds-Vx
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:20:14 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36C4DC04B946
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 13:20:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170106182823.1960-11-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 6 Jan 2017 18:28:18 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-11-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 31 Jan 2017 14:20:09 +0100
Message-ID: <87tw8fs6wm.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/15] postcopy: Mask fault addresses to
 huge page boundary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Currently the fault address received by userfault is rounded to
> the host page boundary and a host page is requested from the source.
> Use the current RAMBlock page size instead of the general host page
> size so that for RAMBlocks backed by huge pages we request the whole
> huge page.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
