Received: from eggs.gnu.org ([2001:4830:134:3::10]:58014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eel0Z-0007nR-RW
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eel0Z-00009J-0B
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:08:15 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:39858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eel0Y-00008m-Ru
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:08:14 -0500
Received: by mail-ot0-x22b.google.com with SMTP id d9so7310146oth.6
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:08:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5FD1490A-41F7-4200-AB5C-3802358E1362@gmail.com>
References: <151274735709.11243.12332071284435970530.malonedeb@soybean.canonical.com>
	<151686682161.4861.8851702267220024380.malone@wampee.canonical.com>
	<F19A160D-99BC-4170-B544-8BAFFC23FE83@gmail.com>
	<CAFEAcA9vJ7A+J2OSPNsfyT575p+heE5o_++T-Jtp6S3dyG3NTQ@mail.gmail.com>
	<5FD1490A-41F7-4200-AB5C-3802358E1362@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 17:07:53 +0000
Message-ID: <CAFEAcA-+2pd0-y0MaCY2tgY4cb4RG+-d1CxieuCm46B1C46bzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1737194] Re: Windows NT 4.0 fails to boot
 from qcow2 installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1737194 <1737194@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 January 2018 at 16:43, John Arbuckle <programmingkidx@gmail.com> wrote:
>> On Jan 25, 2018, at 11:16 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> If you configure with --disable-tools does it manage to build,
>> or does it just go on to fail to link the main QEMU binary
>> with the same error?

> It still fails to build:

That's a shame. Thanks for testing. I guess there was a bug that
we fixed at some point but figuring out what the bug fix was and
backporting it to the commits to be tested is probably too much
effort to be worthwhile.

-- PMM
