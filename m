Received: from eggs.gnu.org ([2001:4830:134:3::10]:57027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck923-0000nu-W2
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck922-0006d3-W6
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:43:31 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ck922-0006cI-Pd
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:43:30 -0500
Received: by mail-wr0-x231.google.com with SMTP id u108so89254952wrb.3
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 04:43:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1703032154440.14293@zero.eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<7e582e5ca2aaa7b8b6c1f8a040562b099767ff81.1488504063.git.balaton@eik.bme.hu>
	<CAFEAcA8w9ox2KSSvky6aY3sHG=Xq=h7Wu2F_9UHRtQAKCPTrLg@mail.gmail.com>
	<alpine.BSF.2.20.1703032154440.14293@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Mar 2017 12:43:08 +0000
Message-ID: <CAFEAcA99umdWSiDkHjSP71cO=HhsjVoQUmFTeLONX9mdWt9aFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 04/13] sm501: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 3 March 2017 at 20:56, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Fri, 3 Mar 2017, Peter Maydell wrote:
>> Just noticed this. I think reporting the error upwards by
>> failing device realize is better than adjusting the value.
>> It's what we tend to do for other devices. Management tools
>> like libvirt prefer to get hard errors if there's a config
>> file error that means they misconfigure a device.
>
>
> Making this change would need rebasing the whole series again an fixing
> conflicts. Do you insist on this or can we live with this warning which is
> closer to the original behaviour of this device?

Yes, I think we need to correct this.

The original behaviour of this device was "only the embedded
device", where we know that the board won't pass us a wrong
memory size. You're adding new behaviour where the user
can specify the memory size (for the PCI device), so we
need to have that new behaviour be correct and follow
how we handle other devices.

thanks
-- PMM
