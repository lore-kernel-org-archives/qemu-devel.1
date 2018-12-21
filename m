Received: from eggs.gnu.org ([2001:4830:134:3::10]:59482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gaB9R-0008Jp-1h
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 22:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gaB9N-00077Q-Th
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 22:07:01 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:43857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gaB9N-000765-Ho
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 22:06:57 -0500
Received: by mail-pl1-x633.google.com with SMTP id gn14so1802920plb.10
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 19:06:56 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10]) by smtp.gmail.com with ESMTPSA id
	s79sm33301789pgs.50.2018.12.20.19.06.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Dec 2018 19:06:53 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <beec7ae9-f9ce-52f0-7e55-cb25d70c51f4@ozlabs.ru>
Date: Fri, 21 Dec 2018 14:06:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] travis failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi

I am trying https://travis-ci.org/aik/qemu/ and that thing fails every
time I am not so sure why.

One example:
https://travis-ci.org/aik/qemu/jobs/470796318

The errors are like this:

  GTESTER check-qtest-unicore32
  GTESTER check-qtest-x86_64
Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator


Does anyone else see those? How do we fix them? Thanks.


-- 
Alexey
