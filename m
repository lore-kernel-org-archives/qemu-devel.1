Received: from eggs.gnu.org ([2001:4830:134:3::10]:45688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn0lf-0005WF-EG
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn0lb-0004O2-8Q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:02:43 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn0lb-0004Na-2r
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:02:39 -0400
Received: by mail-wm0-x243.google.com with SMTP id x189so1383408wmg.4
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 04:02:38 -0700 (PDT)
Date: Wed, 30 Aug 2017 12:02:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830110235.GL24565@stefanha-x1.localdomain>
References: <20170825155732.15665-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825155732.15665-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] scripts: add argparse module for
 Python 2.6 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, chugh.ishani@research.iiit.ac.in

On Fri, Aug 25, 2017 at 04:57:29PM +0100, Stefan Hajnoczi wrote:
> Many scripts can benefit from the standard library argparse module, which has
> improvements over the older optparse module.  Unfortunately argparse was only
> shipped in Python 2.7 so we need a fallback for Python 2.6.
> 
> This patch series adds a copy of argparse.py and updates scripts as necessary
> to import it.
> 
> Stefan Hajnoczi (3):
>   scripts: add argparse module for Python 2.6 compatibility
>   docker.py: Python 2.6 argparse compatibility
>   tests: migration/guestperf Python 2.6 argparse compatibility
> 
>  COPYING.PYTHON                     |  270 ++++
>  scripts/argparse.py                | 2406 ++++++++++++++++++++++++++++++++++++
>  tests/docker/docker.py             |    4 +-
>  tests/migration/guestperf/shell.py |    8 +-
>  4 files changed, 2684 insertions(+), 4 deletions(-)
>  create mode 100644 COPYING.PYTHON
>  create mode 100644 scripts/argparse.py
> 
> -- 
> 2.13.5
> 
> 

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan
