Received: from eggs.gnu.org ([209.51.188.92]:59502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyJDG-0002IF-1A
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyJDF-0003SC-BG
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:34:41 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gyJDE-0003KN-Vp
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:34:41 -0500
Received: by mail-pl1-x644.google.com with SMTP id s1so4723614plp.9
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 08:34:28 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190225154204.26751-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1d0255c0-5b8d-2fca-d5e3-63b8f4b82d69@twiddle.net>
Date: Mon, 25 Feb 2019 08:34:24 -0800
MIME-Version: 1.0
In-Reply-To: <20190225154204.26751-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tcg: Implement tcg_gen_shri2_i64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On 2/25/19 7:42 AM, David Hildenbrand wrote:
> +void tcg_gen_shri2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah, int64_t count)

Actually, I now wonder if a better name might be tcg_gen_extract2_i64
(no other change to arguments, i.e. the "len" parameter that extract
has is fixed at 64).

Thoughts?


r~
