Received: from eggs.gnu.org ([209.51.188.92]:42057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gteHl-00067L-TV
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gteHk-0000om-0Q
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:04:04 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gteHg-0000eM-4I
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:04:02 -0500
Received: by mail-pl1-x644.google.com with SMTP id bj4so1805551plb.7
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:03:58 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0cca311-970b-3f80-eae8-0e406cd8c02b@linaro.org>
Date: Tue, 12 Feb 2019 12:03:54 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/15] s390x/tcg: Refactor
 saving/restoring the bfp rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2/12/19 3:03 AM, David Hildenbrand wrote:
> We want to reuse this in the context of vector instructions. So use
> better matching names and introduce s390_restore_bfp_rounding_mode().
> 
> While at it, add proper newlines.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
