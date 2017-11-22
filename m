Received: from eggs.gnu.org ([2001:4830:134:3::10]:47857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHUpD-0002B5-Pn
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHUp8-0003ZC-RL
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:12:23 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:46052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHUp8-0003Yq-KR
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:12:18 -0500
Received: by mail-wm0-x232.google.com with SMTP id 9so10240929wme.4
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 05:12:18 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-8-richard.henderson@linaro.org>
	<87r2t29kje.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5753185a-0407-6d7e-d874-172e9726c3b9@linaro.org>
Date: Wed, 22 Nov 2017 14:12:14 +0100
MIME-Version: 1.0
In-Reply-To: <87r2t29kje.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 07/12] target/arm: Decode aa32 armv8.1
 two reg and a scalar
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

On 11/13/2017 06:05 PM, Alex Bennée wrote:
>> -                default: /* 14 and 15 are RESERVED */
>> +                default:
>>                      return 1;
> 
> I think this should now be g_assert_not_reached() as we decode the whole
> op space. That said it's tricky to follow in the mega function that
> extracts op with old-school shifts 5 different ways :-/

You're right.  Thanks.


r~
