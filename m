Received: from eggs.gnu.org ([2001:4830:134:3::10]:60421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYuit-000455-1I
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYuis-0003qx-41
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:50:07 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:36579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYuir-0003pX-V1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:50:06 -0400
Received: by mail-oi0-x235.google.com with SMTP id r16-v6so8170311oie.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:50:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP8Qu3+k=3Wn8X20+qM4JR_HPDhtRLjY-tufGcsopG_fQ@mail.gmail.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
	<CAFEAcA8rRRTYhS-JNBTeJfZDydYEdNpab_TPieyrKcV5cad0SA@mail.gmail.com>
	<23cb43c1-15aa-187b-3711-da7847396a01@amsat.org>
	<CAFEAcA83eO5DZawurRmLtuV4jBL8s23EHaUCFLS7_c9mGHEdxA@mail.gmail.com>
	<CAKmqyKMB-KeukYvsSfvj+Sv6_eQoTP+1_iztuMuy-yJqVzP1Gw@mail.gmail.com>
	<CAFEAcA98fthhG_q0skQcWzhLMFYVPQpc=jAJOL+8CrrEpGLvQw@mail.gmail.com>
	<CAKmqyKP8Qu3+k=3Wn8X20+qM4JR_HPDhtRLjY-tufGcsopG_fQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:49:44 +0100
Message-ID: <CAFEAcA-HqcKC8bgUPrN5ZJ1v9+7PtdMazEj9gOfbG-Em14ScCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>

On 29 June 2018 at 15:27, Alistair Francis <alistair23@gmail.com> wrote:
> On Fri, Jun 29, 2018 at 7:21 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> So the problem is that your key is using some algorithm
>> that's too newfangled for my gpg to cope with...
>
> Hmm... I do use gpg2, but it's just an RSA2048 key.

Philippe says it's ECDH NISTP-521...

> Is it possible to update your GPG?

I don't believe any gpg(1) supports that algorithm.
I'm not really keen on moving to gpg2 because I hear bad
things about it...

thanks
-- PMM
