Received: from eggs.gnu.org ([2001:4830:134:3::10]:42759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQccW-00012P-5v
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQccV-0000Kl-9E
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:16:28 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:35230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQccU-0000KM-Re
	for Qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:16:27 -0500
Received: by mail-ua0-x22c.google.com with SMTP id y9so135275466uae.2
	for <Qemu-devel@nongnu.org>; Mon, 09 Jan 2017 08:16:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 16:16:05 +0000
Message-ID: <CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] CMSIS SVD based peripheral definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developer <Qemu-devel@nongnu.org>

On 28 December 2016 at 18:49, Liviu Ionescu <ilg@livius.net> wrote:
> The latest release of GNU ARM Eclipse QEMU (2.8.0-20161227) introduced
> a new technology for implementing peripherals, based on standard
> CMSIS SVD definitions
> (http://www.keil.com/pack/doc/CMSIS/SVD/html/index.html).
>
> The SVD files are large XML files produced by the silicon vendors,
> and generally are considered the final hardware reference for
> the Cortex-M devices, so they are expected to provide the most
> accurate peripheral emulation.

This certainly seems like a good idea in principle, if there's
enough information in the SVD files to reliably create a
complete board model. The obvious issue that comes to mind
is licensing, though -- what licenses are the SVD files under,
and would those be compatible with QEMU's GPLv2 ?

thanks
-- PMM
