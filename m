Received: from eggs.gnu.org ([2001:4830:134:3::10]:56357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foCt4-00037g-K1
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foCt1-0003yb-Ew
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:15:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:45477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foCt0-0003y5-W3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:15:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id i26-v6so4942835pfo.12
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:15:46 -0700 (PDT)
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-13-richard.henderson@linaro.org>
	<87600ipote.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74b5fa66-8a2a-95e0-2317-57aac7c48d75@linaro.org>
Date: Fri, 10 Aug 2018 12:15:42 -0700
MIME-Version: 1.0
In-Reply-To: <87600ipote.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/20] target/arm: Rewrite
 helper_sve_ld1*_r using pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org

On 08/10/2018 02:13 AM, Alex Bennée wrote:
>> +    for (intptr_t reg_off = find_next_active(vg, 0, reg_max, esz);
> 
> Hmm this blew up CI complaining about c99-isms, but QEMU is supposed to
> be c99 compliant.
> 
>   https://travis-ci.org/stsquad/qemu/builds/414248994

Bah.  That's what I get for doing two things at once on
different projects with different standards.

On the other hand, would anyone seriously object to me
adding -std=gnu99 to the compile flags?  C99's 20th
birthday is coming up next year...


r~
