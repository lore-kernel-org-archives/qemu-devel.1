Received: from eggs.gnu.org ([2001:4830:134:3::10]:45909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euJrP-0004kl-TY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euJrP-0000m9-0D
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:23:07 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euJrO-0000m0-QR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:23:06 -0500
Received: by mail-ot0-x242.google.com with SMTP id f11so8966823otj.12
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:23:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87woyljn53.fsf@linaro.org>
References: <CAHNT7NshwZh87Uui6i+ARdOj2BuW6d7gahOiZ0X48Cf3TdOrXQ@mail.gmail.com>
	<mhng-91cb2b22-0b57-4c9b-8027-8c25eba32497@palmer-si-x1c4>
	<CAHNT7NvDiUHs6cBTd57uO+VdaAyQnH+2s4kp4yiQ1uBS15A22g@mail.gmail.com>
	<CAFEAcA9jWUqFenf=P3bhiJ5iGCZ2kBc7eZxv3BRzO+jd=9h7nQ@mail.gmail.com>
	<CAHNT7NuBjcngEesbS4XSwn=gw7S8VYVE_e6FjxKuAHfjoWowjQ@mail.gmail.com>
	<87woyljn53.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 15:22:45 +0000
Message-ID: <CAFEAcA-8qhR7w8FJsiCmqR+14M4OQRhv2mu7L5pXJeqhtXTg4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
 v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 9 March 2018 at 15:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Michael Clark <mjc@sifive.com> writes:
>
> <snip>
>>
>> BTW - I've integrated the following 3 branches into the riscv tree:
>>
>> - https://github.com/riscv/riscv-qemu/tree/softfloat-snan-abort-fix
>> - https://github.com/riscv/riscv-qemu/tree/riscv-qemu-upstream-v8.2
>> - https://github.com/michaeljclark/riscv-qemu/tree/qemu-devel
>>
>> into our `riscv-all` integration branch, and we're now passing all FPU
>> tests, interestingly, including the NaN-boxing of single precision value=
s
>> into doubles. We'll need to check that the riscv-tests testsuite is
>> exhastive enough... Suprised! I think Richard might have thought about
>> our NaN-boxing
>> issue or some other sort of magic is going on :-)
>>
>> - https://github.com/riscv/riscv-qemu/tree/riscv-all
>
> Is the SNaN patch going to get re-posted now it has had a review?

I'm just in the process of applying that to master now...

-- PMM
