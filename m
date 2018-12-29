Received: from eggs.gnu.org ([208.118.235.92]:33919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gd7oA-0004mq-4M
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 01:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gd7aV-0004Uv-KA
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 00:55:15 -0500
Received: from server54-2.web-hosting.com ([198.54.126.118]:40034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <admin@grossmann-venter.com>)
	id 1gd7aV-0004R8-Cw
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 00:55:07 -0500
Received: from [::1] (port=51848 helo=server54.web-hosting.com)
	by server54.web-hosting.com with esmtpa (Exim 4.91)
	(envelope-from <admin@grossmann-venter.com>) id 1gd7aQ-003TFS-Fx
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 00:55:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 29 Dec 2018 00:55:02 -0500
From: liebrecht@grossmann-venter.com
In-Reply-To: <201812270548.42446.randrianasulu@gmail.com>
References: <201812270548.42446.randrianasulu@gmail.com>
Message-ID: <301d618b4520b0c3047b1d7bdc0dbff7@grossmann-venter.com>
Subject: [Qemu-devel] Passing NFS volume on host to win7 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hope I dont have to use samba for this.

 From reading online searches, it seems the following  could work where 
backup is the nfs exported volume to be shared.

-virtfs 
local,path=/backup,mount_tag=host0,security_model=passthrough,id=host0

qemu boots into win7 with this string added so it was accepted but I 
could not find a way to access it from within win7
Anyone has good advice
