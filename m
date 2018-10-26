Received: from eggs.gnu.org ([2001:4830:134:3::10]:38350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFz7C-0002D8-FK
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFz7B-0001Ls-Cb
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:13:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFz7A-0001LT-Mu
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:13:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id 14so568479oth.2
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 03:13:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1540548409-22560-1-git-send-email-thuth@redhat.com>
References: <1540548409-22560-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Oct 2018 11:12:51 +0100
Message-ID: <CAFEAcA8EubWya8ey9VxhaCw4m2U=KA+i2C-R9P-p+P6oEBBLew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Deprecate the "collie" machine and
 Strongarm devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Guenter Roeck <linux@roeck-us.net>

On 26 October 2018 at 11:06, Thomas Huth <thuth@redhat.com> wrote:
> These files lack an entry in the MAINTAINERS file, and according to
> the initial commits, the board and devices are incomplete. Since there
> have hardly been any commits in the past to really improve them, we
> should consider to mark them as deprecated now.
>
> Thomas Huth (2):
>   hw/arm: Deprecate the "collie" board
>   arm: Deprecate the Strongarm sa1100 and sa1110 processors

Hi Guenter; there's a proposal here to deprecate (and eventually
remove) the 'collie' board (strongarm) from QEMU. Is that one of
the ones you're currently using in your automated testing of Linux
kernels on QEMU?

thanks
-- PMM
