Received: from eggs.gnu.org ([209.51.188.92]:57428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkis-0006J6-PY
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkiq-0002ZE-Ny
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:09:18 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzkip-0002XV-B8
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:09:16 -0500
Received: by mail-pg1-x541.google.com with SMTP id h11so11665025pgl.0
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:09:13 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f8ff92c-9770-b69a-0857-2b85a87090f1@linaro.org>
Date: Fri, 1 Mar 2019 08:09:08 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/32] s390x/tcg: Utilities for vector
 instruction helpers
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

On 3/1/19 3:53 AM, David Hildenbrand wrote:
> +#ifndef S390X_VEC_H
> +#define S390X_VEC_H
> +
> +typedef union S390Vector {
> +    uint64_t doubleword[2];
> +    uint32_t word[4];
> +    uint16_t halfword[8];
> +    uint8_t byte[16];
> +} S390Vector;
> +
> +uint8_t s390_vec_read_element8(const S390Vector *v, uint8_t enr);
> +uint16_t s390_vec_read_element16(const S390Vector *v, uint8_t enr);
> +uint32_t s390_vec_read_element32(const S390Vector *v, uint8_t enr);
> +uint64_t s390_vec_read_element64(const S390Vector *v, uint8_t enr);
> +void s390_vec_write_element8(S390Vector *v, uint8_t enr, uint8_t data);
> +void s390_vec_write_element16(S390Vector *v, uint8_t enr, uint16_t data);
> +void s390_vec_write_element32(S390Vector *v, uint8_t enr, uint32_t data);
> +void s390_vec_write_element64(S390Vector *v, uint8_t enr, uint64_t data);
> +

These, I think, should be static inline.  Certainly I think they're too small
to warrant a real call across modules, as you appear to be preparing for...

I'm not sure why else they're being declared outside vec_helper.c?


r~
