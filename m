Received: from eggs.gnu.org ([2001:4830:134:3::10]:48295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d96GG-0004Nd-6o
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d96GD-00083i-5G
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:49:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:58880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d96GC-00083G-Sp
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:49:17 -0400
Message-ID: <59157781.3050301@intel.com>
Date: Fri, 12 May 2017 16:51:13 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<1494578148-102868-12-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-12-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/16] vhost-user: add asynchronous read
 for the vhost-user master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 05/12/2017 04:35 PM, Wei Wang wrote:
> Enable the vhost-user master to asynchronously receive messages
> from the slave. The vhost_user_asyn_read and vhost_user_can_read
> stub functions are defined for platforms that do not support the
> use of virtio.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

After the secondary channel based solution is merged:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02467.html
, we can switch to use that.

Best,
Wei
