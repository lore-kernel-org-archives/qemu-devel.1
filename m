Received: from eggs.gnu.org ([2001:4830:134:3::10]:39276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ciTp7-00008z-5t
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ciTp2-0005DD-9k
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:31:17 -0500
Received: from mail.kernel.org ([198.145.29.136]:58864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ciTp2-000599-2o
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:31:12 -0500
Date: Mon, 27 Feb 2017 14:31:06 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1487990764-27397-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.10.1702271429350.7315@sstabellini-ThinkPad-X260>
References: <1487990764-27397-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH V10 0/2] Add new qmp commands to suppurt
 Xen COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

Eric, are you OK with this series going upstream? If so, do you want me
to send the pull request for it or are you going to handle it?

On Sat, 25 Feb 2017, Zhang Chen wrote:
> Xen COLO depend on qemu COLO replication function.
> So, We need new qmp commands for Xen to use qemu replication.
> 
> Corresponding libxl patches already in xen.git.
> Commit ID:
> 
> ed37ef1f91c20f0ab162ce60f8c38400b917fa64
> COLO: introduce new API to prepare/start/do/get_error/stop replication
> 
> a0ddc0b359375b2418213966dfbdbfab593ecc6f
> tools/libxl: introduction of libxl__qmp_restore to load qemu state
> 
> V10:
>    - Fix ReplicationStatus error comments.
>    - Fix query-xen-replication-status example.
> 
> Zhang Chen (2):
>   Add a new qmp command to start/stop replication
>   Add a new qmp command to do checkpoint, query xen replication status
> 
>  migration/colo.c | 49 +++++++++++++++++++++++++++++++++++++
>  qapi-schema.json | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 
> -- 
> 2.7.4
> 
> 
> 
