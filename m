Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cJ8jm-0004ON-Eu
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 19:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cJ8jj-0005d5-EE
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 19:57:02 -0500
Received: from mail.kernel.org ([198.145.29.136]:59188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cJ8jj-0005cc-8D
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 19:56:59 -0500
Date: Mon, 19 Dec 2016 16:56:53 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.10.1612191655320.13831@sstabellini-ThinkPad-X260>
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH for-2.9 V4 0/2] Add new qmp commands to
 suppurt Xen COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

I am OK with this, if the relevant maintainers (Migration, QMP) ack the
patches.

On Fri, 16 Dec 2016, Zhang Chen wrote:
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
> 
> Zhang Chen (2):
>   Add a new qmp command to start/stop replication
>   Add a new qmp command to do checkpoint, get replication error
> 
>  docs/qmp-commands.txt | 42 ++++++++++++++++++++++++++++++++++++++++++
>  migration/colo.c      | 33 +++++++++++++++++++++++++++++++++
>  qapi-schema.json      | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
> 
> -- 
> 2.7.4
> 
> 
> 
> 
