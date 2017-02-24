Received: from eggs.gnu.org ([2001:4830:134:3::10]:50343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chKRG-0007NF-V4
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chKRG-0003A5-59
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:54 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chKRF-00039d-U2
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:54 -0500
Received: by mail-wr0-x22a.google.com with SMTP id 89so18256185wrr.3
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 10:17:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <619a06f3-1b9a-ba3e-2469-76e57bf838f0@vivier.eu>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
	<619a06f3-1b9a-ba3e-2469-76e57bf838f0@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 18:17:32 +0000
Message-ID: <CAFEAcA_zHEr2QYi7FkeRhHiT2rCvU3+3JSOAHgWOFiG_zHibgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH risu 0/9] risu: refactor and reduce
 CPU-specific code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 24 February 2017 at 18:15, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 24/02/2017 =C3=A0 18:35, Peter Maydell a =C3=A9crit :
>> My motivation for all this, incidentally, is that I wanted to have
>> a go at resurrecting the x86 backend as a test case for how we
>> should support variable-length instruction sets.
>
> I think m68k is needing that too.

Yep; but I don't have an m68k to hand, whereas I do have
x86-64 ;-)

thanks
-- PMM
