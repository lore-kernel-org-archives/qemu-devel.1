Received: from eggs.gnu.org ([2001:4830:134:3::10]:50845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fYuA7-000782-AP
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fYuA5-0002ac-Ey
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:14:11 -0400
Received: from mail-lf0-x232.google.com ([2a00:1450:4010:c07::232]:36445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fYuA4-0002Vs-Kg
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:14:09 -0400
Received: by mail-lf0-x232.google.com with SMTP id n24-v6so6913863lfh.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:14:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA83eO5DZawurRmLtuV4jBL8s23EHaUCFLS7_c9mGHEdxA@mail.gmail.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
	<CAFEAcA8rRRTYhS-JNBTeJfZDydYEdNpab_TPieyrKcV5cad0SA@mail.gmail.com>
	<23cb43c1-15aa-187b-3711-da7847396a01@amsat.org>
	<CAFEAcA83eO5DZawurRmLtuV4jBL8s23EHaUCFLS7_c9mGHEdxA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 Jun 2018 07:13:36 -0700
Message-ID: <CAKmqyKMB-KeukYvsSfvj+Sv6_eQoTP+1_iztuMuy-yJqVzP1Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 29, 2018 at 2:41 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 28 June 2018 at 22:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
>> On 06/28/2018 01:52 PM, Peter Maydell wrote:
>>> On 27 June 2018 at 18:44, Alistair Francis <alistair.francis@wdc.com> w=
rote:
>>>> The following changes since commit 00928a421d47f49691cace1207481b7aad3=
1b1f1:
>>>>
>>>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-=
20180626' into staging (2018-06-26 18:23:49 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180627
>>>>
>>>> for you to fetch changes up to e5f5e16b67dc8a342f937bc00ebb2a6475e3505=
0:
>>>>
>>>>   hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-06-=
27 10:35:19 -0700)
>>>>
>>>
>>> Something strange is up with the key used to sign this:
>>>
>>> $ gpg --recv-keys 7048B74B4C1B39E4
>>> gpg: requesting key 0x7048B74B4C1B39E4 from hkp server keys.gnupg.net
>>> gpg: key 0xE48E3BC2C123ED93: no valid user IDs
>>> gpg: this may be caused by a missing self-signature
>>> gpg: Total number processed: 1
>>> gpg:           w/o user IDs: 1
>>
>> It seems the SKS keyserver pool is having some problem:
>> https://sks-keyservers.net/status/
>
>> The server is temporarily unable to service your request due to
>> maintenance downtime or capacity problems. Please try again later.
>
> Hmm, there does seem to be something up with the pool. On
> the other hand:
>
>> $ gpg --keyserver hkp://18.191.65.131 --recv-keys 7048B74B4C1B39E4
>
> This command with this specific server doesn't work for me
> (fails the same way with the "no valid user IDs" message),
> and using keyserver.ubuntu.com (which seems otherwise fine)
> also fails that way...

I'm not sure what else to do. I have submitted it to all of those key
servers through GPG and through the web interface. I never see an
error, but it doesn't show up under the web search.

Can you import it manually? The armour export is below:

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
zafpeVkcoSpABQrI2UQ=3D
=3DxMq1
-----END PGP PUBLIC KEY BLOCK-----

Alistair

>
> thanks
> -- PMM
