Received: from eggs.gnu.org ([2001:4830:134:3::10]:37287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSuBJ-0000s6-V8
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSuBG-0001od-UP
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:02:38 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSuBG-0001o1-O8
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:02:34 -0400
Received: by mail-pf0-x22e.google.com with SMTP id y5-v6so444228pfn.4
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:02:34 -0700 (PDT)
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-7-richard.henderson@linaro.org>
	<CAFEAcA_z+UmmJcqzqtq7RiPnEZDLwpfESQbP4ajRZLFLsVKmqw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e84080f-f7aa-a029-bf83-ca001f1cde5c@linaro.org>
Date: Tue, 12 Jun 2018 15:02:26 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_z+UmmJcqzqtq7RiPnEZDLwpfESQbP4ajRZLFLsVKmqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3b 06/18] target/arm: Implement SVE
 conditionally broadcast/extract element
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 06/04/2018 06:46 AM, Peter Maydell wrote:
>> +    do_clast_scalar(s, a->esz, a->pg, a->rn, before, cpu_reg(s, a->rd));
> 
> Why do we use cpu_reg() again here rather than just using 'reg' ?

Fixed.


r~
