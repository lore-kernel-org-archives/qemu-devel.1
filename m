Received: from eggs.gnu.org ([2001:4830:134:3::10]:51053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eBhqq-00062P-Ve
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eBhqm-0001Zu-TE
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:54:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1eBhqm-0001ZM-Mg
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:54:04 -0500
Date: Mon, 6 Nov 2017 14:53:59 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20171106135359.eivbngm7ax5yln2g@localhost.localdomain>
References: <20171106132805.19986-1-jfreimann@redhat.com>
	<20171106133349.3ddquhwe72axdtjl@starbug-vm.ie.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171106133349.3ddquhwe72axdtjl@starbug-vm.ie.oracle.com>
Subject: Re: [Qemu-devel] [PATCH] net/socket: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, jasowang@redhat.com, darren.kenny@oracle.com

On Mon, Nov 06, 2017 at 01:33:49PM +0000, Darren Kenny wrote:
>Hi Jan,
>
>On Mon, Nov 06, 2017 at 02:28:05PM +0100, Jens Freimann wrote:
>>This fixes coverity issue CID1005339.
>>
>>Make sure that saddr is not used uninitialized if the
>>mcast parameter is NULL.
>>
>>Cc: qemu-stable@nongnu.org
>>Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>>---
>>net/socket.c | 4 ++--
>>1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>diff --git a/net/socket.c b/net/socket.c
>>index e6b471c63d..51eaea67a0 100644
>>--- a/net/socket.c
>>+++ b/net/socket.c
>>@@ -332,7 +332,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>>                                                const char *mcast,
>>                                                Error **errp)
>>{
>>-    struct sockaddr_in saddr;
>>+    struct sockaddr_in saddr = { 0 };
>
>Based on:
>
>  https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg04946.html
>
>It would appear that the use of {} to initialize the struct is
>preferred over {0}.

Thanks for the hint Darren. I'll change it in the next version (or get
rid of the initalization completely).

regards,
Jens 
