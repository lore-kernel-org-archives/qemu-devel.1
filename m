Received: from eggs.gnu.org ([2001:4830:134:3::10]:46451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cEQct-0007Rc-F1
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 20:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cEQcq-0004so-Ci
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 20:02:27 -0500
Received: from mail.kernel.org ([198.145.29.136]:52098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cEQcq-0004sY-6N
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 20:02:24 -0500
Date: Tue, 6 Dec 2016 17:02:18 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1480572399-10455-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.10.1612061700330.6598@sstabellini-ThinkPad-X260>
References: <1480572399-10455-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 0/3] Add new qmp commands to suppurt Xen
 COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, xen-devel@lists.xenproject.org

Hello Zhang,

Are the corresponding libxl patches already in xen.git? If so, could you
please mention the commits; if not, could you please add a link to the
corresponding patches?

Thanks!

- Stefano

On Thu, 1 Dec 2016, Zhang Chen wrote:
> Xen COLO depend on qemu COLO replication function.
> So, We need new qmp commands for Xen to use qemu replication.
> 
> Zhang Chen (3):
>   Migration: Don't load vmdesc when xen is enabled
>   Add a new qmp command to start/stop replication
>   Add a new qmp command to do checkpoint, get replication error
> 
>  docs/qmp-commands.txt | 41 +++++++++++++++++++++++++++++++++++++++++
>  migration/colo.c      | 32 ++++++++++++++++++++++++++++++++
>  migration/savevm.c    |  4 ++++
>  qapi-schema.json      | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 117 insertions(+)
> 
> -- 
> 2.7.4
> 
> 
> 
> 
