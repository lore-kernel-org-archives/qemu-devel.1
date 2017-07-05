Received: from eggs.gnu.org ([2001:4830:134:3::10]:40259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSi4l-0003Z2-FY
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSi4i-0000FI-Ma
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:02:31 -0400
Received: from [59.151.112.132] (port=56355 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSi4i-0000EX-AZ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:02:28 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 5 Jul 2017 19:01:53 +0800
Message-ID: <cover.1499250206.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 0/4] Improve error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, armbru@redhat.com, berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, eblake@redhat.com

v8:
* PATCH 02 & 04
  -resetting the error message for the user to read.   [Markus Armbruster]
  
v7:
* PATCH 01
  -fix the error message.    [Daniel P. Berrange]
  -adjust the Indentation problem.    [Eric Blake]
* PATCH 03
  -print a generic message when gethostbyname() failed in parse_host_port(),
   drop the misleading ": unkonwn host" part.    [Markus Armbruster]

v6:
* PATCH 02
  -rename the subject
  -drop the "qemu: error: " prefix.
  -correct inappropriate error information settings.
* PATCH 03,04
  -correct inappropriate error information settings.    [Markus Armbruster]

v5:
* PATCH 01 make the commit message more exact about the actual function.    [Markus Armbruster]
* PATCH 02, 03, 04 still retains the original function, but specific
           content and order of each patch has been adjusted substantially, 
           so that ensure each patch is a completed fix.    [Markus Armbruster]

v4: 
* PATCH 01 is redoing previous patch 1, replace the fprintf() with error_report()
		     in the 'default' case of net_socket_fd_init() [Markus Armbruster]

v3:
* PATCH 01 is suggested by Markus and Daniel that removes the dubious 'default' case
           in the net_socket_fd_init(). Jason agreed.
* PATCH 02 is redoing previous patch 4.
* PATCH 04 is redoing previous patch 2, improves sort of error messages. 

v2:
* PATCH 02 reworking of patch 2 following Markus's suggestion that convert error_report()
           in the function called by net_socket_*_init() to Error. Also add many error 
           handling information.
* PATCH 03 net_socket_mcast_create(), net_socket_fd_init_dgram() and net_socket_fd_init() 
           use the function such as fprintf, perror to report an error message. Convert it 
           to Error.
* PATCH 04 parse_host_port() may fail without reporting an error. Now, fix it to set an
           error when it fails.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Cc: berrange@redhat.com
Cc: kraxel@redhat.com
Cc: pbonzini@redhat.com
Cc: eblake@redhat.com

Mao Zhongyi (4):
  net/socket: Don't treat odd socket type as SOCK_STREAM
  net/socket: Convert several helper functions to Error
  net/net: Convert parse_host_port() to Error
  net/socket: Improve -net socket error reporting

 include/qemu/sockets.h |   3 +-
 net/net.c              |  22 +++++--
 net/socket.c           | 153 ++++++++++++++++++++++++++++---------------------
 3 files changed, 106 insertions(+), 72 deletions(-)

-- 
2.9.4
