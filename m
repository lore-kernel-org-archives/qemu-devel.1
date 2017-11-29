Received: from eggs.gnu.org ([2001:4830:134:3::10]:53762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK69c-0002eC-MG
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK69Z-00012l-Gx
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:28:12 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eK69Z-00012Y-9g
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:28:09 -0500
Received: by mail-wr0-x243.google.com with SMTP id g53so4141681wra.2
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 09:28:08 -0800 (PST)
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6077e579-5563-d281-2d3f-e8aac10b12aa@linaro.org>
Date: Wed, 29 Nov 2017 17:28:05 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 03/15] s390x/tcg: rip out dead
 tpi code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 11/28/2017 08:33 PM, David Hildenbrand wrote:
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
