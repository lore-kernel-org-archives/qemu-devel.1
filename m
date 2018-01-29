Received: from eggs.gnu.org ([2001:4830:134:3::10]:46260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egEsu-0005q9-FG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egEsp-0008SC-CX
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:28 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:44576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1egEsp-0008Rp-5U
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:14:23 -0500
Received: by mail-pf0-x241.google.com with SMTP id 17so4785245pfw.11
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 11:14:23 -0800 (PST)
References: <CABLmASFzQz+=LD_RBn_PfPzY2JdMT71DM3F5jK9J=i2CmxOShQ@mail.gmail.com>
	<87a7x26qlv.fsf@linaro.org> <20180128204151.GA3787@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <18d1aea7-3489-2f05-351e-4de745cb4760@linaro.org>
Date: Mon, 29 Jan 2018 11:14:19 -0800
MIME-Version: 1.0
In-Reply-To: <20180128204151.GA3787@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>

On 01/28/2018 12:41 PM, Emilio G. Cota wrote:
> On Thu, Jan 25, 2018 at 12:59:56 +0000, Alex Bennée wrote:
>> Howard Spoelstra <hsp.cat7@gmail.com> writes:
> (snip)
>>> Recent tcg optimisations had improved processor and floating point
>>> performance considerably, but that gain seems to be more than lost for
>>> the floating point performance.
>>>
>>> Any idea what is causing this?
>>
>> Well we expected a little degradation but it's a bit more than I
>> expected.
> 
> It's pretty bad (almost a 2X mean slowdown) for the three FP workloads
> in dbt-bench:

I have not yet tried dbt-bench, but on another test case I was able to recover
all of the performance by marking all of the helpers inline.  I'm somewhat
disappointed by the compiler here.


r~
