Received: from eggs.gnu.org ([2001:4830:134:3::10]:49477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHDwy-0004q6-Cq
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHDwv-000177-8y
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:06:44 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHDwv-00016k-4y
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:06:41 -0500
Received: by mail-vk0-f44.google.com with SMTP id w194so39819959vkw.2
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:06:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161202054617.6749-4-alastair@au1.ibm.com>
References: <20161202054617.6749-1-alastair@au1.ibm.com>
	<20161202054617.6749-4-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 18:05:20 +0000
Message-ID: <CAFEAcA8YtWWOAgAcNGVrMSWW7p9RN-X9Yhf-OBpH3bEARkH=kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 3/7] hw/i2c: Add a NULL check for i2c
 slave init callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

On 2 December 2016 at 05:46, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> Add a NULL check for i2c slave init callbacks, so that we no longer need to implement empty init functions.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  hw/arm/pxa2xx.c   | 7 -------
>  hw/arm/tosa.c     | 7 -------
>  hw/arm/z2.c       | 7 -------
>  hw/i2c/core.c     | 6 +++++-
>  hw/timer/ds1338.c | 6 ------
>  5 files changed, 5 insertions(+), 28 deletions(-)
>

Applied this patch to target-arm.next for 2.9.

thanks
-- PMM
