Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fYumC-0006vj-Q0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fYumB-0004RQ-Sm
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:32 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:36749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fYumB-0004Ng-Jw
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:31 -0400
Received: by mail-lj1-x22b.google.com with SMTP id o26-v6so7539222ljg.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:53:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-HqcKC8bgUPrN5ZJ1v9+7PtdMazEj9gOfbG-Em14ScCA@mail.gmail.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
	<CAFEAcA8rRRTYhS-JNBTeJfZDydYEdNpab_TPieyrKcV5cad0SA@mail.gmail.com>
	<23cb43c1-15aa-187b-3711-da7847396a01@amsat.org>
	<CAFEAcA83eO5DZawurRmLtuV4jBL8s23EHaUCFLS7_c9mGHEdxA@mail.gmail.com>
	<CAKmqyKMB-KeukYvsSfvj+Sv6_eQoTP+1_iztuMuy-yJqVzP1Gw@mail.gmail.com>
	<CAFEAcA98fthhG_q0skQcWzhLMFYVPQpc=jAJOL+8CrrEpGLvQw@mail.gmail.com>
	<CAKmqyKP8Qu3+k=3Wn8X20+qM4JR_HPDhtRLjY-tufGcsopG_fQ@mail.gmail.com>
	<CAFEAcA-HqcKC8bgUPrN5ZJ1v9+7PtdMazEj9gOfbG-Em14ScCA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 Jun 2018 07:52:59 -0700
Message-ID: <CAKmqyKPy2=9QZ=Y7awAqnDMXSNTc3+bA+D4X7KxDO6Ge922MYA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>

On Fri, Jun 29, 2018 at 7:49 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 29 June 2018 at 15:27, Alistair Francis <alistair23@gmail.com> wrote:
>> On Fri, Jun 29, 2018 at 7:21 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> So the problem is that your key is using some algorithm
>>> that's too newfangled for my gpg to cope with...
>>
>> Hmm... I do use gpg2, but it's just an RSA2048 key.
>
> Philippe says it's ECDH NISTP-521...
>
>> Is it possible to update your GPG?
>
> I don't believe any gpg(1) supports that algorithm.
> I'm not really keen on moving to gpg2 because I hear bad
> things about it...

Ok, I'll generate a new non-ECC key today and send a new PR.

Alistair

>
> thanks
> -- PMM
