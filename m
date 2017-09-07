Received: from eggs.gnu.org ([2001:4830:134:3::10]:50547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dpzhO-0000Mo-9p
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dpzhJ-0003vK-Qt
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:30:38 -0400
Received: from bran.ispras.ru ([83.149.199.196]:41613 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dpzhJ-0003s5-IU
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:30:33 -0400
Received: from [10.10.2.131] (castle.intra.ispras.ru [10.10.2.131])
	by smtp.ispras.ru (Postfix) with ESMTP id 78306203D0
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 19:30:29 +0300 (MSK)
Message-ID: <59B17425.1050701@ispras.ru>
Date: Thu, 07 Sep 2017 19:30:29 +0300
From: Sergey Smolov <smolov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] emulation cycle number implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Hello, List!


I'm running MIPS assembler programs on QEMU. I need to log some events 
that happen through emulation (writes to some registers, for example). 
When an event happens, I need to print not only the event-related 
information, but an "emulation cycle number" also. This number should be 
an integer increasing value that is similar to real hardware clock.

How to implement this in QEMU? May QEMU timers be helpful in solving 
such a problem?

Thanks in advance.

-- 
Sincerely yours,
Sergey Smolov
