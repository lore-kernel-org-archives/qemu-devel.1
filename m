Received: from eggs.gnu.org ([2001:4830:134:3::10]:42125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLQYd-0006kw-SK
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLQYc-0004cO-Vu
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:55:15 -0400
Date: Thu, 15 Jun 2017 09:54:58 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170615085458.GB26592@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170615030801.6260-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170615030801.6260-1-maozy.fnst@cn.fujitsu.com>
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
Cc: qemu-devel@nongnu.org, Cao jin <caoj.fnst@cn.fujitsu.com>, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org, sheepdog@lists.wpkg.org

On Thu, Jun 15, 2017 at 11:08:01AM +0800, Mao Zhongyi wrote:
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
> Cc: mitake.hitoshi@lab.ntt.co.jp
> Cc: namei.unix@gmail.com
> Cc: jcody@redhat.com
> Cc: kwolf@redhat.com
> Cc: mreitz@redhat.com
> Cc: berrange@redhat.com
> Cc: kraxel@redhat.com
> Cc: pbonzini@redhat.com
> Cc: qemu-block@nongnu.org
> Cc: sheepdog@lists.wpkg.org
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
