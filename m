Received: from eggs.gnu.org ([2001:4830:134:3::10]:59283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTpGE-0004W0-BR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTpGB-00020H-N9
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:31:46 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTpGB-0001zD-FB
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:31:43 -0500
Received: by mail-oi1-x243.google.com with SMTP id m6so11022577oig.11
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:31:43 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-14-richard.henderson@linaro.org>
	<87y3963n7v.fsf@linaro.org>
	<df59c0c0-6943-4ed1-a1f9-86a744e741ae@linaro.org>
	<87r2ey3dd7.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <065727c2-37ff-a872-1e3f-4d73d92e40c4@linaro.org>
Date: Mon, 3 Dec 2018 08:31:39 -0600
MIME-Version: 1.0
In-Reply-To: <87r2ey3dd7.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 13/16] tcg/aarch64: Return false on
 failure from patch_reloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 12/3/18 8:15 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 12/3/18 4:43 AM, Alex Bennée wrote:
>>>>      case R_AARCH64_CONDBR19:
>>>> -        reloc_pc19(code_ptr, (tcg_insn_unit *)value);
>>>> -        break;
>>>> +        return reloc_pc19(code_ptr, (tcg_insn_unit *)value);
>>>>      default:
>>>>          tcg_abort();
>>>>      }
>>>> -    return true;
>>>
>>> nit: the default leg could return false for the same effect
>>
>> Would it be clearer changed to g_assert_not_reached()?
>> Because I'm not intending "unknown relocation" to have
>> the same effect as "out of range relocation".
> 
> g_assert_not_reached would probably be better then.
> 
> Is there any particular reason tcg has tcg_abort(), is it just for the
> slightly different report string?

It's just old, pre-dating a more concerted use of glib.


r~
