Received: from eggs.gnu.org ([2001:4830:134:3::10]:42572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnQLv-0005nZ-0n
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnQLr-0006hg-Qt
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:21:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnQLr-0006hH-KG
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:21:47 -0400
Date: Thu, 31 Aug 2017 16:21:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831162139.2065033c.cohuck@redhat.com>
In-Reply-To: <20170830170601.15855-2-david@redhat.com>
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 01/11] exec,
 dump: don't include exec/exec-all.h explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On Wed, 30 Aug 2017 19:05:51 +0200
David Hildenbrand <david@redhat.com> wrote:

> All but two, namely exec.c and dump.c, include exec/exec-all.h via
> cpu.h only. as these files already include cpu.h, let's just drop the
> additional include.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  dump.c | 1 -
>  exec.c | 1 -
>  2 files changed, 2 deletions(-)
> 

I think there are some more (target/<arch>/arch_dump.c and some i386
files) - do you want to clean up those as well?
