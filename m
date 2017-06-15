Received: from eggs.gnu.org ([2001:4830:134:3::10]:53790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dLPIo-0008VL-Vv
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dLPIo-0005tA-6O
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:34:51 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170615030801.6260-1-maozy.fnst@cn.fujitsu.com> (Mao Zhongyi's
	message of "Thu, 15 Jun 2017 11:08:01 +0800")
References: <20170615030801.6260-1-maozy.fnst@cn.fujitsu.com>
Reply-To: quintela@redhat.com
Date: Thu, 15 Jun 2017 09:34:40 +0200
Message-ID: <87mv99aelr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] util: remove the obsolete non-blocking
 connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, sheepdog@lists.wpkg.org, Cao jin <caoj.fnst@cn.fujitsu.com>, kraxel@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> wrote:
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


Reviewed-by: Juan Quintela <quintela@redhat.com>


...

>  int inet_connect_saddr(InetSocketAddress *saddr,
> -                       NonBlockingConnectHandler *callback, void *opaque,
>                         Error **errp);

In case you have to respin it.

Now you can write the prototype in a single line, no?
Same for the rest of appearances.
