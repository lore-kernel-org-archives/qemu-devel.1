Received: from eggs.gnu.org ([2001:4830:134:3::10]:43975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn5Vp-000886-7X
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn5Vk-0000ul-8E
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:06:41 -0400
Date: Wed, 30 Aug 2017 17:06:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830160633.GX24565@stefanha-x1.localdomain>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 08/10] scsi: build
 qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:30PM +0200, Paolo Bonzini wrote:
> +#ifdef CONFIG_MPATH
> +    dm_init();
> +    multipath_pr_init();
> +#endif

This should be in the next patch.

Stefan
