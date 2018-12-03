Received: from eggs.gnu.org ([2001:4830:134:3::10]:52397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTp0v-0003an-Ie
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTp0p-0005pP-HK
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:15:57 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTp0p-0005oS-1a
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:15:51 -0500
Received: by mail-wr1-x42a.google.com with SMTP id j10so12334511wru.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:15:50 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-14-richard.henderson@linaro.org>
	<87y3963n7v.fsf@linaro.org>
	<df59c0c0-6943-4ed1-a1f9-86a744e741ae@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <df59c0c0-6943-4ed1-a1f9-86a744e741ae@linaro.org>
Date: Mon, 03 Dec 2018 14:15:48 +0000
Message-ID: <87r2ey3dd7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/3/18 4:43 AM, Alex Benn=C3=A9e wrote:
>>>      case R_AARCH64_CONDBR19:
>>> -        reloc_pc19(code_ptr, (tcg_insn_unit *)value);
>>> -        break;
>>> +        return reloc_pc19(code_ptr, (tcg_insn_unit *)value);
>>>      default:
>>>          tcg_abort();
>>>      }
>>> -    return true;
>>
>> nit: the default leg could return false for the same effect
>
> Would it be clearer changed to g_assert_not_reached()?
> Because I'm not intending "unknown relocation" to have
> the same effect as "out of range relocation".

g_assert_not_reached would probably be better then.

Is there any particular reason tcg has tcg_abort(), is it just for the
slightly different report string?

>
>
> r~


--
Alex Benn=C3=A9e
