Received: from eggs.gnu.org ([2001:4830:134:3::10]:38131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKrD-0004bM-4d
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKrA-0000Vs-2P
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:31:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cWKr9-0000Vj-TI
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:31:12 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 182F17FB67
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 10:31:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170106182823.1960-10-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 6 Jan 2017 18:28:17 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-10-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 25 Jan 2017 11:31:05 +0100
Message-ID: <8760l377o6.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/15] postcopy: Load huge pages in one go
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
> The existing postcopy RAM load loop already ensures that it
> glues together whole host-pages from the target page size chunks sent
> over the wire.  Modify the definition of host page that it uses
> to be the RAM block page size and thus be huge pages where appropriate.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
