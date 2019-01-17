Received: from eggs.gnu.org ([209.51.188.92]:49142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjvBv-0000ke-G5
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 19:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjvBp-0004dR-Is
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 19:05:47 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjvBl-0004P4-OW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 19:05:42 -0500
Received: by mail-pf1-x444.google.com with SMTP id b85so3863115pfc.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 16:05:27 -0800 (PST)
References: <20181226034254.17842-1-richard.henderson@linaro.org>
	<20190116235009.tl4gcv53e62npecl@function>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e31f52fc-e17a-859f-10be-1760aa1a58d7@linaro.org>
Date: Thu, 17 Jan 2019 11:05:20 +1100
MIME-Version: 1.0
In-Reply-To: <20190116235009.tl4gcv53e62npecl@function>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: Use lduw_be_p in slirp_input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, jan.kiszka@siemens.com

On 1/17/19 10:50 AM, Samuel Thibault wrote:
> Hello,
> 
> Richard Henderson, le mer. 26 déc. 2018 14:42:54 +1100, a ecrit:
>> The pointer may be unaligned, so we must use our routines for that.
>> At the same time, we might as well use the big-endian version
>> instead of ntohs.
>>
>> This fixes sparc64 host SIGBUS during pxe boot.
> 
> I'm not at ease with applying this, when Marc-André is trying to make
> slirp an external library...  I'd rather apply the change below, could
> somebody review it?

Fair.

> -    proto = ntohs(*(uint16_t *)(pkt + 12));
> +    proto = (((uint16_t) pkt[12]) << 8) + pkt[13];

This works for me too, though I note unnecessary parenthesis around the cast.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
