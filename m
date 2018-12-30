Received: from eggs.gnu.org ([208.118.235.92]:60899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gdPnT-0006KI-V4
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 20:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gdPXt-0007Li-6a
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 20:05:42 -0500
Received: from server54-2.web-hosting.com ([198.54.126.118]:35435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <admin@grossmann-venter.com>)
	id 1gdPXt-0007Ky-0B
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 20:05:37 -0500
Received: from [::1] (port=44732 helo=server54.web-hosting.com)
	by server54.web-hosting.com with esmtpa (Exim 4.91)
	(envelope-from <admin@grossmann-venter.com>) id 1gdPXq-002MjU-NG
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 20:05:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 29 Dec 2018 20:05:34 -0500
From: liebrecht@grossmann-venter.com
In-Reply-To: <201812270548.42446.randrianasulu@gmail.com>
References: <201812270548.42446.randrianasulu@gmail.com>
Message-ID: <dc3a5b53cf46c846eebed0a5bf8b46c2@grossmann-venter.com>
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
