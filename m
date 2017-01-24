Received: from eggs.gnu.org ([2001:4830:134:3::10]:34335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brak@gameservers.com>) id 1cW9Ae-0007cs-Fl
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brak@gameservers.com>) id 1cW9Ab-00053K-Ck
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:02:32 -0500
Received: from mail2015.choopa.net ([208.167.225.251]:12935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brak@gameservers.com>)
	id 1cW9Ab-0004xe-9f
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:02:29 -0500
Received: from [IPv6:2001:19f0:a06:600:c198:c9e4:926e:6b6f] (unknown
	[IPv6:2001:19f0:a06:600:c198:c9e4:926e:6b6f])
	by mail2015.choopa.net (Postfix) with ESMTPSA id AFF7F5AC9148
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:02:25 -0500 (EST)
From: Brian Rak <brak@gameservers.com>
Message-ID: <b44e4a5f-cdc0-f5fd-a25e-f2d5e711d57c@gameservers.com>
Date: Tue, 24 Jan 2017 17:02:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU websockets support is laggy?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

We've been considering switching over to using qemu's built in 
websockets support (to avoid the overhead of needing websockify 
running).  We've been seeing very poor performance after the switch (it 
takes the console 4-5 seconds to update after pressing a key).  So far, 
I haven't been able to find any indication of why this is happening.  
The exact same configuration works perfectly when running with 
websockify, but laggy when hitting qemu directly.

I've tried a few things (disabling encryption, bypassing our usual nginx 
proxy, even connecting via a ssh tunnel), and haven't made any sort of 
progress here.  Has anyone else seen this?  Any suggestions as to where 
I should start looking?
