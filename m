Received: from eggs.gnu.org ([2001:4830:134:3::10]:48224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhmn-00036l-R0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFhmn-0001Jd-1F
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:06:13 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFhmm-0001JK-SU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:06:12 -0400
Received: by mail-wm0-x233.google.com with SMTP id b84so93207111wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 07:06:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 15:05:51 +0100
Message-ID: <CAFEAcA9mo3HgVxG3OGAcMQLa4iwsHKofQ8CA8mZik5J2fm6jgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 00/13] armv7m: Implement MPU
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 25 April 2017 at 13:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset implements support for the MPU in our v7M cores.
> Support is on the same level as that for the R profile MPU: it works,
> but regions smaller than 1K in size are not supported. It likely
> has some missing corner-case features.

> I wanted to get this patchset out to the list before I go off
> on my break; I will come back and follow up on review comments
> when I get back in June.

The patchset has had review for about half the patches, and
no this-needs-fixing comments on the others, so I propose to
put it into target-arm.next.

Let me know if anybody would prefer me to hold off so they
can review the remaining patches in the set (2, 3, 9, 11, 12, 13).

thanks
-- PMM
