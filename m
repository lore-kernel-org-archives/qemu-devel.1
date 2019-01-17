Received: from eggs.gnu.org ([209.51.188.92]:36831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gkGmQ-0004u6-9i
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 18:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gkGmP-0007FB-DG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 18:08:58 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:37646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gkGmP-0007Bo-3J
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 18:08:57 -0500
Date: Fri, 18 Jan 2019 00:08:53 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190117230853.lbuqljd5srd6wcpu@function>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/27] slirp: make it again a standalone
 project (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Also thinking about it: I guess we'd want to make the usage of libslirp
optional, at least because (I guess) at some points the future libslirp
may want to change the API (nobody can do something perfect at first
try), and when that breaks qemu build it would nasty if people couldn't
just disable libslirp usage to get qemu built for needs which don't
require slirp.

Also some people would really like to see the dreaded slirp stack off
their qemu binaries :)

Samuel
