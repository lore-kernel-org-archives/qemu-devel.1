Received: from eggs.gnu.org ([2001:4830:134:3::10]:34543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK9XG-0002wO-H1
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK9XC-0005Bd-GD
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:04:50 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eK9XC-0005Ay-8s
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:04:46 -0500
Received: by mail-wm0-x243.google.com with SMTP id i11so8575440wmf.4
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 13:04:46 -0800 (PST)
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-16-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <29114153-f1e4-789b-c08c-2104c7cefdb8@linaro.org>
Date: Wed, 29 Nov 2017 21:04:43 +0000
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 15/16] s390x/tcg: drop
 program_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 11/29/2017 08:27 PM, David Hildenbrand wrote:
> All users are gone, we can finally drop it and make sure that all new
> program interrupt injections are reminded of the retaddr - as they have to
> use s390_program_interrupt() now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h       |  1 -
>  target/s390x/interrupt.c | 22 +++++-----------------
>  2 files changed, 5 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
