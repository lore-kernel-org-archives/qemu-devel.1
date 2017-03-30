Received: from eggs.gnu.org ([2001:4830:134:3::10]:55385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1ctdfm-0007ak-4n
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1ctdfl-0001Lx-CR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:15:46 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:38334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1ctdfl-0001LU-7E
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:15:45 -0400
Received: by mail-it0-x229.google.com with SMTP id y18so80334142itc.1
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 10:15:45 -0700 (PDT)
MIME-Version: 1.0
Sender: carpeddiem@gmail.com
In-Reply-To: <3ba002c2-9a57-05fe-c93c-62f279a2381c@gmail.com>
References: <20170330232236.8272-1-emaste@freebsd.org>
	<3ba002c2-9a57-05fe-c93c-62f279a2381c@gmail.com>
From: Ed Maste <emaste@freebsd.org>
Date: Thu, 30 Mar 2017 13:14:24 -0400
Message-ID: <CAPyFy2CkbrjnyENarZ50mYFCZV-w0_T+CWEtY2-at-jA83OrVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] ipmi: use parens to avoid unexpected macro
 var evaluation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel <qemu-devel@nongnu.org>

On 30 March 2017 at 12:12, Corey Minyard <tcminyard@gmail.com> wrote:
> This isn't quite right, a lot of these need parenthesis around the whole
> thing, and some of the macros are unused and need to be removed.
> I had submitted something for this a while ago, but it hadn't been
> taken.  I will re-submit.

Ok, thanks and apologies for not noticing existing patch and discussion.

On the topic of building with recent Clang there are also a large
number of warnings of the form "taking the address of a packed member
'magic' of class or structure 'QCowHeader' may result in an unaligned
pointer value [-Waddress-of-packed-member]". Unfortunately this
warning seems to be overly aggressive and prone to false positives.
