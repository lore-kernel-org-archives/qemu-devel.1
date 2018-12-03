Received: from eggs.gnu.org ([2001:4830:134:3::10]:56572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gToCG-0003f8-02
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gToCC-0001Tg-RK
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:23:35 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:34188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gToCC-0001RZ-Ec
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:23:32 -0500
Received: by mail-oi1-x22a.google.com with SMTP id h25so10877393oig.1
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 05:23:32 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-14-richard.henderson@linaro.org>
	<87y3963n7v.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df59c0c0-6943-4ed1-a1f9-86a744e741ae@linaro.org>
Date: Mon, 3 Dec 2018 07:23:27 -0600
MIME-Version: 1.0
In-Reply-To: <87y3963n7v.fsf@linaro.org>
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

On 12/3/18 4:43 AM, Alex Bennée wrote:
>>      case R_AARCH64_CONDBR19:
>> -        reloc_pc19(code_ptr, (tcg_insn_unit *)value);
>> -        break;
>> +        return reloc_pc19(code_ptr, (tcg_insn_unit *)value);
>>      default:
>>          tcg_abort();
>>      }
>> -    return true;
> 
> nit: the default leg could return false for the same effect

Would it be clearer changed to g_assert_not_reached()?
Because I'm not intending "unknown relocation" to have
the same effect as "out of range relocation".


r~
