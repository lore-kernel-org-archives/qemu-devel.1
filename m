Received: from eggs.gnu.org ([2001:4830:134:3::10]:46458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5D2i-0004b6-BF
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5D2h-0005sa-7F
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:47:32 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:55557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5D2h-0005s6-1k
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:47:31 -0400
Received: by mail-wm0-x233.google.com with SMTP id u138so17419844wmu.4
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:47:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019151249.13663-8-clg@kaod.org>
References: <20171019151249.13663-1-clg@kaod.org>
	<20171019151249.13663-8-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 16:47:09 +0100
Message-ID: <CAFEAcA_rmP=Ou50kJrWSF-ZgJZERoJ0gkt2+iV_xNO_hLFq7fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 7/8] misc: add pca9552 LED blinker model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 October 2017 at 16:12, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Specs are available here :
>
>     https://www.nxp.com/docs/en/application-note/AN264.pdf
>
> This is a simple model supporting the basic registers for led and GPIO
> mode. The device also supports two blinking rates but not the model
> yet.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>
>  Changes since v3:
>
>  - introduced auto-increment support
>  - removed the buffer collecting bytes on the bus
>  - improved reset
>  - used extract32
>  - added a unit test
>
>  Changes since v2:
>
>  - removed comments on the I2C buffer size, but kept the array. I did
>    not want to rewrite the buffer handling
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
