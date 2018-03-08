Received: from eggs.gnu.org ([2001:4830:134:3::10]:45808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu1bu-00005F-2n
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu1bs-00038B-EO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:53:54 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:40480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu1bs-00037y-60
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:53:52 -0500
Received: by mail-ot0-x235.google.com with SMTP id l12so6574534otj.7
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 11:53:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <mhng-91cb2b22-0b57-4c9b-8027-8c25eba32497@palmer-si-x1c4>
References: <CAHNT7NshwZh87Uui6i+ARdOj2BuW6d7gahOiZ0X48Cf3TdOrXQ@mail.gmail.com>
	<mhng-91cb2b22-0b57-4c9b-8027-8c25eba32497@palmer-si-x1c4>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 9 Mar 2018 08:53:50 +1300
Message-ID: <CAHNT7NvDiUHs6cBTd57uO+VdaAyQnH+2s4kp4yiQ1uBS15A22g@mail.gmail.com>
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
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Fri, Mar 9, 2018 at 8:29 AM, Palmer Dabbelt <palmer@sifive.com> wrote:

> On Thu, 08 Mar 2018 03:41:33 PST (-0800), Michael Clark wrote:
>
>> On Fri, 9 Mar 2018 at 12:18 AM, Michael Clark <mjc@sifive.com> wrote:
>>
>>> On Fri, 9 Mar 2018 at 12:10 AM, Michael Clark <mjc@sifive.com> wrote:
>>>
>>>> On Thu, 8 Mar 2018 at 11:02 PM, Peter Maydell <peter.maydell@linaro.or=
g
>>>> >
>>>> wrote:
>>>>
>>>>> On 6 March 2018 at 19:46, Michael Clark <mjc@sifive.com> wrote:
>>>>>
>>>> You are making this very hard. Do you work for Arm perchance? I really
>>> wouldn=E2=80=99t be surprised if our port is being sandbagged by Arm. A=
pologies
>>> for
>>> being so direct about this, but things like this happen...
>>>
>>> I have complied with practically every review request and the sign-offs
>>> are there. It=E2=80=99s a bit ridiculous.
>>>
>>> It would be nice to find someone neutral, unrelated to Arm, to merge ou=
r
>>> PR
>>>
>>>
>> Some history on the origins of RISC to put things in perspective:
>>
>> https://en.m.wikipedia.org/wiki/Berkeley_RISC
>>
>> David Patterson worked with Andrew Waterman and Krste Asanovic on the
>> design of RISC-V. Sagar did most of the work on the QEMU port and he
>> agreeded to sign off on all patches. The SiFive patches only have
>> sign-offs
>> from SiFive because SiFive was the sole contributor for its hardware
>> model,
>> beside the SiFiveUART which has Stefan=E2=80=99s sign-off.
>>
>> In any case it seems there is not enough review bandwidth in the QEMU
>> project as a whole and the policy to accept contributions is too strict =
to
>> be reasonable, given earnest attempts to comply with *all* review
>> feedback.
>> Not impressed.
>>
>
> On behalf of the rest of the RISC-V QEMU team I'd like to apologize for
> Michael's comments.  That's a pretty insulting thing to say, and the whol=
e
> thing comes off as a bit entitled: we've asked the QEMU community to do a
> lot of work for us in reviewing our port, and seeing as how none of us ar=
e
> QEMU contributors we certainly don't have any grounds to ask someone to
> stop reviewing it -- that's pretty absurd.
>
> While I haven't been following the upstreaming process as closely as I
> should have been, as far as I can tell there's no grounds to accuse Peter=
,
> or anyone else, of trying to shoot down our port for any reason.  Peter, =
I
> can understand if you're upset, as I certainly would be.  If you don't wa=
nt
> to help out with our port any more then I can understand, but I'd just li=
ke
> to assure you that we value the time you've spent on our port and hope yo=
u
> continue to help out!
>
> Hopefully this doesn't derail our chances of moving forward with
> submitting the RISC-V port upstream.
>
> Sorry!
>

I re-iterate Palmer's apology.

I shouldn't be polling git.qemu.org/qemu.git and answering emails near
to 3am in the morning after 4 months of working on trying to get the RISC-V
port in shape to go upstream.

It appears it is completely my mistake and I had tagged early deltas on top
of v8.2 instead of the tip of v8.2.

I've force pushed the 'riscv-qemu-upstream-v8.2' so only the mailing list
will hold the history of my mistake.

$ git push -f --tags
Counting objects: 1, done.
Writing objects: 100% (1/1), 6.31 KiB | 0 bytes/s, done.
Total 1 (delta 0), reused 0 (delta 0)
To git@github.com:riscv/riscv-qemu.git
 + feb8f5e...2c7f042 riscv-qemu-upstream-v8.2 -> riscv-qemu-upstream-v8.2
(forced update)
