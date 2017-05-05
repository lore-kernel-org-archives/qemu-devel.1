Received: from eggs.gnu.org ([2001:4830:134:3::10]:40118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreiman@redhat.com>) id 1d6Xdi-0005Om-78
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreiman@redhat.com>) id 1d6Xde-0001Ul-AO
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:26:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreiman@redhat.com>) id 1d6Xde-0001UI-4d
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:26:54 -0400
Date: Fri, 5 May 2017 09:26:46 +0200
From: Jens Freimann <jfreiman@redhat.com>
Message-ID: <20170505072646.gubg5i3uqrd5qjwn@dhcp-192-205.str.redhat.com>
References: <1493363372-16861-1-git-send-email-zhiyong.yang@intel.com>
	<1493915136-19150-1-git-send-email-zhiyong.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493915136-19150-1-git-send-email-zhiyong.yang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/virtio: fix vhost user fails to
 startup when MQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhiyong Yang <zhiyong.yang@intel.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@gmail.com, mst@redhat.com

On Fri, May 05, 2017 at 12:25:36AM +0800, Zhiyong Yang wrote:
>  Qemu2.7~2.9 and vhost user for dpdk 17.02 release work together
> to cause failures of new connection when negotiating to set MQ.
> (one queue pair works well).
>    Because there exist some bugs in qemu code when introducing
> VHOST_USER_PROTOCOL_F_REPLY_ACK to qemu. When vhost_user_set_mem_table
> is invoked to deal with the vhost message VHOST_USER_SET_MEM_TABLE
> for the second time, qemu indeed doesn't send the messge (The message
> needs to be sent only once)but still will be waiting for dpdk's reply
> ack, then, qemu is always freezing, while DPDK is always waiting for
> next vhost message from qemu.
>   The patch aims to fix the bug, MQ can work well.
>   The same bug is found in function vhost_user_net_set_mtu, it is fixed
> at the same time.
>   DPDK related patch is as following:
>   http://www.dpdk.org/dev/patchwork/patch/23955/
> 
> Signed-off-by: Zhiyong Yang <zhiyong.yang@intel.com>

Tested-by: Jens Freimann <jfreiman@redhat.com>
