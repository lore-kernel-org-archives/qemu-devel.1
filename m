Received: from eggs.gnu.org ([2001:4830:134:3::10]:56319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQCu9-0003aE-Sc
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQCu6-0005L3-32
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQCu5-0005Kl-LE
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:21:09 -0400
Date: Wed, 28 Jun 2017 14:21:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170628132104.GI29134@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<4e5b562c22cfcfe7732857d6470fa56ecdd23146.1498654240.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e5b562c22cfcfe7732857d6470fa56ecdd23146.1498654240.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/4] net/socket: Convert several helper
 functions to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com

On Wed, Jun 28, 2017 at 09:08:48PM +0800, Mao Zhongyi wrote:
> Currently, net_socket_mcast_create(), net_socket_fd_init_dgram() and
> net_socket_fd_init() use the function such as fprintf(), perror() to
> report an error message.
> 
> Now, convert these functions to Error.
> 
> Cc: jasowang@redhat.com
> Cc: armbru@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  net/socket.c | 75 +++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 47 insertions(+), 28 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
