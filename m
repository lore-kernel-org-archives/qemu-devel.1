Received: from eggs.gnu.org ([209.51.188.92]:59693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gceq-qemu-devel2@m.gmane.org>) id 1ghg3i-0004Ov-4F
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gceq-qemu-devel2@m.gmane.org>) id 1ghg3h-0004Qd-G8
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:32:06 -0500
Received: from [195.159.176.226] (port=58082 helo=blaine.gmane.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gceq-qemu-devel2@m.gmane.org>)
	id 1ghg3h-0004PA-8e
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:32:05 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
	(envelope-from <gceq-qemu-devel2@m.gmane.org>) id 1ghg1X-0000ew-Cf
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:29:51 +0100
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Thu, 10 Jan 2019 22:31:56 +0300
Message-ID: <q186f8$1u3$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] qemu-user-linux: how could I measure performance for
 aarch64 and arm?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I am running the same application compiled for aarch64 and armv7l on
x86_64 platform using qemu-user-linux tools.

I see dramatic performance difference (30 times) between emulated
architectures: aarch64 runs for ~4 minutes, armv7l runs for ~2 hours.
I do understand that CPU architecture emulation is inherently slow
thing, but my question is about the difference.

How could I debug to understand what is the reason for such a big
difference? I've already tried to run stress-ng compiled for this two
architectures, but it leads to the same performance per second.

I am running qemu 2.11, should I try other version?
