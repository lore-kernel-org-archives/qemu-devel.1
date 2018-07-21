Received: from eggs.gnu.org ([2001:4830:134:3::10]:39311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fglMf-0004cs-Cs
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 02:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fglMc-0002pe-9C
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 02:27:37 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1fglMc-0002oz-3x
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 02:27:34 -0400
Received: by mail-vk0-f65.google.com with SMTP id y70-v6so7055968vkc.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 23:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180719034118.27741-1-famz@redhat.com>
	<6757101d-316a-79f5-1dbc-4546b054c9da@redhat.com>
	<20180720082427.GG29900@lemon.usersys.redhat.com>
	<8b2000e0-a0ed-b096-422f-ef6ac31b1578@redhat.com>
In-Reply-To: <8b2000e0-a0ed-b096-422f-ef6ac31b1578@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Sat, 21 Jul 2018 14:26:56 +0800
Message-ID: <CAK1Eb9n9GArCVmZmE36EnoRSJEVg=vMUmQC7ovcAViYLGGV7pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Don't lock /dev/null
 and /dev/zero automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Sat, Jul 21, 2018 at 12:35 AM Eric Blake <eblake@redhat.com> wrote:
>
> On 07/20/2018 03:24 AM, Fam Zheng wrote:
> I'm not familiar with /dev/nullb* - is that a typo?
>
> $ ll /dev/nullb*
> ls: cannot access '/dev/nullb*': No such file or directory

You probably have figured out already but just in case: it's kernel
null_blk mod.

Fam
