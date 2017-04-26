Received: from eggs.gnu.org ([2001:4830:134:3::10]:45381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxE-0006b3-15
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxA-0002wP-Qc
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:40 -0400
Received: from [59.151.112.132] (port=16366 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d3HxA-0002ta-Ey
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:05:36 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Apr 2017 16:04:14 +0800
Message-ID: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/4] Convert non-blocking connect and fix
 its error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com

v2:
* PATCH 02 reworking of patch 2 following Markus's suggestion that convert error_report()
  in the function called by net_socket_*_init() to Error. Also add many error handling
  information.
* PATCH 03 net_socket_mcast_create(), net_socket_fd_init_dgram() and net_socket_fd_init() 
  use the function such as fprintf, perror to report an error message. Convert it to Error.
* PATCH 04 parse_host_port() may fail without reporting an error. Now, fix it to set an
  error when it fails.

CC: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com

Mao Zhongyi (4):
  net/socket: Convert the non-blocking connection mechanism to
    QIOchannel
  net/socket: Improve -net socket error reporting
  net/socket: Convert error report message to Error
  net/net: Convert parse_host_port() to Error

 include/qemu/sockets.h |   4 +-
 net/net.c              |  21 +++++--
 net/socket.c           | 159 ++++++++++++++++++++++++++++++-------------------
 util/qemu-sockets.c    |   2 +-
 4 files changed, 117 insertions(+), 69 deletions(-)

-- 
2.9.3
