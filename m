Received: from eggs.gnu.org ([2001:4830:134:3::10]:37297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgts-0005hD-Im
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgtn-0004T8-I5
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:46:32 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgtn-0004SZ-BW
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:46:27 -0400
Received: by mail-wr0-x236.google.com with SMTP id c11so82637957wrc.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:46:27 -0700 (PDT)
References: <CAFd4ddwJYpLCzXViDh6MhwZyurMi_LrO-dgnSrciCNB2UDXiCQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFd4ddwJYpLCzXViDh6MhwZyurMi_LrO-dgnSrciCNB2UDXiCQ@mail.gmail.com>
Date: Wed, 21 Jun 2017 15:47:09 +0100
Message-ID: <87lgoltn2q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Instruction tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Cc: qemu-devel@nongnu.org


Nayan Deshmukh <nayan26deshmukh@gmail.com> writes:

> Hello!
>
> I was wondering if its possible to get an instruction trace of the
> process running on the guest OS in the VM including the instructions
> executed during system calls.
>
> Can someone please give me some pointers regarding how this could be
> implemented.

 $QEMU -d help

Will list a bunch of debug options for TCG. You can get somewhat close
to what you want with:

 $QEMU $OPTS -d in_asm,exec,nochain

>
> Cheers,
> Nayan Deshmukh


--
Alex Bennée
