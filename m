Received: from eggs.gnu.org ([2001:4830:134:3::10]:37660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlAV-00020O-KO
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlAT-0000vk-Dj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:57:27 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSlAS-0000vC-RI
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:57:25 -0500
Received: by mail-ot1-x344.google.com with SMTP id a11so5481992otr.10
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:57:24 -0800 (PST)
MIME-Version: 1.0
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-8-git-send-email-peng.hao2@zte.com.cn>
	<CAFEAcA83C_Eic3K4yY5bGeEKJpY2uf26diFtDJ5r+W71jcX2DQ@mail.gmail.com>
In-Reply-To: <CAFEAcA83C_Eic3K4yY5bGeEKJpY2uf26diFtDJ5r+W71jcX2DQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:57:13 +0000
Message-ID: <CAFEAcA8nfp0ueLMJHhgRyf+mqG1QbakjKJiqSnLF-MFkjkDhZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V10 7/9] hw/misc/pvpanic: preparing for
 adding configure interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Fri, 30 Nov 2018 at 15:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> I suspect the reason you've done this is that you're
> trying to get "-device pvpanic" to work on the command
> line. I recommend not trying to get that to work.
> MMIO devices are not pluggable devices, and -device
> is not expected to work with them.

If you do want a pluggable pvpanic device for the virt
board then you should implement it as a PCI device,
incidentally.

thanks
-- PMM
