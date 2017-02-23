Received: from eggs.gnu.org ([2001:4830:134:3::10]:47863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyNn-0002xE-4J
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyNm-0002fd-9Z
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:44:51 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgyNm-0002fL-2j
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:44:50 -0500
Received: by mail-wm0-x235.google.com with SMTP id v77so37856882wmv.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:44:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170222112338.25492-1-clement.deschamps@antfield.fr>
References: <20170222112338.25492-1-clement.deschamps@antfield.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 18:44:28 +0000
Message-ID: <CAFEAcA8=nouAmHZbs-VBabx=kkGzdWFNJ4kFJTh2B4Uemd9_Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 0/3] add sdhost and gpio controllers to
 the bcm2835 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Clement Deschamps <clement.deschamps@antfield.fr>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Baumann <andrew.baumann@microsoft.com>

On 22 February 2017 at 11:23, Clement Deschamps
<clement.deschamps@antfield.fr> wrote:
> This patches add the Arasan SDHost controller and the GPIO controller to the BCM2835/36 platforms.
>
> This patches have been tested with raspbian 2015-09-24 (which uses the SDHCI controller),
> and raspbian 2017-01-11 (which dynamically switches to the SDHost controller).
>
> Note: In order to properly boot the kernel, you will first need to apply the
> BCM2835 hardware RNG patch submitted recently.

Wow, that was fast. Are these patches entirely your own work or did
you start with something from Andrew's tree or elsewhere? (I'm wondering
if we need extra signed-off-by lines in the commit messages.)

thanks
-- PMM
