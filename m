Received: from eggs.gnu.org ([2001:4830:134:3::10]:38378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4G5w-0001PO-M5
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4G5v-0005s4-Nj
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:23:12 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:45980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f4G5v-0005rD-Gp
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:23:11 -0400
Received: by mail-pl0-x22a.google.com with SMTP id v18-v6so19670802ply.12
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 18:23:11 -0700 (PDT)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-6-richard.henderson@linaro.org>
	<87y3i4d4jv.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <abef9b59-9f7e-8871-7d36-67c7612457ed@linaro.org>
Date: Fri, 6 Apr 2018 11:23:03 +1000
MIME-Version: 1.0
In-Reply-To: <87y3i4d4jv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/67] target/arm: Implement SVE load
 vector/predicate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 04/03/2018 07:26 PM, Alex Bennée wrote:
> You don't use it yet but probably worth a:
> 
> static inline int ffr_full_reg_offset(DisasContext *s)
> {
>     return pred_full_reg_offset(s, 16);
> }
> 
> here when you get to it to avoid the magic 16 appearing in the main code.

Hum.  Most of the places that ffr is touched is in sve.decode.
I could certainly enhance the grammar there to allow a symbol
there instead of a number.

But I don't think treating ffr differently from a regular pr
register, as above, is a good idea.  At best I would use

  pred_full_reg_offset(s, FFR_PRED_NUM)

or something.


r~
