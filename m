Received: from eggs.gnu.org ([2001:4830:134:3::10]:47991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1ctXZz-00068O-VL
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1ctXZv-0005uO-Em
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:45:22 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:33078
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1ctXZv-0005ts-82
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:45:19 -0400
References: <1490707129-12622-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA_kBUEXiKaiT=Y=83nSsoxW=Hjn_=DEFYs1s4OK5ctG-w@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <2338410b-03be-c38c-2e63-eda6c345bbe4@weilnetz.de>
Date: Thu, 30 Mar 2017 12:45:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_kBUEXiKaiT=Y=83nSsoxW=Hjn_=DEFYs1s4OK5ctG-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] configure: Don't claim
 'unsupported host OS' when better message available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

Am 30.03.2017 um 12:17 schrieb Peter Maydell:
> Oops, I just noticed I had a minor change here which I forgot
> to squash in before sending:
>
> -    error_exit "Unsupported host OS $targetos"
> +    error_exit "Unrecognized host OS $targetos"
>
> since this is the case of "we don't know what this is" rather
> than "we know what this is but we're planning to remove it".
>
> OK to squash that in when I apply this patch?
>
> thanks
> -- PMM


Yes, sure.

Thanks
Stefan
