Received: from eggs.gnu.org ([209.51.188.92]:58828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxIbc-0008WJ-UC
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxIbc-0005Y2-6h
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:43:40 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxIbb-00058V-Qh
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:43:40 -0500
Received: by mail-pg1-x543.google.com with SMTP id 196so1667722pgf.13
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 13:43:29 -0800 (PST)
References: <20190222204500.24434-1-alex.bennee@linaro.org>
	<20190222204500.24434-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4d4521cb-8ce9-661d-9491-e350b4a6320f@linaro.org>
Date: Fri, 22 Feb 2019 13:43:25 -0800
MIME-Version: 1.0
In-Reply-To: <20190222204500.24434-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 6/6] softfloat: Support
 float_round_to_odd more places
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>

On 2/22/19 12:45 PM, Alex Bennée wrote:
> @@ -3526,6 +3551,8 @@ static float32 roundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
>      case float_round_down:
>          roundIncrement = zSign ? 0x7f : 0;
>          break;
> +    case float_round_to_odd:
> +        roundIncrement = zSig & 0x80 ? 0 : 0x7f;
>      default:
>          abort();

I clearly missed a break here.

Since this didn't kill fp-test, are we missing a float128_to_float32 test?


r~
