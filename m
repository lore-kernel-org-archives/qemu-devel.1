Received: from eggs.gnu.org ([2001:4830:134:3::10]:45871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cnrjT-0007az-Lc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cnrjS-0001Nl-Ot
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:03:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cnrjS-0001NG-JV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:03:42 -0400
References: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
	<76f31bd5-4453-563a-9658-9374e68934b6@redhat.com>
	<CAKXe6SJN7QKjL85hj9FpMxGpUc8H6ybFXz9rbTicuiZBSk7TDw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fab04522-7a67-0f53-76fe-2ba973e1dd9c@redhat.com>
Date: Tue, 14 Mar 2017 15:03:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJN7QKjL85hj9FpMxGpUc8H6ybFXz9rbTicuiZBSk7TDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Li Qiang <liq3ea@gmail.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, pbonzini@redhat.com, Li Qiang <liqiang6-s@360.cn>, P J P <ppandit@redhat.com>

On 03/13/2017 10:41 PM, Li Qiang wrote:
> Hello John,
> 
> Does this patch go to upstream?
> 
> Thanks.
> 

Yes, it will be included for 2.9. I usually send my PRs on Friday, but I
was out of town so it got delayed. It qualifies as a bugfix though, so
it can still go in.

--js

> 2017-03-04 6:48 GMT+08:00 John Snow <jsnow@redhat.com
> <mailto:jsnow@redhat.com>>:
> 
> 
> 
>     On 03/02/2017 05:08 AM, Li Qiang wrote:
>     > As the pci ahci can be hotplug and unplug, in the ahci unrealize
>     > function it should free all the resource once allocated in the
>     > realized function. This patchset first add cleanup function in
>     > core layer and then call it in the ahci unit.
>     >
>     > Li Qiang (3):
>     >   ide: qdev: register ide bus unrealize function
>     >   ide: core: add cleanup function
>     >   ide: ahci: call cleanup function in ahci unit
>     >
>     >  hw/ide/ahci.c             | 12 ++++++++++++
>     >  hw/ide/core.c             |  8 ++++++++
>     >  hw/ide/qdev.c             | 12 ++++++------
>     >  include/hw/ide/internal.h |  1 +
>     >  4 files changed, 27 insertions(+), 6 deletions(-)
>     >
> 
>     Thanks, applied to my IDE tree:
> 
>     https://github.com/jnsnow/qemu/commits/ide
>     <https://github.com/jnsnow/qemu/commits/ide>
>     https://github.com/jnsnow/qemu.git <https://github.com/jnsnow/qemu.git>
> 
>     --js
> 
> 
