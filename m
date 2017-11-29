Received: from eggs.gnu.org ([2001:4830:134:3::10]:33012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6YF-0000Ad-FK
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6YA-0003iL-K5
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:53:39 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eK6YA-0003hD-Dt
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:53:34 -0500
Received: by mail-wm0-x244.google.com with SMTP id 64so7614535wme.3
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 09:53:34 -0800 (PST)
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <016556b4-c632-7421-af7b-3c23a576c430@linaro.org>
Date: Wed, 29 Nov 2017 17:53:31 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 08/15] s390x/tcg: io
 instructions don't need potential_page_fault()
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
> As we handle the retaddr in all cases properly now, we can drop it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
