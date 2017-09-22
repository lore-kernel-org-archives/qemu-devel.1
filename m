Received: from eggs.gnu.org ([2001:4830:134:3::10]:60771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvRbF-0008GF-VN
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvRbF-0006GW-1v
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:18:49 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:46613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvRbE-0006FI-PN
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:18:48 -0400
Received: by mail-wm0-x22f.google.com with SMTP id m72so5751402wmc.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:18:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-18-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-18-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 18:18:26 +0100
Message-ID: <CAFEAcA8n+M1hA3SKVJr-pEEaB5hJ_aKS6UK_wJ1g46rmjmHpMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 17/20] target/arm: Implement SG
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 22 September 2017 at 16:00, Peter Maydell <peter.maydell@linaro.org> wrote:
> Implement the SG instruction, which we emulate 'by hand' in the
> exception handling code path.

I've just realised that this patch is correct as far as it goes
but it only implements the common path case for SG (where it is
in S&NSC memory and executed by a CPU in NS state). There is
also defined behaviour for:
 * SG in NS memory (behaves as a NOP)
 * SG in S memory and CPU already secure (clears IT bits and
   does nothing else)

Those can be implemented in translate.c in the usual way;
I'll put a patch for that in the next set (or in a respin
of this set).

thanks
-- PMM
