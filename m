Received: from eggs.gnu.org ([2001:4830:134:3::10]:58167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqzKG-0005OQ-MD
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqzKF-0006Ne-MU
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:46:36 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqzKF-0006NZ-GA
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:46:35 -0400
Received: by mail-wr0-x232.google.com with SMTP id u1so9300697wra.2
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 02:46:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 09:46:13 +0000
Message-ID: <CAFEAcA8UYsjy6sBTGqk1Crd-0tWpF0WWukA03_GyNRaG95L07Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1675108] [NEW] Cocoa UI always crashes on
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1675108 <1675108@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 22 March 2017 at 17:26, Brendan Shanks <brendan@bslabs.net> wrote:
> Public bug reported:
>
> Commit 8bb93c6f99a42c2e0943bc904b283cd622d302c5 ("ui/console: ensure
> graphic updates don't race with TCG vCPUs") causes the graphic update to
> run on a non-main thread, which Cocoa is not happy with. It crashes
> immediately after startup.

Oops. Alex, we can't just run UI code on random threads like this.
Any ideas?

thanks
-- PMM
