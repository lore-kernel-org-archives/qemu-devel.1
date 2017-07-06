Received: from eggs.gnu.org ([2001:4830:134:3::10]:49147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT16w-0002LG-JH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT16r-0004VF-S9
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dT16r-0004Us-Lp
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:21:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499250206.git.maozy.fnst@cn.fujitsu.com>
	<dead2942a713810709c6ed8cbafc7381bee5d08f.1499250206.git.maozy.fnst@cn.fujitsu.com>
Date: Thu, 06 Jul 2017 09:21:54 +0200
In-Reply-To: <dead2942a713810709c6ed8cbafc7381bee5d08f.1499250206.git.maozy.fnst@cn.fujitsu.com>
	(Mao Zhongyi's message of "Wed, 5 Jul 2017 19:01:55 +0800")
Message-ID: <878tk29gj1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 2/4] net/socket: Convert several helper
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
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> Currently, net_socket_mcast_create(), net_socket_fd_init_dgram() and
> net_socket_fd_init() use the function such as fprintf(), perror() to
> report an error message.
>
> Now, convert these functions to Error.
>
> Cc: jasowang@redhat.com
> Cc: armbru@redhat.com
> Cc: berrange@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
