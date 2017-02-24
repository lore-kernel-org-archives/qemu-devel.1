Received: from eggs.gnu.org ([2001:4830:134:3::10]:50233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1chFgk-000786-Cx
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1chFgc-0008GI-ET
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:13:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1chFgc-0008F5-3v
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:13:26 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47B4BC067C1A
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 13:13:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170206173306.20603-3-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 6 Feb 2017 17:32:52 +0000")
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-3-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 24 Feb 2017 14:13:16 +0100
Message-ID: <87y3wvk9zn.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/16] postcopy: Transmit and compare
 individual page sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> When using postcopy with hugepages, we require the source
> and destination page sizes for any RAMBlock to match; note
> that different RAMBlocks in the same VM can have different
> page sizes.
>
> Transmit them as part of the RAM information header and
> fail if there's a difference.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I would preffer to add the field unconditionally for new machine types,
but I don't have a good idea about how to do it :-(

so...
