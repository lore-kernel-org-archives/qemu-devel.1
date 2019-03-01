Received: from eggs.gnu.org ([209.51.188.92]:46641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzm40-0005g4-PW
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzm40-0003ne-1q
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:35:12 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzm3z-0003mE-Qb
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:35:11 -0500
Received: by mail-pg1-x544.google.com with SMTP id m2so11755576pgl.5
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 09:35:11 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-23-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6ebfc2f2-9143-a24d-c4ea-bf04de27fcb4@linaro.org>
Date: Fri, 1 Mar 2019 09:35:06 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-23-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/32] s390x/tcg: Implement VECTOR
 REPLICATE
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

On 3/1/19 3:54 AM, David Hildenbrand wrote:
> +    read_vec_element_i64(tmp, get_field(s->fields, v3), enr, es);
> +    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);

Ah!  I just remembered.  There is a special gvec primitive for this.

  tcg_gen_gvec_dup_mem(es, vec_full_reg_offset(v1),
                       vec_reg_offset(v3, enr, es), 16, 16);


r~
