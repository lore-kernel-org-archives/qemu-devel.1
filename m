Received: from eggs.gnu.org ([2001:4830:134:3::10]:34274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZepH-0002dZ-Ef
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZepG-0005On-MA
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:31:31 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:34172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZepG-0005OG-GG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:31:30 -0500
Received: by mail-ot0-x230.google.com with SMTP id p16so2411523otf.1
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 07:31:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109060920-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
	<CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
	<20171222014258-mutt-send-email-mst@kernel.org>
	<CAFEAcA8eKTEh3zSOPNm1WgUujNOU+zcNSgBAE5G68QcObQd8sA@mail.gmail.com>
	<20180109060920-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 15:31:08 +0000
Message-ID: <CAFEAcA_Xhm45N5U8aWZv=geVQMShv13FOEodS7HvPTz3fa9-+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>, QEMU Developers <qemu-devel@nongnu.org>

On 9 January 2018 at 04:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> So it's an existing bug exposed by the test.
> I've reverted the test for now but I didn't rebase
> as there are downstream trees based on this pull req.

Hi -- I'm afraid this seems to have conflicts with the sparc
pullreq. I tried the simple textual merge resolution for
hw/pci-host/apb.c, but that then fails to compile.
Can you fix up and resend, please?

thanks
-- PMM
