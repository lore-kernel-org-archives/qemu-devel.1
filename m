Received: from eggs.gnu.org ([2001:4830:134:3::10]:34257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgBB2-0007fC-LJ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgBB0-0000JK-E1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:49:12 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgBB0-0000Io-5m
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:49:10 -0400
Received: by mail-oi0-x242.google.com with SMTP id d189-v6so15817896oib.6
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:49:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <221519ed-ca43-7c03-bb20-57c8e744e1d2@linaro.org>
References: <20180718200648.22529-1-richard.henderson@linaro.org>
	<87wotr4bpv.fsf@linaro.org>
	<221519ed-ca43-7c03-bb20-57c8e744e1d2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 16:48:48 +0100
Message-ID: <CAFEAcA-GdybEvs2FwFApOyKko55Uj=QWGB--ekmaDOcBNjss4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user/ppc: Implement swapcontext
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 19 July 2018 at 16:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 07/19/2018 06:05 AM, Alex Benn=C3=A9e wrote:
>> I'm confused by the lock_user_struct/unlock_user_struct which AFAICT are
>> basically access checks. Is there an implied locking I'm missing?
>
> I have no idea why those have that name.  There's no lock,
> just a validation of the underlying pages and a transform to
> the corresponding host address.

Mmm, it's unclear. It came in via 53a5960aadd542dd, and the
impression I get is that the idea was to try to decouple from
knowing that the guest memory layout is flat, as a preparation
for possible support for softmmu-in-usermode...

thanks
-- PMM
