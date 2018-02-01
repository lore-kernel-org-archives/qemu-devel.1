Received: from eggs.gnu.org ([2001:4830:134:3::10]:49238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehJAJ-0005cS-BW
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehJAF-0003Vo-GG
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:00:51 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:35139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ehJAF-0003VJ-9o
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:00:47 -0500
Received: by mail-oi0-x22a.google.com with SMTP id e15so3934766oiy.2
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 10:00:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484301432.1457228.1517506595503@mail.yahoo.com>
References: <1972503886.3523325.1517308471375.ref@mail.yahoo.com>
	<1972503886.3523325.1517308471375@mail.yahoo.com>
	<20180130115510.GA13988@xz-mi>
	<75114832.1210415.1517487560355@mail.yahoo.com>
	<CAFEAcA-OSN4MVVr6hbMVwiFs-tYVFH8hW5QvF3KvyXZPsEZpKQ@mail.gmail.com>
	<1484301432.1457228.1517506595503@mail.yahoo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2018 18:00:24 +0000
Message-ID: <CAFEAcA8psfu6PMDjxG-CRODEx2fP8e2N-EB84E-Y8CunkfYi5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Savevm and loadvm not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sridhar kulkarni <sridhar_kulk@yahoo.com>
Cc: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 1 February 2018 at 17:36, sridhar kulkarni <sridhar_kulk@yahoo.com> wrote:
> Sorry I meant to say arm a7. We are using a custom board "arm-machine" which
> is based on Vexpress-a15 but we use a7 core. I learnt reading through web
> sources that A7 emulation is not supported in qemu. Is this causing this
> behaviour? But in general we are able to run all our code on this virtual
> board without any issues. While doing snapshot, this problem is seen.

I can't really help if you're using a custom QEMU. If you
can reproduce this with upstream QEMU then we can certainly
take a look at it. Otherwise, the problem is very likely
in whatever the custom modifications are. It should not
be too hard for whoever is responsible for those changes
to track down the problem (which is probably a new coprocessor
register definition that doesn't have the right flags on it),
so I would talk to them about this issue.

thanks
-- PMM
