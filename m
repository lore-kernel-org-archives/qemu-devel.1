Received: from eggs.gnu.org ([2001:4830:134:3::10]:46973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhXE-0002Nb-8t
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhXD-0005VV-G5
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:23:36 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqhXD-0005VD-BQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:23:35 -0400
Received: by mail-oi0-x241.google.com with SMTP id q11-v6so14902173oic.12
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:23:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABoDooMuYMEC4TnP-geVmo4PVxcMsW3vv8b+m4+D0SbwrbOikA@mail.gmail.com>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-8-richard.henderson@linaro.org>
	<CAFEAcA8Pb+HNsndA=8KU0+bq5jirK_0JipLR7gdspb1LstthTQ@mail.gmail.com>
	<CABoDooMuYMEC4TnP-geVmo4PVxcMsW3vv8b+m4+D0SbwrbOikA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 17:23:14 +0100
Message-ID: <CAFEAcA-cmEeBam1PCp4q0W9ZzoshWwVPKDhzhkEZs6V+674g0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/20] target/arm: Fix is_a64 for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 17 August 2018 at 17:10, Laurent Desnogues
<laurent.desnogues@gmail.com> wrote:
> Hello,
>
> On Fri, Aug 17, 2018 at 6:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>> And again. I don't want to pepper the code with ifdefs if
>> we can do the right thing without them.
>
> FWIW I find it more readable with the ifdef's (here and in the
> previous patches) and I guess that helps the compiler too.

Hmm. I prefer to think of user-mode as a funny variant on
system emulation where we make the minimal changes required,
and mostly work just by having the CPU being in the state it
would be for system-emulation EL0 and not being able to get out
of it.

thanks
-- PMM
