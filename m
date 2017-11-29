Received: from eggs.gnu.org ([2001:4830:134:3::10]:40903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6sn-00066F-GO
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6sm-0004Rp-E5
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:14:53 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eK6sm-0004RB-87
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:14:52 -0500
Received: by mail-wm0-x242.google.com with SMTP id b76so7806756wmg.1
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 10:14:52 -0800 (PST)
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-14-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <80c8586c-cb1d-4824-8452-a8849f7fa515@linaro.org>
Date: Wed, 29 Nov 2017 18:14:49 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-14-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 13/15] s390x/tcg: use
 program_interrupt_ra() in STSI
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
> STSI needs some more love, but let's do one step at a time.
> We can now drop potential_page_fault().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 2 +-
>  target/s390x/translate.c   | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
