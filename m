Received: from eggs.gnu.org ([2001:4830:134:3::10]:46120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYpu8-0006Bt-FM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYpu7-000313-68
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:41:24 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:45988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYpu7-0002zb-0E
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:41:23 -0400
Received: by mail-oi0-x22c.google.com with SMTP id 188-v6so7873264oid.12
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 02:41:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <23cb43c1-15aa-187b-3711-da7847396a01@amsat.org>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
	<CAFEAcA8rRRTYhS-JNBTeJfZDydYEdNpab_TPieyrKcV5cad0SA@mail.gmail.com>
	<23cb43c1-15aa-187b-3711-da7847396a01@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 10:41:01 +0100
Message-ID: <CAFEAcA83eO5DZawurRmLtuV4jBL8s23EHaUCFLS7_c9mGHEdxA@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair23@gmail.com>

On 28 June 2018 at 22:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> On 06/28/2018 01:52 PM, Peter Maydell wrote:
>> On 27 June 2018 at 18:44, Alistair Francis <alistair.francis@wdc.com> wr=
ote:
>>> The following changes since commit 00928a421d47f49691cace1207481b7aad31=
b1f1:
>>>
>>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2=
0180626' into staging (2018-06-26 18:23:49 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180627
>>>
>>> for you to fetch changes up to e5f5e16b67dc8a342f937bc00ebb2a6475e35050=
:
>>>
>>>   hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-06-2=
7 10:35:19 -0700)
>>>
>>
>> Something strange is up with the key used to sign this:
>>
>> $ gpg --recv-keys 7048B74B4C1B39E4
>> gpg: requesting key 0x7048B74B4C1B39E4 from hkp server keys.gnupg.net
>> gpg: key 0xE48E3BC2C123ED93: no valid user IDs
>> gpg: this may be caused by a missing self-signature
>> gpg: Total number processed: 1
>> gpg:           w/o user IDs: 1
>
> It seems the SKS keyserver pool is having some problem:
> https://sks-keyservers.net/status/

> The server is temporarily unable to service your request due to
> maintenance downtime or capacity problems. Please try again later.

Hmm, there does seem to be something up with the pool. On
the other hand:

> $ gpg --keyserver hkp://18.191.65.131 --recv-keys 7048B74B4C1B39E4

This command with this specific server doesn't work for me
(fails the same way with the "no valid user IDs" message),
and using keyserver.ubuntu.com (which seems otherwise fine)
also fails that way...

thanks
-- PMM
