Received: from eggs.gnu.org ([2001:4830:134:3::10]:50320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e75JO-0006IM-LF
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e75JK-0006ij-MU
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:56:30 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:48001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e75JK-0006iB-FB
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:56:26 -0400
Received: by mail-wr0-x229.google.com with SMTP id y39so21860978wrd.4
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 12:56:26 -0700 (PDT)
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-20-richard.henderson@linaro.org>
	<55d38c32-ada1-7a7a-0a60-980b3c0b8a7d@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f1d5674a-4d83-4b97-4f8c-dd040516feed@linaro.org>
Date: Tue, 24 Oct 2017 21:56:22 +0200
MIME-Version: 1.0
In-Reply-To: <55d38c32-ada1-7a7a-0a60-980b3c0b8a7d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 19/52] tcg: Remove TCGV_EQUAL*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com

On 10/24/2017 05:11 AM, Philippe Mathieu-Daudé wrote:
>>      /* If no temporary was used, be careful not to alias t1 and t0.  */
>> -        t0 = TCGV_EQUAL(t1, cpu_cc_src) ? cpu_tmp0 : reg;
>> +        t0 = t1 == cpu_cc_src ? cpu_tmp0 : reg;
> As I noticed in a previous patch, this expression is a bit easier/faster
> to read/review with parenthesis are used:
> 
>            t0 = (t1 == cpu_cc_src ? cpu_tmp0 : reg);

You're right.  And I normally write it this way myself, even though operator
precedence does not require it.

But this is a case of search-and-replace, and I didn't retouch such things.


r~
