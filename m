Received: from eggs.gnu.org ([2001:4830:134:3::10]:45245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXaDd-0007RN-4X
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXaDZ-0003qs-Pi
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:12:05 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:44027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eXaDZ-0003oe-DB
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:12:01 -0500
Received: by mail-wr0-f176.google.com with SMTP id s13so3055296wra.10
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 14:12:00 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<151494290795.165.10006581095663113372@5adcb62bf0d6>
	<CAHNT7NuaLUODyFmt5pXH78hq38m4m5GGGO_GGULfprd-sjCX1Q@mail.gmail.com>
	<CAHNT7NuVN4iEkyKQSE+8QKx+To0gYmDVUcFHz=bcXWDTykLZEg@mail.gmail.com>
	<20180103024112.GA25758@localhost.localdomain>
	<CAHNT7Nt0cztkdSuiv77+psXLhTLmWFsKgXYxVgY64ufYzk+8TQ@mail.gmail.com>
	<20180103030556.GA27755@localhost.localdomain>
	<87mv1scyp1.fsf@linaro.org>
	<20180105122501.GB8592@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1cca701f-a3ed-d048-1661-106f485d2237@redhat.com>
Date: Fri, 5 Jan 2018 23:11:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180105122501.GB8592@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 05/01/2018 13:25, Fam Zheng wrote:
>>
>>   CheckpatchFlags: --ignore-long-lines
> It sounds feasible. Putting these flags after a --- line will keep commit
> message clean.
> 
> OTOH I think we should spend effort on patching checkpatch.pl to implement this.

Maybe just add something like

Patchew-skip: checkpatch

?

Paolo
