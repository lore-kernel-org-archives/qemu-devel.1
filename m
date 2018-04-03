Received: from eggs.gnu.org ([2001:4830:134:3::10]:34837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lindsay.mathieson@gmail.com>) id 1f3CRY-0005QS-6E
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lindsay.mathieson@gmail.com>) id 1f3CRX-0000TZ-0b
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:17:08 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:33018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lindsay.mathieson@gmail.com>)
	id 1f3CRW-0000TQ-Qb
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:17:06 -0400
Received: by mail-qt0-x229.google.com with SMTP id d50so10351771qtc.0
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 20:17:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403031147.GC6839@lemon.usersys.redhat.com>
References: <CAEMkAmGoPm8p0MKumctDPodaD4PCUYi4X=ovs+kMO9xTKGkLeQ@mail.gmail.com>
	<20180403031147.GC6839@lemon.usersys.redhat.com>
From: Lindsay Mathieson <lindsay.mathieson@gmail.com>
Date: Tue, 3 Apr 2018 13:17:05 +1000
Message-ID: <CAEMkAmGrW=h5Z1YncOQ4v2nmHt99-0Wg6aP6yCTd2p-ooToA4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Loadable block drivers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 3 April 2018 at 13:11, Fam Zheng <famz@redhat.com> wrote:

> On Tue, 04/03 12:59, Lindsay Mathieson wrote:
> > Hi all, was looking at developing a block driver for qemu - have examined
> > the drivers at:
> >
> >   https://github.com/qemu/qemu/tree/master/block
> >
> > And it seems straightforward enough.
> >
> > One thing that is unclear - all the drivers appear to be compiled
> directly
> > into qemu. Is there no way to load them dynamically as .so modules?
>
> './configure --enable-modules' will enable building block drivers as .so
> objects, and they are loaded dynamically. These are in-tree .so modules;
> out-of-tree modules like in Linux kernel are intentionally forbidden.
>
> Fam
>



Rats, I take it that means I can't develop a testing block module and load
it with an pre-existing qemu install.

thanks.

-- 
Lindsay
