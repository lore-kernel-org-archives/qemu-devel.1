Received: from eggs.gnu.org ([2001:4830:134:3::10]:59640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1f3HEA-0006Cj-37
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1f3HE9-0004Eu-82
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:23:38 -0400
References: <20180402205654.14572-1-andrew.smirnov@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <02108999-891a-39a9-528c-04c6c5054e3c@arm.com>
Date: Tue, 3 Apr 2018 09:23:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180402205654.14572-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Allow manually specified /psci node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi Andrey,

On 02/04/18 21:56, Andrey Smirnov wrote:
> Change the code to avoid exiting QEMU if user provided DTB contains
> manually specified /psci node and skip any /psci related fixups
> instead.
> 
> Fixes: 4cbca7d9b4 ("hw/arm: Move virt's PSCI DT fixup code to
> arm/boot.c")
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Mark:
> 
> Sorry about the inconvenience, here's the fix (hopefully) to the
> prolem you reported in [1]. Let me know if skipping all PSCI related
> DTB fixup if /psic node is present is not the behaviour you had in
> mind for your suggested fix.

Yes, this looks pretty similar to the hack I implemented locally.

Feel free to add:

Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
