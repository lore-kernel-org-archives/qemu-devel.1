Received: from eggs.gnu.org ([2001:4830:134:3::10]:40381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ettZL-0004YQ-HZ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ettZJ-00021f-Fy
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:43 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:42733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ettZJ-00021F-8g
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:41 -0500
Received: by mail-ot0-x234.google.com with SMTP id l5so5044501otf.9
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 03:18:41 -0800 (PST)
MIME-Version: 1.0
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_G1tHrBZ=GxAy0b-SLbYU2-XOAUNL0D=8MQeL0Roz_cQ@mail.gmail.com>
	<CAHNT7NtRnSB-GYHp=v3iM7+_72y43YpZesbYCrnTvCikTiUMuw@mail.gmail.com>
In-Reply-To: <CAHNT7NtRnSB-GYHp=v3iM7+_72y43YpZesbYCrnTvCikTiUMuw@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 08 Mar 2018 11:18:30 +0000
Message-ID: <CAHNT7NuqgY-zgPJT4gUJMaHr24E-PwrN=Eje+m1XW24mAf07Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Fri, 9 Mar 2018 at 12:10 AM, Michael Clark <mjc@sifive.com> wrote:

> On Thu, 8 Mar 2018 at 11:02 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On 6 March 2018 at 19:46, Michael Clark <mjc@sifive.com> wrote:
>> > -----BEGIN PGP SIGNED MESSAGE-----
>> > Hash: SHA1
>> >
>> > The following changes since commit
>> f32408f3b472a088467474ab152be3b6285b2d7b:
>> >
>> >   misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:3=
0
>> +0000)
>> >
>> > are available in the git repository at:
>> >
>> >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v8.=
2
>> >
>> > for you to fetch changes up to 7051b081bf6796e5e84406f6223a7c4900bf729=
8:
>> >
>> >   RISC-V - Remove support for adhoc non-standard X_COP local-interrupt
>> (2018-03-07 08:36:03 +1300)
>>
>>
>> Hi -- I would have applied this, but some of the commits
>> have no signed-off-by lines.
>>
>> This is important, and I've already asked for it once. We cannot
>> accept anything that doesn't have a clear record in the commit
>> message of everybody (person or company) who's contributed code
>> to it, indicating that they're happy for their copyrighted
>> contributions to be taken into QEMU under our license. Lists
>> of names without emails in the cover letter are not sufficient.
>>
>> In fact a lot of the last part of this patchset looks like
>> unreviewed changes/fixes that if we were going to have them we
>> should have squashed into the correct patches and resent the
>> series for review. Please don't do this. Code review is an
>> important part of how the QEMU project works.
>
>
> You must be looking at the wrong tag. There are multiple sign-offs in all
> 23 commits. The tag is riscv-qemu-upstream-v8.2. Sagar and Bastian
> contacted me out of band to add their sign-offs. Please look at the commi=
ts
> again and tell me which commit id doesn=E2=80=99t have a sign-off on that=
 tag (23
> commits iirc)
>

I can forward you the mail out-of-band. I had to contact contributors to
get them to agree to change the license from MIT to GPLv2, based on a
request from Red Hat.

You are making this very hard. Do you work for Arm perchance? I really
wouldn=E2=80=99t be surprised if our port is being sandbagged by Arm. Apolo=
gies for
being so direct about this, but things like this happen...

I have complied with practically every review request and the sign-offs are
there. It=E2=80=99s a bit ridiculous.

It would be nice to find someone neutral, unrelated to Arm, to merge our PR

>
