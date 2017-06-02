Received: from eggs.gnu.org ([2001:4830:134:3::10]:40122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGiRf-00010l-4O
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGiRe-0001Nz-Cl
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:00:35 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGiRe-0001Nh-75
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:00:34 -0400
Received: by mail-wm0-x22e.google.com with SMTP id b84so17714479wmh.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 02:00:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c6041151-8552-6ab2-54ef-1489340e4766@amsat.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-10-git-send-email-peter.maydell@linaro.org>
	<c9954451-ad9b-2365-5ed7-bc4c29f40abe@amsat.org>
	<CAFEAcA8aAwM-_9h1L23kjmfoabvivYdbKcC5e6YEkMXyUfTt5w@mail.gmail.com>
	<c6041151-8552-6ab2-54ef-1489340e4766@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 10:00:12 +0100
Message-ID: <CAFEAcA9tVXuo6frOMvqRmq1dK5uuk6yBLRoeD15P9NCH0LCfQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/13] armv7m: Implement M
 profile default memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "patches@linaro.org" <patches@linaro.org>

On 2 June 2017 at 06:10, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> On 05/30/2017 12:11 PM, Peter Maydell wrote:
>> This is the arm of the if() that deals with R profile, and R profile's
>
>
> Oh I completely misunderstood that if() indeed. R and also A I suppose.

A profile is never PMSA -- arguably VMSA (MMU) vs PMSA (MPU)) is the defini=
ng
distinction between A profile and R profile cores.

thanks
-- PMM
