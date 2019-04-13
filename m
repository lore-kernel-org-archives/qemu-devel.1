Received: from eggs.gnu.org ([209.51.188.92]:44506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFKYt-0001vM-HE
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFKYr-0005oY-Ex
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:27:23 -0400
Received: from 5.itsy.de ([188.40.84.14]:44206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jo@durchholz.org>) id 1hFKYo-0005j6-FG
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:27:19 -0400
Received: from [192.168.178.32] (unknown [195.48.33.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 5.itsy.de (Postfix) with ESMTPSA id 9AA14658AE
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 17:27:14 +0200 (CEST)
From: Joachim Durchholz <jo@durchholz.org>
Message-ID: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
Date: Sat, 13 Apr 2019 17:27:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] How to I trigger a rebuild?
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

I did the usual ./configure; make dance.
Then modified a source file (ui/curses.c), called make again, but didn't 
see curses.c recompiled, and the change was indeed ineffective.
make clean; make didn't help either.

Is there a list of make targets anywhere?
I looked in a few places in the source directories but nothing presented 
itself.

Regards,
Jo
