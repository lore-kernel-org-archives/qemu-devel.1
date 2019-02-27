Received: from eggs.gnu.org ([209.51.188.92]:35609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DL-0003zx-JE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DD-0002Hp-Kz
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:07 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8D2-00029t-C6
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:01:54 -0500
Received: by mail-pl1-x644.google.com with SMTP id k2so8732122plt.3
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:01:52 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-11-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc64c2cd-24ea-c160-46d2-7f01625630a1@linaro.org>
Date: Wed, 27 Feb 2019 07:42:58 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/33] s390x/tcg: Implement VECTOR LOAD
 ELEMENT
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
> Fairly easy, load with desired size and store it into the right element.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  5 +++++
>  target/s390x/translate_vx.inc.c | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
