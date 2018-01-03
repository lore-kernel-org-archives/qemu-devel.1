Received: from eggs.gnu.org ([2001:4830:134:3::10]:48909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWZNS-0000mp-Tv
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 22:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWZNP-0004GG-Np
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 22:06:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eWZNP-0004Fi-Gm
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 22:05:59 -0500
Date: Wed, 3 Jan 2018 11:05:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180103030556.GA27755@localhost.localdomain>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<151494290795.165.10006581095663113372@5adcb62bf0d6>
	<CAHNT7NuaLUODyFmt5pXH78hq38m4m5GGGO_GGULfprd-sjCX1Q@mail.gmail.com>
	<CAHNT7NuVN4iEkyKQSE+8QKx+To0gYmDVUcFHz=bcXWDTykLZEg@mail.gmail.com>
	<20180103024112.GA25758@localhost.localdomain>
	<CAHNT7Nt0cztkdSuiv77+psXLhTLmWFsKgXYxVgY64ufYzk+8TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7Nt0cztkdSuiv77+psXLhTLmWFsKgXYxVgY64ufYzk+8TQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, 01/03 15:54, Michael Clark wrote:
> On Wed, Jan 3, 2018 at 3:41 PM, Fam Zheng <famz@redhat.com> wrote:
> 
> > On Wed, 01/03 15:00, Michael Clark wrote:
> > > So it's essentially one error, the single line case pattern for
> > > table-driven decode which flags for long lines and asks to separate break
> > > onto its own line.
> > >
> > > We have actually reduced the readability of other parts of the code to
> > > conform to this specific rule. In fact I spent a day and a half with
> > > checkpatch, but it didn't seem to make sense for the disassembler.
> > >
> > > The question is should one blindly comply with the rule for
> > > machine-generated tables. Editing the code manually introduces the
> > > potential for human error. I can, if needed, modify the disassembler
> > > generator to output code with the required verbosity.
> >
> > Thanks for taking a look! Practically, consistency with the rest of the
> > code and
> > human judgements (comments, explanation in replies etc.) often override the
> > checkpatch complaints. Checkpatch is not always right.
> 
> 
> Thanks.
> 
> Here is a run with [PATCH v1 04/21] removed to make the checkpatch output
> more readable. checkpatch is (perhaps incorrectly) flagging a request for
> space in a case value that is synthesised from a macro. Case values usually
> don't have space between the value and the colon. It's possibly because the
> case value is constructed from a macro and contains parenthesis. The other
> issue is consistency with existing source in scripts/qemu-binfmt-conf.sh as
> previously noted.

Agreed.

Fam
