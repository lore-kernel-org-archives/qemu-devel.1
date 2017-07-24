Received: from eggs.gnu.org ([2001:4830:134:3::10]:44933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dZlVx-000754-10
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dZlVv-0002dG-QZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:07:45 -0400
References: <7fb8c9ff25d183cf7c0f729a90ee4f59c0632d64.1497602554.git.maozy.fnst@cn.fujitsu.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <38f43362-e3a3-44ab-9c29-d04b4c825085@redhat.com>
Date: Mon, 24 Jul 2017 18:07:26 -0400
MIME-Version: 1.0
In-Reply-To: <7fb8c9ff25d183cf7c0f729a90ee4f59c0632d64.1497602554.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] util: remove the obsolete
 non-blocking connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, mitake.hitoshi@lab.ntt.co.jp, Cao jin <caoj.fnst@cn.fujitsu.com>, mreitz@redhat.com, sheepdog@lists.wpkg.org, kraxel@redhat.com, pbonzini@redhat.com, famz@redhat.com, namei.unix@gmail.com

This was posted over a month ago with two R-Bs, did it get merged or 
dropped?

--js

On 06/16/2017 04:54 AM, Mao Zhongyi wrote:
> From: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> The non-blocking connect mechanism is obsolete, and it doesn't
> work well in inet connection, because it will call getaddrinfo
> first and getaddrinfo will blocks on DNS lookups. Since commit
> e65c67e4 & d984464e, the non-blocking connect of migration goes
> through QIOChannel in a different manner(using a thread), and
> nobody use this old non-blocking connect anymore.
> 
> Any newly written code which needs a non-blocking connect should
> use the QIOChannel code, so we can drop NonBlockingConnectHandler
> as a concept entirely.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> v3:
> 1. fix the mistake that adds a unmodified file '--help' [Fam Zheng]
> 
> v2:
> 1. block/ssh.c is not compiled in v1 which leads to no error
>     reported when I run make & make check, although I make a
> 	mistake in block/ssh.c, because the package libssh2-devel
> 	missed in my system. Now fixed it.
> 2. Write the prototype in a single line. [Juan Quintela]
> 
> Because it's a minor change, so still add the r-b.
> 
> v1:
> This patch was reviewed by Daniel about a years ago, but it has never
> been merged just since socket_connect() called by net_socket_connect_init()
> where NonBlockingConnectHandler was passed to socket_connect(). it's broken.
> 
> Now this problem was worked around by Daniel's patch(commit 6701e551 'Revert
> "Change net/socket.c to use socket_*() functions" again'). Therefore, resend
> it, of course, part of related code has changed over the years, so changed
> the patch accordingly.
> 
> The reviewed patch listed on:
> https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg06373.html
> 
>   block/sheepdog.c       |   2 +-
>   block/ssh.c            |   2 +-
>   include/qemu/sockets.h |  12 +--
>   io/channel-socket.c    |   2 +-
>   util/qemu-sockets.c    | 205 ++++++-------------------------------------------
>   5 files changed, 28 insertions(+), 195 deletions(-)
> 

[snip]
