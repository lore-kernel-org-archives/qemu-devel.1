Received: from eggs.gnu.org ([2001:4830:134:3::10]:48494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cj2fN-0006ZD-E1
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cj2fK-0005DP-BP
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:43:33 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cj2fK-0005D3-4n
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:43:30 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v77so33934414wmv.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 03:43:29 -0800 (PST)
References: <1174847004.5500748.1488361912027.ref@mail.yahoo.com>
	<1174847004.5500748.1488361912027@mail.yahoo.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1174847004.5500748.1488361912027@mail.yahoo.com>
Date: Wed, 01 Mar 2017 11:43:28 +0000
Message-ID: <8760jt2pen.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] adress of translation block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: oussema ben khedher <oussemakeder@yahoo.fr>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


oussema ben khedher <oussemakeder@yahoo.fr> writes:

> hi
> i need help because im really blocked in my educational project
> my problem is i how can i find the adress of the instruction of the end of translation block in qemu (usually it's branch instruction) or the adress of the translation block
> your advice will be very helpful for me .thanks

Rather than continuously spamming the list with the same question you
might find it better to ask on the IRC channel (OFTC/#qemu). While we do
want to help people you can't expect immediate feedback on list
questions, especially when its not clear what you are after.

As to the address of the instruction at the end of the block why do you
need it?

The blocks usually end with a branch taken/not taken so most have 2 exit
points. If you enable -d nochain then the TBs will return to the
run-loop after every basic block executed. With TB chaining in effect
these jumps are directly patched to jump to the next translated block.

Have you read:

  http://wiki.qemu-project.org/Documentation/TCG

? These describe how the TCG works and the general code flow.

--
Alex Bennée
