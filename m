Received: from eggs.gnu.org ([2001:4830:134:3::10]:45836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eXRHE-0000YG-Ub
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eXRHB-0001gG-RF
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:39:12 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eXRHB-0001fU-KB
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:39:09 -0500
Received: by mail-wm0-x232.google.com with SMTP id f140so2229431wmd.2
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 04:39:09 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<151494290795.165.10006581095663113372@5adcb62bf0d6>
	<CAHNT7NuaLUODyFmt5pXH78hq38m4m5GGGO_GGULfprd-sjCX1Q@mail.gmail.com>
	<CAHNT7NuVN4iEkyKQSE+8QKx+To0gYmDVUcFHz=bcXWDTykLZEg@mail.gmail.com>
	<20180103024112.GA25758@localhost.localdomain>
	<CAHNT7Nt0cztkdSuiv77+psXLhTLmWFsKgXYxVgY64ufYzk+8TQ@mail.gmail.com>
	<20180103030556.GA27755@localhost.localdomain>
	<87mv1scyp1.fsf@linaro.org>
	<20180105122501.GB8592@lemon.usersys.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180105122501.GB8592@lemon.usersys.redhat.com>
Date: Fri, 05 Jan 2018 12:39:07 +0000
Message-ID: <87lghccwes.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>


Fam Zheng <famz@redhat.com> writes:

> On Fri, 01/05 11:49, Alex Benn=C3=A9e wrote:
>>
>> Fam Zheng <famz@redhat.com> writes:
>>
>> > On Wed, 01/03 15:54, Michael Clark wrote:
>> >> On Wed, Jan 3, 2018 at 3:41 PM, Fam Zheng <famz@redhat.com> wrote:
>> >>
>> >> > On Wed, 01/03 15:00, Michael Clark wrote:
>> >> > > So it's essentially one error, the single line case pattern for
>> >> > > table-driven decode which flags for long lines and asks to separa=
te break
>> >> > > onto its own line.
>> <snip>
>> >> > Thanks for taking a look! Practically, consistency with the rest of=
 the
>> >> > code and
>> >> > human judgements (comments, explanation in replies etc.) often over=
ride the
>> >> > checkpatch complaints. Checkpatch is not always right.
>> <snip>
>>
>> Fam,
>>
>> I wonder is there anyway we could signal to patchew that there are some
>> acknowledged and approved coding style variances in the patch? Would
>> something like:
>>
>>   CodingStyleExceptions: 12
>>
>> Be too polluting to the commit messages? Or perhaps something that can
>> skip individual tests on a given run:
>>
>>   CheckpatchFlags: --ignore-long-lines
>
> It sounds feasible. Putting these flags after a --- line will keep commit
> message clean.
>
> OTOH I think we should spend effort on patching checkpatch.pl to
> implement this.

I guess your right, given checkpatch is going to ingest the patch
anyway.

>
> Fam


--
Alex Benn=C3=A9e
