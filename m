Received: from eggs.gnu.org ([2001:4830:134:3::10]:49001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBWI-0007Dp-0g
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBWE-0005V0-2q
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:19:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fDBWD-0005UX-U9
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:19:13 -0400
References: <20180428123627.12445.9923.stgit@pasha-VirtualBox>
	<20180428123731.12445.68139.stgit@pasha-VirtualBox>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d5f2b0fc-9cf8-aad3-bfb5-da48a2946ab3@redhat.com>
Date: Mon, 30 Apr 2018 11:18:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180428123731.12445.68139.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 11/19] replay: flush events when
 exitting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

On 04/28/2018 07:37 AM, Pavel Dovgalyuk wrote:

In the subject: s/exitting/exiting/

> This patch adds events processing when emulation finishes instead
> of just cleaning the queue. Now the bdrv coroutines will be in consistent
> state when emulator closes. It allows correct polling of the block layer
> at exit.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>   replay/replay-events.c   |   14 +-------------
>   replay/replay-internal.h |    2 --
>   2 files changed, 1 insertion(+), 15 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
