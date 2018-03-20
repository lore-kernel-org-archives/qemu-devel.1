Received: from eggs.gnu.org ([2001:4830:134:3::10]:56999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1eyIW7-0005ss-RJ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1eyIW4-0001V3-GZ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:45:35 -0400
Received: from mail-db5eur01on0129.outbound.protection.outlook.com
	([104.47.2.129]:23229
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1eyIW3-0001SD-OZ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:45:32 -0400
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Message-ID: <41b63d9b-c551-4e22-28f5-1144724dff2e@virtuozzo.com>
Date: Tue, 20 Mar 2018 17:45:25 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] Some thoughts about per-queue iothreads in VirtIOBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanha@gmail.com, "Denis V. Lunev" <den@openvz.org>

Hi!

Recently, I have started working on the real multi-queue implementation 
for the VirtIOBlock device and came to conclusion
that for the time being it may work only with RAW images. The reason is 
obviously lack of the true thread-safe multi-queue block
layer, but recently I have seen the following message from Stefan

https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04791.html

It appears like Paolo has already started implementing this feature, so 
I wonder whether the work is abandoned or not, and
could anyone point me out to any of those patches? As I understood from 
Stefan description, it is expected to change significantly
the approach we use to interact with BlockDriverState.

Thanks,
Edgar
