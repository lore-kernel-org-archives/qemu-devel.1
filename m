Received: from eggs.gnu.org ([2001:4830:134:3::10]:33159)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eoop5-0004HE-Jw
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eoop2-0007Wk-Fr
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:13:59 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:43412 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eoop2-0007UU-7B
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:13:56 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:13:50 +0100
From: Peter Lieven <pl@kamp.de>
Message-ID: <c0d7b993-b3b8-a753-21f5-e2257de27caf@kamp.de>
Date: Thu, 22 Feb 2018 12:13:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] block migration and MAX_IN_FLIGHT_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, wency@cn.fujitsu.com, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,


I stumbled across the MAX_INFLIGHT_IO field that was introduced in 2015 and was curious what was the reason

to choose 512MB as readahead? The question is that I found that the source VM gets very unresponsive I/O wise

while the initial 512MB are read and furthermore seems to stay unreasponsive if we choose a high migration speed

and have a fast storage on the destination VM.


In our environment I modified this value to 16MB which seems to work much smoother. I wonder if we should make

this a user configurable value or define a different rate limit for the block transfer in bulk stage at least?


Peter
