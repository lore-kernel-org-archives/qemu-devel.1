Received: from eggs.gnu.org ([2001:4830:134:3::10]:33660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmgRA-0001sE-57
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmgR9-0005pB-Bl
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:24:44 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmgR9-0005p3-4f
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:24:43 -0400
Received: by mail-oi0-x242.google.com with SMTP id 13-v6so22533462ois.1
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:24:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABoDooNeBaYo46FVii0vjT-K5QtTx+Bg34WETrJcLJpPRHoV6w@mail.gmail.com>
References: <20180805233258.31892-1-richard.henderson@linaro.org>
	<CABoDooNeBaYo46FVii0vjT-K5QtTx+Bg34WETrJcLJpPRHoV6w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 15:24:21 +0100
Message-ID: <CAFEAcA87q0+vmVM_VSw5q8e21fcoCX7zB49LrksDrokP=PA-fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/optimize: Do not skip default
 processing of dup_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 6 August 2018 at 06:29, Laurent Desnogues
<laurent.desnogues@gmail.com> wrote:
> Hello,
>
> On Mon, Aug 6, 2018 at 1:32 AM, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> If we do not opimize away dup_vec, we must mark its output as changed.
>>
>> Fixes: 170ba88f45b
>> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>

Applied to master for rc4, thanks.

-- PMM
