Received: from eggs.gnu.org ([2001:4830:134:3::10]:35573)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eoBKs-0002p2-Kb
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eoBKn-0001Cj-Os
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:04:10 -0500
Received: from mx01.kamp.de ([82.141.2.16]:51527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eoBKn-0001BI-DE
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:04:05 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 18:04:00 +0100
From: Peter Lieven <pl@kamp.de>
Message-ID: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
Date: Tue, 20 Feb 2018 18:04:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

I remember we discussed a long time ago to limit the stack usage of all functions that are executed in a coroutine
context to a very low value to be able to safely limit the coroutine stack size as well.

I checked through all functions in block/, migration/ and nbd/ and there are only very few larger or unbound stack
allocations that can easily be fixed.

Now my question: Is there an easy way to add a cflag like -Wstack-usage=2048 to all objects in a given directory only?
I tried to add a llimit to the whole project, but fixing this will be a larger task.

Thanks,
Peter
