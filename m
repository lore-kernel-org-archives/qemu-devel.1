Received: from eggs.gnu.org ([2001:4830:134:3::10]:34641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeV6L-0004vP-L2
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 19:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeV6H-00044i-By
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 19:09:09 -0500
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:46543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeV6H-00044P-55
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 19:09:05 -0500
Received: by mail-pf0-x233.google.com with SMTP id y5so4427245pff.13
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 16:09:05 -0800 (PST)
References: <CABLmASFzQz+=LD_RBn_PfPzY2JdMT71DM3F5jK9J=i2CmxOShQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9cc3c0d8-26f4-5626-e0f1-e449068eaac1@linaro.org>
Date: Wed, 24 Jan 2018 16:09:00 -0800
MIME-Version: 1.0
In-Reply-To: <CABLmASFzQz+=LD_RBn_PfPzY2JdMT71DM3F5jK9J=i2CmxOShQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Howard Spoelstra <hsp.cat7@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 01/24/2018 01:49 PM, Howard Spoelstra wrote:
> Hi,
> 
> I built qemu-system-ppc for OSX and Windows from
> https://github.com/stsquad/qemu/tree/softfloat-refactor-and-fp16-v3
> and noticed a considerable drop in floating point performance on both
> hosts.
> Running Mac OS 9.2 in OSX, using MacBench 3.0, the score for the
> floating point performance dropped from ~60 to ~42.
> 
> Recent tcg optimisations had improved processor and floating point
> performance considerably, but that gain seems to be more than lost for
> the floating point performance.
> 
> Any idea what is causing this?

Is this a 64-bit or a 32-bit build?

We made a conscious choice to share code and use all 64-bit operations, under
the assumption that x86_64 is the most common host.

Otherwise we have not really done extensive benchmarking.


r~
