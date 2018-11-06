Received: from eggs.gnu.org ([2001:4830:134:3::10]:38820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gJtUP-0007OC-PN
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gJtUP-0003YD-32
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:01:21 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:38233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gJtUO-0003Y5-V5
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:01:21 -0500
Received: by mail-ot1-x335.google.com with SMTP id f24so10311301otl.5
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 21:01:20 -0800 (PST)
MIME-Version: 1.0
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
	<1539894735-14232-4-git-send-email-pbonzini@redhat.com>
	<01124fd1-83b2-c0c8-21d7-1f031a21ff3b@redhat.com>
In-Reply-To: <01124fd1-83b2-c0c8-21d7-1f031a21ff3b@redhat.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Tue, 6 Nov 2018 11:01:08 +0600
Message-ID: <CANzW0msoLsvgDSiiP6VVYTpprEzVYVSgL32sHV5kWXHvXsew=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 03/48] qemu-timer: introduce timer attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

> hw/core/ptimer.o: In function `timer_new_tl':
> /home/eblake/qemu/include/qemu/timer.h:536: undefined reference to
> `timer_init_tl'
> collect2: error: ld returned 1 exit status
> make: *** [/home/eblake/qemu/rules.mak:124: tests/ptimer-test] Error 1
> make: *** Waiting for unfinished jobs....

I wasn't able to reproduce that on
commit 89a603a0c80ae3d6a8711571550b2ae9a01ea909 (is it that commit you
point to ?).
Neither 'make check' fails, nor "include/qemu/timer.h:536" points to
meaningful lines of code, nor full project text search shows anything like
'timer_new_tl' or 'timer_init_tl'. Same for merge
comit b312532fd03413d0e6ae6767ec793a3e30f487b8.
Looks like 'make' just failed to rebuild dependencies correctly and needs
clean/distclean.
