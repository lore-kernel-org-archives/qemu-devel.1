Received: from eggs.gnu.org ([2001:4830:134:3::10]:37852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epOB5-0001xe-LI
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epOB1-00055X-H2
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:59:03 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:43293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epOB1-000559-BO
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:58:59 -0500
Received: by mail-pg0-x22f.google.com with SMTP id f6so3984456pgs.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:58:59 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eda535c7-e66e-fc00-5614-5a1be2ba80bb@linaro.org>
Date: Fri, 23 Feb 2018 16:58:55 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/31] Add ARMv8.2 half-precision
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

On 02/23/2018 07:36 AM, Alex Bennée wrote:
> Now that the softfloat re-factoring has been merged I re-based this
> directly from master. Alternatively you can grab the full tree from:
> 
>   https://github.com/stsquad/qemu/tree/arm-fp16-v3
> 
> I've tested with the following RISU test binaries:
> 
>   http://people.linaro.org/~alex.bennee/testcases/arm64.risu/testcases.armv8.2_hp.tar.xz
> 
> Which now includes insn_FP1SRC.risu.bin which tests the final patch in
> the series which wasn't being exercised by my previous set of tests.
> 
> I've dropped the fp16 patch to both avoid the bikesheding but also
> because I could achieve the same effect by running RISU with:
> 
>   -cpu cortex-a57
> 
> The changes are all relatively minor based on feedback. The details
> are as usual included in the commit messages bellow ---.

Unless I've missed something, that's the whole patch set reviewed.


r~
