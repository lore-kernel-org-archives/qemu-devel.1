Received: from eggs.gnu.org ([209.51.188.92]:46052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gsE8M-0005Mi-5b
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gsE8B-0001HY-BI
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:56:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gsE83-0000sE-5N
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:56:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so5811595wmj.1
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 13:56:09 -0800 (PST)
References: <20190208181226.24052-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <73d7ff9d-75b5-8216-333f-0f5902ee5161@redhat.com>
Date: Fri, 8 Feb 2019 22:56:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190208181226.24052-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/1] RFC: net/slirp: link with libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, samuel.thibault@ens-lyon.org

On 2/8/19 7:12 PM, Marc-André Lureau wrote:
> Once libslirp has received its first release, we can link with the
> external libslirp library.

Is there a scheduled date?

> The migration data should be compatible with current and older qemu
> versions (same compatibility as today). See "slirp: add state
> saving/loading" patch. However, the content should be treated as a
> blob, as the format may change eventually in the future.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/migration/qemu-file-types.h |    2 +
>  migration/qemu-file.h               |    1 -
>  slirp/bootp.h                       |  128 ---
>  slirp/debug.h                       |   48 -
>  slirp/dhcpv6.h                      |   25 -
>  slirp/if.h                          |   23 -
>  slirp/ip.h                          |  241 -----
>  slirp/ip6.h                         |  159 ---
>  slirp/ip6_icmp.h                    |  231 ----
>  slirp/ip_icmp.h                     |  165 ---
>  slirp/libslirp.h                    |  107 --
>  slirp/main.h                        |   18 -
>  slirp/mbuf.h                        |  126 ---
>  slirp/misc.h                        |   68 --
>  slirp/ncsi-pkt.h                    |  419 --------
>  slirp/qtailq.h                      |  193 ----
>  slirp/sbuf.h                        |   29 -
>  slirp/slirp.h                       |  274 -----
>  slirp/socket.h                      |  162 ---
>  slirp/state.h                       |    9 -
>  slirp/tcp.h                         |  180 ----
>  slirp/tcp_timer.h                   |  127 ---
>  slirp/tcp_var.h                     |  161 ---
>  slirp/tcpip.h                       |  101 --
>  slirp/tftp.h                        |   51 -
>  slirp/udp.h                         |   91 --
>  slirp/util.h                        |  127 ---
>  net/slirp.c                         |   48 +-
>  slirp/arp_table.c                   |   91 --
>  slirp/bootp.c                       |  370 -------
>  slirp/cksum.c                       |  160 ---
>  slirp/dhcpv6.c                      |  206 ----
>  slirp/dnssearch.c                   |  310 ------
>  slirp/if.c                          |  220 ----
>  slirp/ip6_icmp.c                    |  437 --------
>  slirp/ip6_input.c                   |   77 --
>  slirp/ip6_output.c                  |   38 -
>  slirp/ip_icmp.c                     |  469 --------
>  slirp/ip_input.c                    |  471 --------
>  slirp/ip_output.c                   |  172 ---
>  slirp/mbuf.c                        |  237 ----
>  slirp/misc.c                        |  320 ------
>  slirp/ncsi.c                        |  166 ---
>  slirp/ndp_table.c                   |   86 --
>  slirp/sbuf.c                        |  188 ----
>  slirp/slirp.c                       | 1121 -------------------
>  slirp/socket.c                      |  935 ----------------
>  slirp/state.c                       |  394 -------
>  slirp/tcp_input.c                   | 1554 ---------------------------
>  slirp/tcp_output.c                  |  524 ---------
>  slirp/tcp_subr.c                    |  985 -----------------
>  slirp/tcp_timer.c                   |  293 -----
>  slirp/tftp.c                        |  462 --------
>  slirp/udp.c                         |  361 -------
>  slirp/udp6.c                        |  172 ---
>  slirp/util.c                        |  207 ----
>  util/main-loop.c                    |    2 -
>  vl.c                                |    2 -
>  MAINTAINERS                         |    1 -
>  Makefile.objs                       |    1 -
>  configure                           |   25 +
>  net/Makefile.objs                   |    2 +
>  slirp/COPYRIGHT                     |   61 --
>  slirp/Makefile.objs                 |   34 -
>  util/Makefile.objs                  |    1 +
>  65 files changed, 76 insertions(+), 14393 deletions(-)

Nice...
