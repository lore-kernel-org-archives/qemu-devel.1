Received: from eggs.gnu.org ([2001:4830:134:3::10]:45751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djoIl-0004qx-Op
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djoIg-0003Lu-1d
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:07:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1djoIf-0003LI-Qy
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:07:33 -0400
Date: Mon, 21 Aug 2017 17:07:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170821170728.3d5f01a3.cohuck@redhat.com>
In-Reply-To: <20170818114844.30061-1-cohuck@redhat.com>
References: <20170818114844.30061-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] s390x: diag-related things
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com

On Fri, 18 Aug 2017 13:48:41 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> ...which are a fix in tcg for diag handling and diag288 watchdog changes.
> 
> v1->v2: just reorder patches for less churn [Thomas]
> 
> Cornelia Huck (2):
>   s390x/tcg: specification exception for unknown diag
>   s390x: wire up diag288 in tcg
> 
> Thomas Huth (1):
>   watchdog/wdt_diag288: Mark diag288 watchdog as non-hotpluggable
> 
>  hw/watchdog/wdt_diag288.c  | 1 +
>  target/s390x/misc_helper.c | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Queued to s390-next.
