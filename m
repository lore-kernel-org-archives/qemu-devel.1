Received: from eggs.gnu.org ([2001:4830:134:3::10]:53246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dDB8j-0001Zx-DT
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dDB8i-0000at-I0
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:50:25 -0400
References: <20170428125632.5704-1-luc.michel@git.antfield.fr>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <57594c43-eed4-c7c2-2efd-05872dd67d5c@msgid.tls.msk.ru>
Date: Tue, 23 May 2017 17:50:18 +0300
MIME-Version: 1.0
In-Reply-To: <20170428125632.5704-1-luc.michel@git.antfield.fr>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/1] target/arm: add data cache
 invalidation cp15 instruction to cortex-r5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc MICHEL <luc.michel@git.antfield.fr>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

28.04.2017 15:56, Luc MICHEL wrote:
> This patch adds the cp15, CRn=15, opc1=0, CRm=5, opc2=0 coprocessor instruction
> to the cortex-r5. As stated in the TRM, this instruction invalidates all the
> data cache. This trivial patch implements it as NOP as cache operations are not
> implemented in QEMU.
> 
> The documentation is here:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0460d/Bgbdbdjc.html

Applied to -trivial, since no one else picked it up so far :)

Thanks,

/mjt
