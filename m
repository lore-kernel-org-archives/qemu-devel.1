Received: from eggs.gnu.org ([2001:4830:134:3::10]:58455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eD9sZ-00089i-35
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eD9sY-0006LL-B1
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:01:55 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:52495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eD9sY-0006JU-4V
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:01:54 -0500
Received: by mail-wm0-x22e.google.com with SMTP id t139so2967283wmt.1
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 06:01:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a1d39dc8-72e1-55a6-7c36-4bbe8b6142fa@ozlabs.ru>
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<96ded936-f9e3-c712-291e-fcb3d44bbe65@amsat.org>
	<20171108130102.GS12670@redhat.com>
	<fd7bb230-bbe3-ce3c-3026-d3d51544a14a@ozlabs.ru>
	<20171110104135.GB30685@redhat.com>
	<a1d39dc8-72e1-55a6-7c36-4bbe8b6142fa@ozlabs.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Nov 2017 14:01:32 +0000
Message-ID: <CAFEAcA-jsUSrcYknPrcF4CjEvkFfjaYYnHFL0G-0+k9vM3f8aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>

On 10 November 2017 at 13:46, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> And it will still be
> better than changing the $SRC_PATH when a user specifically asked not to do
> that by calling "./configure --source-path='.

I'm not terribly happy with the submodule stuff either, but
that configure rune is not making use of a documented
or supported feature. --source-path is for telling configure
where the source code is. Passing it an empty string should
probably be rejected as an error.

thanks
-- PMM
