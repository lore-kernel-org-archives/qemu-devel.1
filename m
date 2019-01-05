Received: from eggsout.gnu.org ([209.51.188.92]:34927 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1gfqfC-0004d0-GV
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 13:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1gfqf9-0005rV-CI
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 13:27:14 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:42556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zub@linux.fjfi.cvut.cz>)
	id 1gfqf9-0005qH-1T
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 13:27:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 7F928A5833
	for <qemu-devel@nongnu.org>; Sat,  5 Jan 2019 19:27:06 +0100 (CET)
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
	by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new,
	port 10022) with ESMTP id pragLOydhkCj for <qemu-devel@nongnu.org>;
	Sat,  5 Jan 2019 19:27:03 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id B3854A6AC2
	for <qemu-devel@nongnu.org>; Sat,  5 Jan 2019 19:27:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by linux.fjfi.cvut.cz (Postfix) with ESMTP id 3A7326004A
	for <qemu-devel@nongnu.org>; Sat,  5 Jan 2019 19:27:03 +0100 (CET)
Date: Sat, 5 Jan 2019 19:27:03 +0100 (CET)
From: David Kozub <zub@linux.fjfi.cvut.cz>
Message-ID: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] Emulation of TCG OPAL self-encrypting drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

Can QEMU emulate an OPAL disk? The only relevant thing I found is a post 
from 2017 about TPM that mentions OPAL:
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04586.html

specifically this bit:

> Well, at some point somebody's going to want us to implement this,
> but... they can do that when they do that.

So I assume it is not implemented. (?)

I agree with the sentiment expressed in the mail linked above w.r.t. OPAL 
security. I'm interested in this from SW development/debugging/fiddling 
perspective. A sufficient solution for me would not add any real 
encryption but would respond to the various OPAL commands send via ATA 
TRUSTED SEND/RECEIVE commands.

In fact, a more generic solution would work for me: If it was possible to 
send ATA commands from QEMU to a separate process which could then handle 
them as it liked and reply back to QEMU. This could be useful for other 
fiddling/debugging situations too.

Or, just a pass-through to a block device in the host - but a pass-through 
that would allow OPAL commands.

I'm grateful for any hints/ideas. Perhaps something like this is already 
possible with QEMU?

Best regards,
David
