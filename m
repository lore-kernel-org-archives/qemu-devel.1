Received: from eggs.gnu.org ([2001:4830:134:3::10]:53970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fYuNw-0002hp-M6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fYuNv-0005da-Os
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:28:28 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:40389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fYuNv-0005b2-FQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:28:27 -0400
Received: by mail-lj1-x22b.google.com with SMTP id a6-v6so7478750ljj.7
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:28:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98fthhG_q0skQcWzhLMFYVPQpc=jAJOL+8CrrEpGLvQw@mail.gmail.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
	<CAFEAcA8rRRTYhS-JNBTeJfZDydYEdNpab_TPieyrKcV5cad0SA@mail.gmail.com>
	<23cb43c1-15aa-187b-3711-da7847396a01@amsat.org>
	<CAFEAcA83eO5DZawurRmLtuV4jBL8s23EHaUCFLS7_c9mGHEdxA@mail.gmail.com>
	<CAKmqyKMB-KeukYvsSfvj+Sv6_eQoTP+1_iztuMuy-yJqVzP1Gw@mail.gmail.com>
	<CAFEAcA98fthhG_q0skQcWzhLMFYVPQpc=jAJOL+8CrrEpGLvQw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 Jun 2018 07:27:55 -0700
Message-ID: <CAKmqyKP8Qu3+k=3Wn8X20+qM4JR_HPDhtRLjY-tufGcsopG_fQ@mail.gmail.com>
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

On Fri, Jun 29, 2018 at 7:21 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 29 June 2018 at 15:13, Alistair Francis <alistair23@gmail.com> wrote:
>> Can you import it manually? The armour export is below:
>
> Aha. I tried that, which didn't work either, which prompted
> me to try --verbose, which says:
>
> e104462:xenial:qemu-for-merges$ gpg --verbose --import /tmp/alistair.gpg
> gpg: armour header: Version: GnuPG v2
> gpg: can't handle public key algorithm 19
> gpg: pub     0E/0xE48E3BC2C123ED93 2017-12-15  Alistair Francis
> <alistair@alistair23.me>
> gpg: key 0xE48E3BC2C123ED93: unsupported public key algorithm on user
> ID "Alistair Francis <alistair@alistair23.me>"
> gpg: key 0xE48E3BC2C123ED93: unsupported public key algorithm on user
> ID "Alistair Francis <alistair23@gmail.com>"
> gpg: key 0xE48E3BC2C123ED93: unsupported public key algorithm
> gpg: key 0xE48E3BC2C123ED93: unsupported public key algorithm
> gpg: key 0xE48E3BC2C123ED93: unsupported public key algorithm
> gpg: key 0xE48E3BC2C123ED93: skipped user ID "Alistair Francis
> <alistair@alistair23.me>"
> gpg: key 0xE48E3BC2C123ED93: skipped user ID "Alistair Francis
> <alistair23@gmail.com>"
> gpg: key 0xE48E3BC2C123ED93: skipped subkey
> gpg: key 0xE48E3BC2C123ED93: skipped subkey
> gpg: key 0xE48E3BC2C123ED93: skipped subkey
> gpg: key 0xE48E3BC2C123ED93: no valid user IDs
> gpg: this may be caused by a missing self-signature
> gpg: Total number processed: 1
> gpg:           w/o user IDs: 1
>
> So the problem is that your key is using some algorithm
> that's too newfangled for my gpg to cope with...

Hmm... I do use gpg2, but it's just an RSA2048 key.

Is it possible to update your GPG?

Otherwise I can try generating a new key just for QEMU PRs.

Alistair

>
> thanks
> -- PMM
