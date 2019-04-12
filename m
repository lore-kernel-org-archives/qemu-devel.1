Received: from eggs.gnu.org ([209.51.188.92]:38846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4mD-0003xq-Mt
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 18:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4mC-0001yH-PM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 18:36:05 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF4mC-0001xa-DN
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 18:36:04 -0400
Received: by mail-pl1-x641.google.com with SMTP id bf11so5758612plb.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 15:36:04 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <60923e15-5529-04fa-125c-0c2adabbaf87@linaro.org>
Date: Fri, 12 Apr 2019 12:35:59 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/41] s390x/tcg: Implement VECTOR
 AVERAGE LOGICAL
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

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Similar to VECTOR AVERAGE but without sign extension.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 48 +++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 16 +++++++++++
>  4 files changed, 68 insertions(+)

The vector expansion for vavg applies here too, except with shri instead of
sari.  And of course you code is correct as-is.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
