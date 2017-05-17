Received: from eggs.gnu.org ([2001:4830:134:3::10]:45311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB4bJ-0004yx-5L
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB4bF-0005Pi-6H
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:27:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB4bE-0005PB-WC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:27:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97ACDC059721
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 19:27:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170517165810.18164-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Wed, 17 May 2017 17:58:09 +0100")
References: <20170517165810.18164-1-dgilbert@redhat.com>
	<20170517165810.18164-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 May 2017 21:27:04 +0200
Message-ID: <87fug3b7xz.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Fix non-multiple of page
 size migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, lvivier@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Unfortunately it's legal to create a VM with a RAM size that's
> not a multiple of the underlying host page or huge page size.
> Recently I'd changed things to always send host sized pages,
> and that breaks if we have say a 1025MB guest on 2MB hugepages.
>
> Unfortunately we can't just make that illegal since it would break
> migration from/to existing oddly configured VMs.
>
> Symptom: qemu-system-x86_64: Illegal RAM offset 40100000
>      as it transmits the fraction of the hugepage after the end
>      of the RAMBlock (may also cause a crash on the source
>      - possibly due to clearing bits after the bitmap)
>
> Reported-by:  Yumei Huang <yuhuang@redhat.com>
> Red Hat bug: https://bugzilla.redhat.com/show_bug.cgi?id=1449037
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


Reviewed-by: Juan Quintela <quintela@redhat.com>

We should really require for new machine types that ramblocks be
multiples of the page size.  This is just asking for trouble.
