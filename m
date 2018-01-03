Received: from eggs.gnu.org ([2001:4830:134:3::10]:34719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWYzZ-00017K-9q
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWYzU-0005B4-Eu
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:41:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eWYzU-0005AJ-7w
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:41:16 -0500
Date: Wed, 3 Jan 2018 10:41:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180103024112.GA25758@localhost.localdomain>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<151494290795.165.10006581095663113372@5adcb62bf0d6>
	<CAHNT7NuaLUODyFmt5pXH78hq38m4m5GGGO_GGULfprd-sjCX1Q@mail.gmail.com>
	<CAHNT7NuVN4iEkyKQSE+8QKx+To0gYmDVUcFHz=bcXWDTykLZEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7NuVN4iEkyKQSE+8QKx+To0gYmDVUcFHz=bcXWDTykLZEg@mail.gmail.com>
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
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, 01/03 15:00, Michael Clark wrote:
> So it's essentially one error, the single line case pattern for
> table-driven decode which flags for long lines and asks to separate break
> onto its own line.
> 
> We have actually reduced the readability of other parts of the code to
> conform to this specific rule. In fact I spent a day and a half with
> checkpatch, but it didn't seem to make sense for the disassembler.
> 
> The question is should one blindly comply with the rule for
> machine-generated tables. Editing the code manually introduces the
> potential for human error. I can, if needed, modify the disassembler
> generator to output code with the required verbosity.

Thanks for taking a look! Practically, consistency with the rest of the code and
human judgements (comments, explanation in replies etc.) often override the
checkpatch complaints. Checkpatch is not always right.

Fam
