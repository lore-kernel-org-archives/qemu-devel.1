Received: from eggs.gnu.org ([2001:4830:134:3::10]:58052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEWrP-0002Np-3U
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEWrM-0006xm-1K
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:46:23 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:52115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eEWrL-0006xA-Pf
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:46:19 -0500
Received: by mail-wm0-x22b.google.com with SMTP id b189so13343379wmd.0
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 00:46:19 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-7-richard.henderson@linaro.org>
	<87shdi9l05.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8bb9454-bdbb-34ce-edb6-df31002fbb9a@linaro.org>
Date: Tue, 14 Nov 2017 09:46:15 +0100
MIME-Version: 1.0
In-Reply-To: <87shdi9l05.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 06/12] target/arm: Decode
 aa32 armv8.1 three same
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

On 11/13/2017 05:55 PM, Alex Bennée wrote:
>> +        case NEON_3R_VFM_VQRDMLSH:
>> +            if (!u) {
>> +                /* VFM, VFMS */
>> +                if ((5 & (1 << size)) == 0) {
>> +                    return 1;
>> +                }
>> +                break;
>> +            }
>> +            /* VQRDMLSH */
>> +            switch (size) {
>> +            case 1:
>> +                fn_gvec_ptr = gen_helper_gvec_qrdmlsh_s16;
>> +                break;
>> +            case 2:
>> +                fn_gvec_ptr = gen_helper_gvec_qrdmlsh_s32;
>> +                break;
>> +            default:
>> +                return 1;
>> +            }
>> +            goto do_vqrdmlx;
> Could we not take the opportunity to re-factor out the common bit rather
> than make this mega 

What, specifically, did you have in mind?


r~
