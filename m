Received: from eggs.gnu.org ([2001:4830:134:3::10]:34977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDwUS-0000tY-SE
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDwUO-000574-SB
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:28:32 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:40320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDwUO-00056j-Hr
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:28:28 -0400
Received: by mail-pf0-x22d.google.com with SMTP id f189so12496754pfa.7
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 11:28:28 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-9-richard.henderson@linaro.org>
	<87muxjaasd.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2749d2a0-7856-8972-3b73-e6305bab97a7@linaro.org>
Date: Wed, 2 May 2018 11:28:24 -0700
MIME-Version: 1.0
In-Reply-To: <87muxjaasd.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Implement FP
 data-processing (2 source) for fp16
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

On 05/01/2018 04:13 AM, Alex Bennée wrote:
> If we are going to the trouble of adding a read_fp_hreg() we might as
> well do the same for the write case. Then we can convert the various:
> 
>   read_vec_element_i32(s, tcg_vm, rm, 0, MO_16);
> 
> that we used before.

Ok, I've split these new functions into two new patches.


r~
