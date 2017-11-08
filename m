Received: from eggs.gnu.org ([2001:4830:134:3::10]:60636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCMdL-0003e4-5q
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCMdF-0001Ra-Ji
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:26:55 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:46570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eCMdF-0001QU-CU
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:26:49 -0500
Received: by mail-wm0-x233.google.com with SMTP id r68so9004869wmr.1
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 01:26:49 -0800 (PST)
References: <1510066898-3725-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce4114ab-c17d-9797-5892-dc5e130fc0d6@linaro.org>
Date: Wed, 8 Nov 2017 10:26:45 +0100
MIME-Version: 1.0
In-Reply-To: <1510066898-3725-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] target/arm: Report GICv3 sysregs
 present in ID registers if needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, patches@linaro.org

On 11/07/2017 04:01 PM, Peter Maydell wrote:
> The CPU ID registers ID_AA64PFR0_EL1, ID_PFR1_EL1 and ID_PFR1
> have a field for reporting presence of GICv3 system registers.
> We need to report this field correctly in order for Xen to
> work as a guest inside QEMU emulation. We mustn't incorrectly
> claim the sysregs exist when they don't, though, or Linux will
> crash.
> 
> Unfortunately the way we've designed the GICv3 emulation in QEMU
> puts the system registers as part of the GICv3 device, which
> may be created after the CPU proper has been realized. This
> means that we don't know at the point when we define the ID
> registers what the correct value is. Handle this by switching
> them to calling a function at runtime to read the value, where
> we can fill in the GIC field appropriately.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
