Received: from eggs.gnu.org ([2001:4830:134:3::10]:34882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZjc-0004Uf-0I
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZjX-0002N8-Qb
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:59:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cPZjX-0002LV-L2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:59:23 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F2818050D
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 18:59:23 +0000 (UTC)
Date: Fri, 6 Jan 2017 18:59:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170106185918.GA32535@work-vm>
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<148372870194.199.4494478269203412425@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148372870194.199.4494478269203412425@790289a7ca88>
Subject: Re: [Qemu-devel] [PATCH 00/15] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, amit.shah@redhat.com, aarcange@redhat.com

* no-reply@patchew.org (no-reply@patchew.org) wrote:
> Hi,
> Checking PATCH 14/15: postcopy: Check for userfault+hugepage feature...
> ERROR: trailing whitespace
> #21: FILE: migration/postcopy-ram.c:85:
> +        bool have_hp = false; $

I noticed that one but explicitly left it; the code really reads much
more cleanly to me with it explicitly set.

Dave

> total: 1 errors, 0 warnings, 17 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 15/15: postcopy: Add doc about hugepages and postcopy...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
