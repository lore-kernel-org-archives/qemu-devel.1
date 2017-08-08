Received: from eggs.gnu.org ([2001:4830:134:3::10]:49103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1df5FR-0004Eq-J0
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1df5FM-0001f7-FC
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:12:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1df5FM-0001ed-8b
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:12:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BA22883D2
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 14:12:35 +0000 (UTC)
Date: Tue, 8 Aug 2017 22:12:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170808141232.GC2454@lemon>
References: <20170808020249.GQ14780@lemon>
	<45317b91-2a3e-3f6e-a0df-1678ee93c97a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45317b91-2a3e-3f6e-a0df-1678ee93c97a@redhat.com>
Subject: Re: [Qemu-devel] Howto: instructing patchew about patch dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 08/08 16:00, Laszlo Ersek wrote:
> On 08/08/17 04:02, Fam Zheng wrote:
> > Hi, QEMU patch submitters,
> > 
> > I've patched patchew so that if you add a line:
> > 
> > Based-on: $MESSAGE_ID
> > 
> > in your cover letter body, or in a reply to it (or reply to reply), patchew will
> > try to apply your series on top of the one $MESSAGE_ID refers to, assuming the
> > base series _was_ successfully applied by patchew earlier.
> > 
> > In the single patch case, you can put the line under the "---" mark in the
> > commit message (no need to let it enter git history).
> > 
> > For human readability, around the "Based-on:" line it may be better if the
> > subject is noted. E.g.:
> > 
> > Based-on: 20170804140942.19342-1-famz@redhat.com
> > ([PATCH for-2.10] vmdk: Fix error handling/reporting of vmdk_check)
> > 
> > Please don't join them in one line because it will confuse the parser, after all
> > following the message id text, there aren't many spaces left.
> 
> If the basis is a multi-patch series, should Based-on refer to the msgid
> of the last patch in that series, or its blurb? (I guess "refer to
> blurb" is more logical, but asking shouldn't hurt.)

My bad for not making it clear: patchew identifies patch series by cover letter
message id, so yes, "blurb" is right.

Fam
