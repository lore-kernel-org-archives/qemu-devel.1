Received: from eggs.gnu.org ([2001:4830:134:3::10]:40780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fE7cB-0006dq-Uv
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fE7c7-00029Y-CQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49124 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fE7c7-00029P-75
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:11 -0400
Date: Thu, 3 May 2018 14:21:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180503062100.GG15438@lemon.usersys.redhat.com>
References: <20180430124651.10340-1-stefanha@redhat.com>
	<152509298983.2409.13656791008049355574@71c20359a636>
	<20180501130406.GD14803@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501130406.GD14803@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] checkpatch: backport UTF-8 fixes
 and MAINTAINERS check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, armbru@redhat.com, marcandre.lureau@gmail.com

On Tue, 05/01 14:04, Stefan Hajnoczi wrote:
> On Mon, Apr 30, 2018 at 05:56:30AM -0700, no-reply@patchew.org wrote:
> > === OUTPUT BEGIN ===
> > Checking PATCH 1/5: checkpatch: add a --strict check for utf-8 in commit logs...
> > WARNING: line over 80 characters
> > #101: FILE: scripts/checkpatch.pl:1420:
> > +			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
> > 
> > total: 0 errors, 1 warnings, 66 lines checked
> > 
> > Your patch has style problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
> > Checking PATCH 2/5: checkpatch: check utf-8 content from a commit log when it's missing from charset...
> > Checking PATCH 3/5: checkpatch: ignore email headers better...
> > Checking PATCH 4/5: checkpatch: emit a warning on file add/move/delete...
> > WARNING: line over 80 characters
> > #46: FILE: scripts/checkpatch.pl:1397:
> > +		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
> > 
> > ERROR: line over 90 characters
> > #49: FILE: scripts/checkpatch.pl:1400:
> > +			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > 
> > total: 1 errors, 1 warnings, 24 lines checked
> > 
> > Your patch has style problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
> > 
> > Checking PATCH 5/5: checkpatch: reduce MAINTAINERS update message frequency...
> > === OUTPUT END ===
> 
> If there are no objections I'd like to keep this in sync with upstream,
> and error messages are exempt from the 80 char limit to aid grepping.

Yeah, I actually like such exceptions for message strings constants in general.

Fam
