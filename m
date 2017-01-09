Received: from eggs.gnu.org ([2001:4830:134:3::10]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cQOFr-0003Sj-ON
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 19:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cQOFn-0004J5-76
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 19:56:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cQOFn-0004In-1j
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 19:56:03 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A024E4E4DE
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 00:56:02 +0000 (UTC)
Date: Mon, 9 Jan 2017 08:55:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170109005557.GB9148@lemon.Home>
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<148372870194.199.4494478269203412425@790289a7ca88>
	<20170106185918.GA32535@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170106185918.GA32535@work-vm>
Subject: Re: [Qemu-devel] [PATCH 00/15] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com, quintela@redhat.com

On Fri, 01/06 18:59, Dr. David Alan Gilbert wrote:
> * no-reply@patchew.org (no-reply@patchew.org) wrote:
> > Hi,
> > Checking PATCH 14/15: postcopy: Check for userfault+hugepage feature...
> > ERROR: trailing whitespace
> > #21: FILE: migration/postcopy-ram.c:85:
> > +        bool have_hp = false; $
> 
> I noticed that one but explicitly left it; the code really reads much
> more cleanly to me with it explicitly set.

It's not complaining about the variable being initialized, but rather the ending
whitespace before EOL.

Fam
