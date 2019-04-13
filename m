Received: from eggs.gnu.org ([209.51.188.92]:45064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFEYL-0007kS-C7
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 05:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFEYK-0004JI-Ax
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 05:02:25 -0400
Received: from 5.itsy.de ([188.40.84.14]:60851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jo@durchholz.org>) id 1hFEYK-0004HV-08
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 05:02:24 -0400
Received: from [192.168.178.32] (unknown [195.48.33.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 5.itsy.de (Postfix) with ESMTPSA id 1CB6C65763
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 11:02:21 +0200 (CEST)
From: Joachim Durchholz <jo@durchholz.org>
Message-ID: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
Date: Sat, 13 Apr 2019 11:02:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] curses.c: "We need a terminal output" ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

what's the reasoning behind "We need a terminal output" in curses.c?

I don't really see a scenario where it's problematic if qemu emits 
escape sequences to a pipe.
I have experienced one scenario where it is problematic: It doesn't work 
properly with pexpect and expectit (a Python and a Java library that do 
expect). I suspect they fail to use a pty, but then I see no harm in not 
doing so.
I can see another scenario when this is problematic: Unit testing code 
that directly writes to the console. E.g. testing BIOS code, or testing 
operating systems when using the serial port is not an option.

Regards,
Jo
