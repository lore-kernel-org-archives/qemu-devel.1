Received: from eggs.gnu.org ([2001:4830:134:3::10]:42175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6y3-0000bt-9Q
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6xy-0000GT-6t
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:20:19 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eK6xx-0000Ff-Jh
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:20:13 -0500
Received: by mail-wm0-x241.google.com with SMTP id i11so7774162wmf.4
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 10:20:13 -0800 (PST)
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-16-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <70687e74-b3fa-f397-3f5e-52aa1aedb9c7@linaro.org>
Date: Wed, 29 Nov 2017 18:20:10 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 15/15] s390x/tcg: drop
 potential_page_fault()
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
> Only one user left, get rid of it so we don't get any new users.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
