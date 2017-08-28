Received: from eggs.gnu.org ([2001:4830:134:3::10]:51716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmRsH-0008Vg-Ls
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmRsD-0005vm-PJ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:47:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dmRsD-0005vM-Ic
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:47:09 -0400
References: <20170825155732.15665-1-stefanha@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7e7711c2-1618-2212-847b-f069aabb0015@redhat.com>
Date: Mon, 28 Aug 2017 17:47:05 -0400
MIME-Version: 1.0
In-Reply-To: <20170825155732.15665-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: chugh.ishani@research.iiit.ac.in



On 08/25/2017 11:57 AM, Stefan Hajnoczi wrote:
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

Acked-by: John Snow <jsnow@redhat.com>

Seems sane to me, provided it actually works in those 2.6 contexts we
wish it to...
