Received: from eggs.gnu.org ([2001:4830:134:3::10]:38366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dEqbJ-0005Pi-5m
	for qemu-devel@nongnu.org; Sun, 28 May 2017 01:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dEqbG-00029f-3F
	for qemu-devel@nongnu.org; Sun, 28 May 2017 01:18:49 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:33956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1dEqbF-00029E-RA
	for qemu-devel@nongnu.org; Sun, 28 May 2017 01:18:46 -0400
Received: by mail-oi0-x22b.google.com with SMTP id b204so50421180oii.1
	for <qemu-devel@nongnu.org>; Sat, 27 May 2017 22:18:45 -0700 (PDT)
Received: from [192.168.1.23] (cpe-72-182-52-210.austin.res.rr.com.
	[72.182.52.210]) by smtp.googlemail.com with ESMTPSA id
	a22sm2783691ote.34.2017.05.27.22.18.43 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 27 May 2017 22:18:43 -0700 (PDT)
From: Rob Landley <rob@landley.net>
Message-ID: <1c8f4f4e-65f7-2d12-a391-08781fea651c@landley.net>
Date: Sun, 28 May 2017 00:18:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Commit b2a575a1c652 broke i486 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

You can't boot a kernel under -cpu 486 since that commit (hangs
producing no output) because it added a bios image that won't run on
anything short of pentium II.

You can try the run-emulator.sh script in
http://landley.net/aboriginal/downloads/binaries/system-image-i486.tar.gz
before and after that commit to check for yourself.

Rob
