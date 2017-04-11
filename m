Received: from eggs.gnu.org ([2001:4830:134:3::10]:34315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxua4-0006i9-8t
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxua3-00036k-F0
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:07:32 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxua3-00035D-8l
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:07:31 -0400
Received: by mail-wr0-x232.google.com with SMTP id z109so27423280wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 05:07:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJKOXPecitJXUxfzPut-nt+TzMEfncNpHHshCbAeZ-4pe_S4Xw@mail.gmail.com>
References: <20170318192509.15499-1-krzk@kernel.org>
	<CAFEAcA8WGoa=DYXRH4MHfnHmUR_5-xERdmcuqrsk=bmS7GBCmg@mail.gmail.com>
	<20170404134402.GA4196@kozik-book>
	<CAFEAcA9UGEVVUfL3--goP4mVU+ezegWPcoka41XM8d_E2yyJkQ@mail.gmail.com>
	<20170404143121.GA6421@kozik-book>
	<CAFEAcA_DaW_DdcYweHPGpJrMNMP+Sd-Bw6W_OM7tCF5cMyh4aQ@mail.gmail.com>
	<CAJKOXPecitJXUxfzPut-nt+TzMEfncNpHHshCbAeZ-4pe_S4Xw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 13:07:09 +0100
Message-ID: <CAFEAcA-FTFQMa_O24R7BWSorroCXrfQkDtqjrmty88A0fiLLHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc: Add Exynos4210 Pseudo Random
 Number Generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 11 April 2017 at 13:02, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> But first I need to setup proper booting image + rootfs instead of
> only initramfs. The sdhci node is failing (missing regulators or
> capabilities) so essentially there is no storage now.
>
> How do you access any kind of disk image in case of other boards?

Depends on the board, some of them have SD controllers, a few
have PCI controllers that can take a virtio or scsi controller.

thanks
-- PMM
