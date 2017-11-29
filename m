Received: from eggs.gnu.org ([2001:4830:134:3::10]:33538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK9Us-0002Bz-JB
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK9Uo-0003zJ-Jw
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:02:22 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eK9Uo-0003yj-Cq
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:02:18 -0500
Received: by mail-wm0-x243.google.com with SMTP id b76so8627277wmg.1
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 13:02:18 -0800 (PST)
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-11-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d93a0f5f-06ff-9dad-9332-438bf2a896d1@linaro.org>
Date: Wed, 29 Nov 2017 21:02:15 +0000
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 10/16] s390x/tcg: use
 s390_program_interrupt() in SCLP Service Call
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

On 11/29/2017 08:26 PM, David Hildenbrand wrote:
> Now we can drop potential_page_fault(). While at it, move the
> unlock further up, looks cleaner.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 5 ++---
>  target/s390x/translate.c   | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
