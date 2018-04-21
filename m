Received: from eggs.gnu.org ([2001:4830:134:3::10]:59176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9pO9-0007nf-66
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 06:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9pO8-0000g0-4q
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 06:05:01 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:44808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f9pO7-0000dv-UH
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 06:05:00 -0400
Received: by mail-wr0-x235.google.com with SMTP id o15-v6so28809654wro.11
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 03:04:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG0V3WTu2TBFRkcRyO7oHuGWxa=wuEAvRjkK6f39AcswDWNmxg@mail.gmail.com>
References: <CAG0V3WRdK+p-qo9NmnKkKT6kMNBJBxj9vNuYBSzX7zrZU8FGiA@mail.gmail.com>
	<20180420073932.GI15181@stefanha-x1.localdomain>
	<CAG0V3WTu2TBFRkcRyO7oHuGWxa=wuEAvRjkK6f39AcswDWNmxg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 21 Apr 2018 18:04:57 +0800
Message-ID: <CAJSP0QV++fzNx6iGVnOJ3PhqiKG52-viJ7wtz9BuOrpVQniTUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Let event loop use non-default GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eva Chen <debby83729@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Sat, Apr 21, 2018 at 11:29 AM, Eva Chen <debby83729@gmail.com> wrote:
> Thanks for your reply.
>
> Actually, I don't know there is existing work on emulating heterogeneous
> system under QEMU. The only work I know is that QEMU has implemented
> multicore in one QEMU process. But what I want to do is to simulate two
> heterogeneous cpu core at the same time.
> May I ask if you know any related work?

I'm not familiar with the work that has been done, but here are two
starting points you may find interesting:

http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.1007.285&rep=rep1&type=pdf

https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg00171.html

Stefan
