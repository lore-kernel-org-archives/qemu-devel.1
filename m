Received: from eggs.gnu.org ([2001:4830:134:3::10]:34804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDSWz-0001LT-2Z
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDSWy-0001qt-4l
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:29:08 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:41458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDSWx-0001qc-Vs
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:29:08 -0400
Received: by mail-oi0-x231.google.com with SMTP id 11-v6so9737354ois.8
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 03:29:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8f27190a-3875-2eea-4138-172e590f4eb2@gmail.com>
References: <1fa7369f-9c6d-73c6-77e1-7911a9538d82@gmail.com>
	<87vac7adz2.fsf@linaro.org>
	<8f27190a-3875-2eea-4138-172e590f4eb2@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 May 2018 11:28:46 +0100
Message-ID: <CAFEAcA-XVP-z2==XJk265KG8N-3ECVuZ3ubFuVO7O0_RxssBcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Translation block identification.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rafael Kioji <rafaelkioji@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 1 May 2018 at 11:20, Rafael Kioji <rafaelkioji@gmail.com> wrote:
> This logging flag prints what I want. But I really wanted is to get this
> info inside the QEMU source code. Why am I not able to lookup the symbols in
> the translator.c file the way I showed?

The -d in_asm logging is just using lookup_symbol() (eg for arm
I think it's in arm_tr_disas_log() that that particular logging
is done), so if it works when it's called by the existing QEMU code
but not in your modification then it sounds like there's an
error in your modification somewhere.

thanks
-- PMM
