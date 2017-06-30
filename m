Received: from eggs.gnu.org ([2001:4830:134:3::10]:52062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dQwIq-0002RB-8b
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dQwIp-0001JG-0Q
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:49:44 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:34358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dQwIo-0001J1-QX
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:49:42 -0400
Received: by mail-qk0-x233.google.com with SMTP id d78so100877389qkb.1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 06:49:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <715c7cf5-0311-425a-9ea0-9a9986b3655b@redhat.com>
References: <CAGKXQyct2Y0DTbSRxCjyDJpR0eSZg3L245mce6QvmtPNJexcrw@mail.gmail.com>
	<715c7cf5-0311-425a-9ea0-9a9986b3655b@redhat.com>
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Fri, 30 Jun 2017 18:19:21 +0430
Message-ID: <CAGKXQydEu1hVXxTKt5tYxCSr2WO0b7s6HxDtkRSD9ZHwHNRPrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] BIT_WORD(start >> TARGET_PAGE_BITS)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

thank you so much Eric
Sorry for too questions
I certainly follow your guide
thanks a lot


On Fri, Jun 30, 2017 at 5:49 PM, Eric Blake <eblake@redhat.com> wrote:

> On 06/30/2017 08:02 AM, ali saeedi wrote:
> > Hello
> > what does the following code do?
> > 'unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS)' ?
>
> I've noticed you've been asking a lot of questions (each as a new
> thread, rather than replying to previous answers), that seem like you
> are not trying very hard to read the code and find an answer for
> yourself.  Rather than just answer you, I'm going to try to teach you
> how to read the source and answer the question yourself.  You may also
> get better answers to your future questions if you ask in the form of
> "this code is confusing me, I think it means this, based on what I read
> at xyz, but would like confirmation or correction" (showing WHAT you
> have already researched) rather than just "what does this code do" (and
> making it feel like you are off-loading the research work onto others).
>
> First, figure out what BIT_WORD does:
>
> $ git grep 'define BIT_WORD'
>
> That should have only one hit, in include/qemu/bitops.h.  Reading it in
> context doesn't have any more comments, but it looks like it is
> computing the number of bits that are available in a word, and looks
> like it is defining a word to be the type most efficiently operated on
> for the current ABI (a long is 32 bits on a 32-bit OS, and 64 bits on a
> 64-bit OS).
>
> It also looks like you are scaling a start address by the number of bits
> in a target page.
>
> So it probably means you are computing the index for which page 'start'
> occurs on (depending on values, it might mean that 'start == 0x0' is
> page 0, 'start == 0x10000' is page 1, and so on), where start is
> initially in the form of the number of bits per page.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
