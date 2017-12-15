Received: from eggs.gnu.org ([2001:4830:134:3::10]:35340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePl88-00036R-JZ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePl84-00076m-Ok
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:14:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ePl84-00076J-JF
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:14:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C98816264D
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 08:13:59 +0000 (UTC)
Date: Fri, 15 Dec 2017 16:13:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171215081326.GC23896@lemon>
References: <151309960454.30.17116821935601659232@449822a21bf0>
	<1263b9ba-fdde-729d-db58-7ede4b0d9686@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1263b9ba-fdde-729d-db58-7ede4b0d9686@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] dump-guest-memory.py: fix "You can't do
 that without a process to debug"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, crosa@redhat.com, ehabkost@redhat.com, mst@redhat.com

On Tue, 12/12 18:30, Laszlo Ersek wrote:
> On 12/12/17 18:26, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series seems to have some coding style problems. See output below for
> > more information:
> > 
> > Message-id: 20171212172208.13588-1-marcandre.lureau@redhat.com
> > Subject: [Qemu-devel] [PATCH v2] dump-guest-memory.py: fix "You can't do that without a process to debug"
> > Type: series
> > 
> > === TEST SCRIPT BEGIN ===
> > #!/bin/bash
> > 
> > BASE=base
> > n=1
> > total=$(git log --oneline $BASE.. | wc -l)
> > failed=0
> > 
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > 
> > commits="$(git log --format=%H --reverse $BASE..)"
> > for c in $commits; do
> >     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
> >     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
> >         failed=1
> >         echo
> >     fi
> >     n=$((n+1))
> > done
> > 
> > exit $failed
> > === TEST SCRIPT END ===
> > 
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > From https://github.com/patchew-project/qemu
> >  t [tag update]            patchew/20171207203036.14993-1-eblake@redhat.com -> patchew/20171207203036.14993-1-eblake@redhat.com
> >  * [new tag]               patchew/20171212172208.13588-1-marcandre.lureau@redhat.com -> patchew/20171212172208.13588-1-marcandre.lureau@redhat.com
> > Switched to a new branch 'test'
> > 7c0544b1a7 dump-guest-memory.py: fix "You can't do that without a process to debug"
> > 
> > === OUTPUT BEGIN ===
> > Checking PATCH 1/1: dump-guest-memory.py: fix "You can't do that without a process to debug"...
> > ERROR: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
> > #46: FILE: hw/misc/vmcoreinfo.c:39:
> > +    static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;
> > 
> > total: 1 errors, 0 warnings, 24 lines checked
> > 
> > Your patch has style problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
> > 
> > === OUTPUT END ===
> > 
> > Test command exited with code: 1
> > 
> > 
> > ---
> > Email generated automatically by Patchew [http://patchew.org/].
> > Please send your feedback to patchew-devel@freelists.org
> > 
> 
> "volatile" is required in this case; otherwise GCC would be entirely
> justified to eliminate the variable.

OK, maybe we should relax it to warning instead of error for `volatile` usages,
as long as it follows a comment?

Fam
