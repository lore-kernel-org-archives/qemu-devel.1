Received: from eggs.gnu.org ([2001:4830:134:3::10]:59684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erTo9-0002pp-T8
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erTo9-0008RW-3F
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:24:01 -0500
References: <20180301163619.21072-1-pbonzini@redhat.com>
	<20180301163619.21072-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90184560-6141-4b44-bf3a-4a2958410981@redhat.com>
Date: Thu, 1 Mar 2018 13:23:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180301163619.21072-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/8] block: rename .bdrv_create() to
 .bdrv_co_create_opts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 03/01/2018 10:36 AM, Paolo Bonzini wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> BlockDriver->bdrv_create() has been called from coroutine context since
> commit 5b7e1542cfa41a281af9629d31cef03704d976e6 ("block: make
> bdrv_create adopt coroutine").
> 
> Make this explicit by renaming to .bdrv_co_create_opts() and add the
> coroutine_fn annotation.  This makes it obvious to block driver authors
> that they may yield, use CoMutex, or other coroutine_fn APIs.
> bdrv_co_create is reserved for the QAPI-based version that Kevin is
> working on.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20170705102231.20711-2-stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <1516279431-30424-2-git-send-email-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Fun with repeated Message-Id and S-o-B ;)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
