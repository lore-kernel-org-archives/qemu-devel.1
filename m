Received: from eggs.gnu.org ([2001:4830:134:3::10]:42625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1df52b-0000Xf-O5
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1df52X-0002KP-2O
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1df52W-0002K2-Sh
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:21 -0400
Date: Tue, 8 Aug 2017 21:59:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170808135917.GB2454@lemon>
References: <20170808020249.GQ14780@lemon>
	<CAFEAcA9AgqUDCOR_9Se9A4KONXAenk36M+GK6wVx3JdQoSk1gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9AgqUDCOR_9Se9A4KONXAenk36M+GK6wVx3JdQoSk1gw@mail.gmail.com>
Subject: Re: [Qemu-devel] Howto: instructing patchew about patch dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 08/08 13:43, Peter Maydell wrote:
> On 8 August 2017 at 03:02, Fam Zheng <famz@redhat.com> wrote:
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
> 
> Does the parser accept message-ids with their angle-brackets <>
> around them, or does it insist they be stripped out?

No. Good point, I've added angle-brackets handling just now.

Fam
