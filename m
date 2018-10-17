Received: from eggs.gnu.org ([2001:4830:134:3::10]:57506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCkDX-0002r3-W7
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCkDT-0006Nb-DU
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCkDS-0006MQ-W9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:42:19 -0400
References: <20181017090750.4378-1-pbonzini@redhat.com>
	<001f01d465fd$01af8b80$050ea280$@ru>
	<CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
	<0817e2fe-5a97-a4ed-9ae2-2e8dee6c9a43@redhat.com>
	<004201d4660d$e86ef1e0$b94cd5a0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a29da0a1-85d7-c57c-5c42-27594a7849ac@redhat.com>
Date: Wed, 17 Oct 2018 13:42:13 +0200
MIME-Version: 1.0
In-Reply-To: <004201d4660d$e86ef1e0$b94cd5a0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Revert "icount: remove obsolete warp call"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>, 'Clement Deschamps' <clement.deschamps@greensocs.com>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>

On 17/10/2018 13:38, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 17/10/2018 11:53, Artem Pisarenko wrote:
>>> See my last comment in bug report. This kind of modification, even
>>> adapted to changed function name, doesn't solve issue.
>>> I thought long time that it does, but once I catched qemu with a hang.
>>> And of course, I wasn't able to reproduce it. So it just better hides issue.
>>> Take a look at alternative solution from
>>> QBox: https://git.greensocs.com/qemu/qbox/commit/a8ed106032e375e715a531d6e93e4d9ec295dbdb
>>> I didn't catched fail with it (yet).
> 
> Tried to test it, but rr seems to be broken again.
> I'll try to bisect now.

Can we add a test that runs with "make check" and covers the basics of
record/replay's cpus.c bits?

rr is very cool, and we fixed/understood a lot of stuff when getting it
ready for inclusion.  But now it's constantly broken and every time we
change rr we also risk breaking icount.

Paolo
