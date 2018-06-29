Received: from eggs.gnu.org ([2001:4830:134:3::10]:54994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYuQv-0005An-O1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYuQs-0002js-FI
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:31:33 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:40464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYuQs-0002j7-99
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:31:30 -0400
Received: by mail-qk0-x229.google.com with SMTP id b129-v6so5006008qke.7
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:31:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
	<CAFEAcA8rRRTYhS-JNBTeJfZDydYEdNpab_TPieyrKcV5cad0SA@mail.gmail.com>
	<23cb43c1-15aa-187b-3711-da7847396a01@amsat.org>
	<CAFEAcA83eO5DZawurRmLtuV4jBL8s23EHaUCFLS7_c9mGHEdxA@mail.gmail.com>
	<CAKmqyKMB-KeukYvsSfvj+Sv6_eQoTP+1_iztuMuy-yJqVzP1Gw@mail.gmail.com>
	<CAFEAcA98fthhG_q0skQcWzhLMFYVPQpc=jAJOL+8CrrEpGLvQw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3af3b510-61a5-abaa-8cd9-ee4e21ba7963@amsat.org>
Date: Fri, 29 Jun 2018 11:31:23 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98fthhG_q0skQcWzhLMFYVPQpc=jAJOL+8CrrEpGLvQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>

On 06/29/2018 11:21 AM, Peter Maydell wrote:
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

Oh indeed, this is a ECDH NISTP-521 public key!
