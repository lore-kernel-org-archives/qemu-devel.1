Received: from eggs.gnu.org ([2001:4830:134:3::10]:39359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjw0X-0003lg-LC
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 17:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjw0U-0001mU-IL
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 17:49:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cjw0U-0001lT-CU
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 17:49:02 -0500
References: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
From: John Snow <jsnow@redhat.com>
Message-ID: <76f31bd5-4453-563a-9658-9374e68934b6@redhat.com>
Date: Fri, 3 Mar 2017 17:48:59 -0500
MIME-Version: 1.0
In-Reply-To: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] ide: ahci: fix memory leak in device
 unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Li Qiang <liqiang6-s@360.cn>, ppandit@redhat.com



On 03/02/2017 05:08 AM, Li Qiang wrote:
> As the pci ahci can be hotplug and unplug, in the ahci unrealize
> function it should free all the resource once allocated in the
> realized function. This patchset first add cleanup function in
> core layer and then call it in the ahci unit.
> 
> Li Qiang (3):
>   ide: qdev: register ide bus unrealize function
>   ide: core: add cleanup function
>   ide: ahci: call cleanup function in ahci unit
> 
>  hw/ide/ahci.c             | 12 ++++++++++++
>  hw/ide/core.c             |  8 ++++++++
>  hw/ide/qdev.c             | 12 ++++++------
>  include/hw/ide/internal.h |  1 +
>  4 files changed, 27 insertions(+), 6 deletions(-)
> 

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js
