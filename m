Received: from eggs.gnu.org ([2001:4830:134:3::10]:43398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJslY-0003IP-NL
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 22:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJslT-0003q8-PK
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 22:10:28 -0500
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-4-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <927e4fc4-ebd4-98d6-bfcd-a44e06be23da@redhat.com>
Date: Wed, 29 Nov 2017 04:10:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.12 03/15] s390x/tcg:
 rip out dead tpi code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 28.11.2017 21:33, David Hildenbrand wrote:
> It is broken and not even wired up. We'll add a new handler soon, but
> that will live somewhere else.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/css.c          |  6 ------
>  include/hw/s390x/css.h  |  1 -
>  target/s390x/internal.h |  1 -
>  target/s390x/ioinst.c   | 26 --------------------------
>  4 files changed, 34 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
