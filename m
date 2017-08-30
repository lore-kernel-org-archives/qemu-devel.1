Received: from eggs.gnu.org ([2001:4830:134:3::10]:34458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmyRn-0007mR-E6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmyRh-0003Yu-M7
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:03 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmyRh-0003YO-F2
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:33:57 -0400
Received: by mail-wm0-x242.google.com with SMTP id m85so509364wma.0
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 01:33:57 -0700 (PDT)
Date: Wed, 30 Aug 2017 09:33:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830083354.GC24565@stefanha-x1.localdomain>
References: <20170829212053.6003-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829212053.6003-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Print errors before aborting
 on qemu_alloc_stack()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Aug 29, 2017 at 06:20:53PM -0300, Eduardo Habkost wrote:
> If QEMU is running on a system that's out of memory and mmap()
> fails, QEMU aborts with no error message at all, making it hard
> to debug the reason for the failure.
> 
> Add perror() calls that will print error information before
> aborting.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  util/oslib-posix.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan
