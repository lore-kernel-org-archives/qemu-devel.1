Received: from eggs.gnu.org ([2001:4830:134:3::10]:35380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eu6up-0002Ad-9C
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 20:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eu6um-0003Kw-7G
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 20:33:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eu6um-0003KP-2j
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 20:33:44 -0500
Date: Fri, 9 Mar 2018 09:33:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180309013329.GA14854@lemon.usersys.redhat.com>
References: <20180226075846.20307-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226075846.20307-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] slirp: Add query-usernet QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

Gentle ping..

On Mon, 02/26 15:58, Fam Zheng wrote:
> v2: Fix compiler error. [patchew]
> 
> The command is a counterpart of HMP "info usernet" and is at least very useful
> for the VM tests. So add it.
> 
> Fam Zheng (2):
>   slirp: Add "query-usernet" QMP command
>   tests: Use query-usernet instead of 'info usernet'
> 
>  net/slirp.c        |  26 +++++++
>  qapi/net.json      | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  slirp/libslirp.h   |   1 +
>  slirp/misc.c       | 156 +++++++++++++++++++++++++++++------------
>  slirp/tcp.h        |  15 ----
>  tests/vm/basevm.py |  14 ++--
>  6 files changed, 346 insertions(+), 67 deletions(-)
> 
> -- 
> 2.14.3
> 
