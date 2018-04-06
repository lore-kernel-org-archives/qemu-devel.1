Received: from eggs.gnu.org ([2001:4830:134:3::10]:45322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f4R1t-0006G5-0q
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f4R1n-0003lM-FG
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:03:45 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:54573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f4R1n-0003kK-9e
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:03:39 -0400
Received: by mail-wm0-x231.google.com with SMTP id r191so3370556wmg.4
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:03:39 -0700 (PDT)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-6-richard.henderson@linaro.org>
	<87y3i4d4jv.fsf@linaro.org>
	<abef9b59-9f7e-8871-7d36-67c7612457ed@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <abef9b59-9f7e-8871-7d36-67c7612457ed@linaro.org>
Date: Fri, 06 Apr 2018 14:03:36 +0100
Message-ID: <876054cwrb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 04/03/2018 07:26 PM, Alex Benn=C3=A9e wrote:
>> You don't use it yet but probably worth a:
>>
>> static inline int ffr_full_reg_offset(DisasContext *s)
>> {
>>     return pred_full_reg_offset(s, 16);
>> }
>>
>> here when you get to it to avoid the magic 16 appearing in the main code.
>
> Hum.  Most of the places that ffr is touched is in sve.decode.
> I could certainly enhance the grammar there to allow a symbol
> there instead of a number.
>
> But I don't think treating ffr differently from a regular pr
> register, as above, is a good idea.  At best I would use
>
>   pred_full_reg_offset(s, FFR_PRED_NUM)

That would a fine alternative ;-)

--
Alex Benn=C3=A9e
