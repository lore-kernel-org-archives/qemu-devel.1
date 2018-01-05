Received: from eggs.gnu.org ([2001:4830:134:3::10]:48129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eXQVW-0002qF-Q7
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eXQVR-0006Wo-US
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:49:54 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eXQVR-0006UJ-Np
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:49:49 -0500
Received: by mail-wm0-x22d.google.com with SMTP id b76so2020891wmg.1
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 03:49:48 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<151494290795.165.10006581095663113372@5adcb62bf0d6>
	<CAHNT7NuaLUODyFmt5pXH78hq38m4m5GGGO_GGULfprd-sjCX1Q@mail.gmail.com>
	<CAHNT7NuVN4iEkyKQSE+8QKx+To0gYmDVUcFHz=bcXWDTykLZEg@mail.gmail.com>
	<20180103024112.GA25758@localhost.localdomain>
	<CAHNT7Nt0cztkdSuiv77+psXLhTLmWFsKgXYxVgY64ufYzk+8TQ@mail.gmail.com>
	<20180103030556.GA27755@localhost.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180103030556.GA27755@localhost.localdomain>
Date: Fri, 05 Jan 2018 11:49:46 +0000
Message-ID: <87mv1scyp1.fsf@linaro.org>
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
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>


Fam Zheng <famz@redhat.com> writes:

> On Wed, 01/03 15:54, Michael Clark wrote:
>> On Wed, Jan 3, 2018 at 3:41 PM, Fam Zheng <famz@redhat.com> wrote:
>>
>> > On Wed, 01/03 15:00, Michael Clark wrote:
>> > > So it's essentially one error, the single line case pattern for
>> > > table-driven decode which flags for long lines and asks to separate =
break
>> > > onto its own line.
<snip>
>> > Thanks for taking a look! Practically, consistency with the rest of the
>> > code and
>> > human judgements (comments, explanation in replies etc.) often overrid=
e the
>> > checkpatch complaints. Checkpatch is not always right.
<snip>

Fam,

I wonder is there anyway we could signal to patchew that there are some
acknowledged and approved coding style variances in the patch? Would
something like:

  CodingStyleExceptions: 12

Be too polluting to the commit messages? Or perhaps something that can
skip individual tests on a given run:

  CheckpatchFlags: --ignore-long-lines

Thoughts?

--
Alex Benn=C3=A9e
