Received: from eggs.gnu.org ([209.51.188.92]:35773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DS-00044J-4G
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DQ-0002Tf-8J
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:17 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8DP-0002Ck-VI
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:16 -0500
Received: by mail-pg1-x543.google.com with SMTP id m2so8686825pgl.5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:01:56 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd39748f-ec8a-e3a0-1fcb-8650e4004da6@linaro.org>
Date: Wed, 27 Feb 2019 07:44:39 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 11/33] s390x/tcg: Implement VECTOR LOAD
 ELEMENT IMMEDIATE
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
> Take care of properly sign-extending the immediate.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  5 +++++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  2 files changed, 22 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
