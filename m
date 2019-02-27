Received: from eggs.gnu.org ([209.51.188.92]:35694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DQ-00044C-I2
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DP-0002S3-HR
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:16 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8DP-0002O9-16
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:15 -0500
Received: by mail-pl1-x643.google.com with SMTP id b65so5701305plb.6
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:02:10 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-15-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c57c068f-1c42-9cba-0f0f-3204f6648d8d@linaro.org>
Date: Wed, 27 Feb 2019 08:02:56 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-15-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 14/33] s390x/tcg: Implement VECTOR LOAD
 MULTIPLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2/26/19 3:38 AM, David Hildenbrand wrote:
> Also fairly easy to implement. One issue we have is that exceptions will
> result in some vectors already being modified. At least handle it
> consistently per vector by using a temporary vector. Good enough for
> now, add a FIXME.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)

I suppose the fixme is good enough.  For the record, I think you could do the
check with just two loads -- the first and last quadword.  After that, none of
the other loads can fault, and you can store everything else into the
destination vectors as you read them.

Also missing for the fixme: MO_ALIGN{,_16}.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
