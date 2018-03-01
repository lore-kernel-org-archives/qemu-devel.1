Received: from eggs.gnu.org ([2001:4830:134:3::10]:55957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOwe-0004tM-1U
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOwd-0005jT-5m
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:12:27 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:44582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erOwd-0005iT-0a
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:12:27 -0500
Received: by mail-ot0-x244.google.com with SMTP id 79so5649391oth.11
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 06:12:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_o86z59NmYJhbdLbZnvZ0kdAuSRqLrwrVkysS_+EDqqQ@mail.gmail.com>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-17-richard.henderson@linaro.org>
	<CAFEAcA_o86z59NmYJhbdLbZnvZ0kdAuSRqLrwrVkysS_+EDqqQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 14:12:05 +0000
Message-ID: <CAFEAcA92Kt_w9_x1imqgmoQi7D_jT-ujqh2FexB53iRhZK4VAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 16/16] target/arm: Enable
 ARM_FEATURE_V8_FCMA
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

On 1 March 2018 at 13:20, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 28 February 2018 at 19:31, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Enable it for the "any" CPU used by *-linux-user.

> We should be setting some hwcap bits in linux-user for these new feature
> bits (and RDM), right?

Oh, you did that back in the patch where you added the feature bit.
Sorry, I'm clearly skimming these patches a little too quickly.

-- PMM
