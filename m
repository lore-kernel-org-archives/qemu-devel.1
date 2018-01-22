Received: from eggs.gnu.org ([2001:4830:134:3::10]:42165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edeZF-0007ry-VY
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edeZC-0003zH-Ql
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:03:29 -0500
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:46588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edeZC-0003ye-KN
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:03:26 -0500
Received: by mail-pf0-x235.google.com with SMTP id y5so7397024pff.13
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:03:26 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-6-richard.henderson@linaro.org>
	<871siikvps.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ab9cd735-a22c-fc49-f4cc-e05a782b5971@linaro.org>
Date: Mon, 22 Jan 2018 08:03:22 -0800
MIME-Version: 1.0
In-Reply-To: <871siikvps.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/16] target/arm: Change the type of
 vfp.regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 01/22/2018 02:56 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> All direct users of this field want an integral value.  Drop all
>> of the extra casting between uint64_t and float64.
> 
> Did the extra casting ever generate superfluous code?

No, it's just ugly.


r~
