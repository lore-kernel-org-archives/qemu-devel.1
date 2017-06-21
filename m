Received: from eggs.gnu.org ([2001:4830:134:3::10]:52287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNeUC-0002pD-Nc
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNeU7-0003ik-Vh
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:11:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNeU7-0003iF-QT
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:11:47 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497640120-10729-3-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Fri, 16 Jun 2017 22:08:39 +0300")
References: <1497640120-10729-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170616190852eucas1p25223609a18a68b900540094697e88f54@eucas1p2.samsung.com>
	<1497640120-10729-3-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 21 Jun 2017 14:11:38 +0200
Message-ID: <87podxk0at.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/3] migration: introduce
 qemu_ufd_copy_ioctl helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> Just for placing auxilary operations inside helper,
> auxilary operations like: track received pages,
> notify about copying operation in futher patches.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>



> +static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> +        void *from_addr, uint64_t pagesize)

from_addr is a void*

> -        if (ioctl(mis->userfault_fd, UFFDIO_ZEROPAGE, &zero_struct)) {
> +        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, 0, getpagesize())) {

And you pass 0 here, better NULL no?

If you have to respin, please change it.  You can maintain the reviewed-by.

>              int e = errno;
>              error_report("%s: %s zero host: %p",
>                           __func__, strerror(e), host);
