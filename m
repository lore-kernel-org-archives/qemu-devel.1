Received: from eggs.gnu.org ([2001:4830:134:3::10]:37002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMt6P-0008JZ-Dm
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMt6O-0007FV-D8
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:12:57 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMt6O-0007F4-0s
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:12:56 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so10686889otr.10
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 03:12:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMaW0Ye5E_PMZXpnUpYZRGdwCBEOf9Qr_bzJpPR=-_p2A@mail.gmail.com>
References: <20181108134139.31666-1-peter.maydell@linaro.org>
	<CAKmqyKMaW0Ye5E_PMZXpnUpYZRGdwCBEOf9Qr_bzJpPR=-_p2A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Nov 2018 11:12:34 +0000
Message-ID: <CAFEAcA-tct9gOM-mShPXhaZvMK1o14K4dcK-QbNxR5r36_DM2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: list myself as maintainer for
 various Arm boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Rob Herring <robh@kernel.org>, Thomas Huth <thuth@redhat.com>, Patch Tracking <patches@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 13 November 2018 at 20:10, Alistair Francis <alistair23@gmail.com> wrote:
> These two and the Xilinx boards seem a little out of place in this
> patch. I agree they probably aren't maintained as well as they should
> be, but the patch talks about orphaned boards and these four all have
> active QEMU maintainers listed.

Yeah, I was planning to improve the commit message,
something along the lines of an extra para:

"The Xilinx boards are maintained, but patches to
them go via the target-arm tree, so add myself as a
maintainer there too."

Really this is because we're overloading "maintainer"
to mean both "this person cares about and is the
primary reviewer and yes/no decision for them" and
also "this person is responsible for getting the
patches into the tree". Perhaps we should instead
define a new letter tag for the latter ?

thanks
-- PMM
