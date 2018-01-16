Received: from eggs.gnu.org ([2001:4830:134:3::10]:47100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebZz7-0008SP-NV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebZz7-0008DO-1S
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:45:37 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:43042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ebZz6-0008D8-Pk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:45:36 -0500
Received: by mail-lf0-x241.google.com with SMTP id o89so15318168lfg.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 14:45:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--YgJ-=b6YmO8KWQgMcWbuBp7h2WJHDcuzddkk_xFcwg@mail.gmail.com>
References: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA8v1pmDLD6xz_5yysqyV+aG3EiSF1j9ahYC9f2XatF80Q@mail.gmail.com>
	<20180116144957.GA5516@toto>
	<CAFEAcA--YgJ-=b6YmO8KWQgMcWbuBp7h2WJHDcuzddkk_xFcwg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jan 2018 14:45:04 -0800
Message-ID: <CAKmqyKMAch5UUx+DDAzP9POP=d7J2AqJQ=Zy8qd8zH0E2TfQTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/8] Xilinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistai@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jan 16, 2018 at 6:54 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 16 January 2018 at 14:49, Edgar E. Iglesias
> <edgar.iglesias@xilinx.com> wrote:
>> This didn't show up on my clang testing, do you mind sharing configure line and clang version you use?
>>
>> @Alistair, it does seem like the call to microblaze_load_kernel is passing wrong arguments.
>> Can you have a look?
>
> exec '../../configure' '--cc=clang' '--cxx=clang++' '--enable-gtk'
> '--extra-cflags=-fsanitize=undefined  -fno-sanitize=shift-base
> -Werror' "$@"
>
> with clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
> on ubuntu xenial.

Ok, should be fixed in v5, just running though one more test then I'll
send the patches out.

Alistair

>
> thanks
> -- PMM
>
