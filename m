Received: from eggs.gnu.org ([2001:4830:134:3::10]:50290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW1So-0002G6-1R
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW1Sn-0005Ey-9M
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:21:02 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW1Sn-0005Ed-2z
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:21:01 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k67so67961573wrc.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:21:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87pod3umy6.fsf@linaro.org>
References: <20170713141928.25419-1-alex.bennee@linaro.org>
	<20170713141928.25419-6-alex.bennee@linaro.org>
	<CAFEAcA8o4rU7BXR_+VEQhAXBSzJ7usAnkYXDb=CEqQ=duuirqA@mail.gmail.com>
	<87pod3umy6.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 15:20:39 +0100
Message-ID: <CAFEAcA8s5Xm8AO8L2=Rs_CQNYqzgArq7ahmjK0sNjy_bGCObHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 5/6] target/arm: use gen_goto_tb for ISB
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 14 July 2017 at 15:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> Why do we need to clear the low bit of s->pc for ISB?
>> s->pc is the actual PC, not the "PC and low bit indicates
>> Thumb mode" form that jump addresses have.
>
> It's what gen_lookup_tb does to it's PC before the calculated jump. If
> it can never happen I can get rid of it.

Hmm, I think that it's unnecessary, but since we were doing this before
I guess better to make cleaning it up be a separate patch.

thanks
-- PMM
