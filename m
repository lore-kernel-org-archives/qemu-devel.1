Received: from eggs.gnu.org ([2001:4830:134:3::10]:42173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHcv-00044K-Lp
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHcr-0007RJ-Nv
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:24:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNHcr-0007QU-Hh
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:24:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so3675515wrs.10
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 05:24:05 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-39-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49f2da55-6b89-c359-ff95-08f8e7471038@redhat.com>
Date: Thu, 15 Nov 2018 14:19:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-39-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 38/41] net: do not depend on slirp
 internals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On 14/11/2018 13:36, Marc-André Lureau wrote:
> Only slirp/libslirp.h should be included.
> 
> Instead of using some slirp declarations and utility functions directly,
> let's copy them in net/util.h.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  net/colo.h            |  3 +--
>  net/util.h            | 55 +++++++++++++++++++++++++++++++++++++++++++
>  net/colo-compare.c    |  1 +
>  net/colo.c            |  1 +
>  net/filter-rewriter.c |  1 +
>  net/slirp.c           |  2 +-
>  stubs/slirp.c         |  2 +-
>  7 files changed, 61 insertions(+), 4 deletions(-)

Can you merge net/util.h and net/eth.h?

Thanks,

Paolo
