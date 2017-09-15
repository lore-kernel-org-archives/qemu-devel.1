Received: from eggs.gnu.org ([2001:4830:134:3::10]:47456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dspMm-0007eg-HA
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dspM2-0003vx-7S
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:05:04 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:43510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dspM1-0003u0-UW
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:04:18 -0400
Received: by mail-wm0-x231.google.com with SMTP id a137so2489015wma.0
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 05:04:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170915114001.GG13610@redhat.com>
References: <20170915090253.12201-1-famz@redhat.com>
	<CAFEAcA_b71j3v5Ag7uSTPBgUT2_Qej+KJxH57cKV+6QdRgCw9A@mail.gmail.com>
	<20170915114001.GG13610@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2017 13:03:54 +0100
Message-ID: <CAFEAcA9Vf8pvQ07+HNnRHiTv=N7m6LZRKUQdqziDiPX6=uEy_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/38] Test and build patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15 September 2017 at 12:40, Daniel P. Berrange <berrange@redhat.com> wrote:
> IIUC, the public part of the key gets exposed to the guest images via
> cloud-init metadata. During boot the guest read this metadata and add
> the public key to authorized_keys. The private key is used by the test
> suite on the host so that it can now login to the guests.
>
> So the risk here is that if these guests were exposed to the LAN in any
> way, someone could grab our private key and login to these guests.
>
> What saves us is that the VMs are run with user mode slirp networking
> so AFAICT, aren't exposed to the LAN.

If I'm reading the right bit of the script we run QEMU with a
hostfwd specification using 0.0.0.0 as the host part -- doesn't
that listen on all interfaces including the LAN ones?

thanks
-- PMM
