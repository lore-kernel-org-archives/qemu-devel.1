Received: from eggs.gnu.org ([209.51.188.92]:40445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gteCg-000232-SS
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gteCf-0007eK-GX
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:58:50 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:39347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gteCf-0007Pt-2i
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:58:49 -0500
Received: by mail-pf1-x434.google.com with SMTP id f132so1798108pfa.6
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 11:58:42 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-11-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <991c61f3-5c3f-d580-d530-0bed3aeb942f@linaro.org>
Date: Tue, 12 Feb 2019 11:58:39 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/15] s390x/tcg: Check for exceptions
 in SET BFP ROUNDING MODE
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
> Let's split handling of BFP/DFP rounding mode configuration. Also,
> let's not reuse the sfpc handler, use a separate handler so we can
> properly check for specification exceptions for SRNMB.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
