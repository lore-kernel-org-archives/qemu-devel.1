Received: from eggs.gnu.org ([2001:4830:134:3::10]:54771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBFyo-0006lj-P4
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBFyk-0005JH-PP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:40:46 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:33871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fBFyk-0005JD-JH
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:40:42 -0400
Received: by mail-pg0-x236.google.com with SMTP id p10so12830040pgn.1
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 01:40:42 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-6-richard.henderson@linaro.org>
	<a361df8b-953e-bb2f-75d8-8729f3e27eb7@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7d65ba1f-8c1f-6e99-9963-b4724680dca9@linaro.org>
Date: Tue, 24 Apr 2018 22:40:37 -1000
MIME-Version: 1.0
In-Reply-To: <a361df8b-953e-bb2f-75d8-8729f3e27eb7@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/9] target/arm: Implement FMOV (general)
 for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

On 04/24/2018 03:31 PM, Philippe Mathieu-Daudé wrote:
>> @@ -5431,10 +5446,15 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
>>          case 0xa: /* 64 bit */
>>          case 0xd: /* 64 bit to top half of quad */
>>              break;
>> +        case 0x6: /* 16-bit */
>> +            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
>> +                break;
>> +            }
>> +            /* fallthru */
>>          default:
>>              /* all other sf/type/rmode combinations are invalid */
>>              unallocated_encoding(s);
>> -            break;
>> +            return;
> 
> Agreed with this change, however shouldn't this be in a separate patch?

Why?


r~
