Received: from eggs.gnu.org ([2001:4830:134:3::10]:41652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZyfc-0001uJ-BY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZyfb-00008p-Fw
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:42:52 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:44162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZyfb-00007Q-A3
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:42:51 -0500
Received: by mail-ot0-x230.google.com with SMTP id g59so4914441otg.11
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 04:42:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <833c4229-7a78-849f-c17a-bfbef4506458@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<CAFEAcA9Qnj0G03x72BFLAYmodeBMDB=t3pz4JxUj0HvrbhkuGA@mail.gmail.com>
	<f82e02e3-40dd-8e74-6fe5-3205cdd42758@linaro.org>
	<CAFEAcA9eNzA9Yar4SC5UKWzMij0ypyXKATRqU1pVx8UTf33u7Q@mail.gmail.com>
	<833c4229-7a78-849f-c17a-bfbef4506458@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 12:42:30 +0000
Message-ID: <CAFEAcA-Hr0DAJi7rggmRudDc0L+g35MZ_1doOjSJe4TiThb23A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 00/23] target/arm: decode generator and
 initial sve patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11 January 2018 at 19:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 01/11/2018 11:27 AM, Peter Maydell wrote:
>> tgt-arm-cplx ? I had a look at that but it seemed to be a different
>> set of patches to this lot.
>
> No, tgt-arm-sve-{1,2,3}.  All of them should build.

Thank you. I've now had a look at the generated code and
reviewed patch 1. I had a quick look through some of the
later patches, mostly to check how the use of the script
looks, but I don't intend to review them properly at this
point (unless you think I should).

PS: a quote which kept coming to mind while I was reading
this patchset:

  'Er, what does the Z mean?' said Zaphod.
  'Which one?'
  'Any one.'

thanks
-- PMM
