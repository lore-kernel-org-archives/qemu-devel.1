Received: from eggs.gnu.org ([2001:4830:134:3::10]:37760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKpr-0003rw-6W
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKpo-0000Av-2h
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:29:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cWKpn-0000Ae-TB
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:29:47 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 137083DBCA
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 10:29:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170106182823.1960-9-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Fri, 6 Jan 2017 18:28:16 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-9-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 25 Jan 2017 11:29:41 +0100
Message-ID: <87a8af77qi.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/15] postcopy: Use temporary for placing
 zero huge pages
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
> The kernel can't do UFFDIO_ZEROPAGE for huge pages, so we have
> to allocate a temporary (always zero) page and use UFFDIO_COPYPAGE
> on it.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
