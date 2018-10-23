Received: from eggs.gnu.org ([2001:4830:134:3::10]:33766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gExIO-0005Kx-5n
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 10:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gExAG-0002VY-3j
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:56:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gExAF-0002Uk-Sg
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:56:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id r10-v6so927174wrv.6
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 06:56:07 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-3-richard.henderson@linaro.org>
	<5e3ac38a-88df-c7dd-2f2e-72a17fa300e1@mail.uni-paderborn.de>
	<9a26b731-8a3d-5b3a-bad6-334501868894@linaro.org>
	<2cf86fe8-8eff-5d7a-312d-f631aacfc5f0@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c9e9ecf5-eb2f-8421-0cf7-e0d72892d357@linaro.org>
Date: Tue, 23 Oct 2018 14:56:04 +0100
MIME-Version: 1.0
In-Reply-To: <2cf86fe8-8eff-5d7a-312d-f631aacfc5f0@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] decodetree: Remove "insn" argument
 from trans_* expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 10/23/18 2:25 PM, Bastian Koppelmann wrote:
> Richard, can you pick up the first two patches together with the insn arg
> removal for openrisc and ARM, such that we don't break bisecting? I then squash
> the rest of the patches into my patch-set.

I've now pushed these two to a new branch off master:

  https://github.com/rth7680/qemu.git decodetree


r~
