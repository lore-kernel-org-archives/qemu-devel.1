Received: from eggs.gnu.org ([2001:4830:134:3::10]:40841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctg1A-0005xE-Ob
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctg17-0000IK-OG
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:46:00 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:35752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ctg17-0000Hy-H4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:45:57 -0400
Received: by mail-oi0-x230.google.com with SMTP id f193so41565415oib.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 12:45:57 -0700 (PDT)
Reply-To: minyard@acm.org
References: <20170330232236.8272-1-emaste@freebsd.org>
	<3ba002c2-9a57-05fe-c93c-62f279a2381c@gmail.com>
	<CAPyFy2CkbrjnyENarZ50mYFCZV-w0_T+CWEtY2-at-jA83OrVg@mail.gmail.com>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <e95443db-97c5-e2ba-8915-d23143b674f8@gmail.com>
Date: Thu, 30 Mar 2017 14:45:54 -0500
MIME-Version: 1.0
In-Reply-To: <CAPyFy2CkbrjnyENarZ50mYFCZV-w0_T+CWEtY2-at-jA83OrVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Ed Maste <emaste@freebsd.org>, minyard@acm.org
Cc: qemu-devel <qemu-devel@nongnu.org>

On 03/30/2017 12:14 PM, Ed Maste wrote:
> On 30 March 2017 at 12:12, Corey Minyard <tcminyard@gmail.com> wrote:
>> This isn't quite right, a lot of these need parenthesis around the whole
>> thing, and some of the macros are unused and need to be removed.
>> I had submitted something for this a while ago, but it hadn't been
>> taken.  I will re-submit.
> Ok, thanks and apologies for not noticing existing patch and discussion.

Not a problem, I had forgotten about this and it spurred me to action.

> On the topic of building with recent Clang there are also a large
> number of warnings of the form "taking the address of a packed member
> 'magic' of class or structure 'QCowHeader' may result in an unaligned
> pointer value [-Waddress-of-packed-member]". Unfortunately this
> warning seems to be overly aggressive and prone to false positives.

You should probably bring this up in a new thread.

-corey
