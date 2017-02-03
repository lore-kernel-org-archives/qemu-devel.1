Received: from eggs.gnu.org ([2001:4830:134:3::10]:50949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdyF-00056X-0Q
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdyE-0008Al-7j
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:32:11 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZdyE-00089u-2K
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:32:10 -0500
Received: by mail-wm0-x22e.google.com with SMTP id c85so29121116wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 05:32:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485875745-27741-6-git-send-email-wei@redhat.com>
References: <1485875745-27741-1-git-send-email-wei@redhat.com>
	<1485875745-27741-6-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 13:31:48 +0000
Message-ID: <CAFEAcA_6u1wA1Fdyozor4FLwsb73PHocXOacBc-zxwmB8NVD2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V2 5/5] target-arm: Enable vPMU support
 under TCG mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 31 January 2017 at 15:15, Wei Huang <wei@redhat.com> wrote:
> This patch contains several fixes to enable vPMU under TCG mode. It
> first removes the checking of kvm_enabled() while unsetting
> ARM_FEATURE_PMU. With it, the .pmu option can be used to turn on/off vPMU
> under TCG mode. Secondly the PMU node of DT table is now created under TCG.
> The last fix is to disable the masking of PMUver field of ID_AA64DFR0_EL1.
>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
