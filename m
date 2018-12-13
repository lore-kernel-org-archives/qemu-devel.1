Received: from eggs.gnu.org ([2001:4830:134:3::10]:38798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXYwI-0008AQ-U6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXYwB-0006Nh-NJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:54:38 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:45130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gXYwA-0005GG-V0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:54:31 -0500
Received: by mail-ua1-f50.google.com with SMTP id e16so1271486uam.12
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 13:54:00 -0800 (PST)
MIME-Version: 1.0
References: <DB6PR07MB33330E3562B0AF0ECC8307BCAEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<DB6PR07MB3333E95C513AF2EF14AAE615AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<14b32e39-a9f6-1a83-87e6-6e150954ddb7@redhat.com>
	<20181213144914.GH5427@linux.fritz.box>
	<db4f1763-e28f-387c-2652-ba71c29e97ff@redhat.com>
	<DB6PR07MB3333BA55F6C06E1DB3388D55AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
In-Reply-To: <DB6PR07MB3333BA55F6C06E1DB3388D55AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 13 Dec 2018 23:53:47 +0200
Message-ID: <CAMRbyyug2e_MK+Nzdzso9RheENVzuTba5nYzjBNZbrXCaB2hrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] Request for clarification on qemu-img
 convert behavior zeroing target host_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.de_backer@nokia.com
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, owais.aamir_t@nokia.com

On Thu, Dec 13, 2018 at 11:14 PM De Backer, Fred (Nokia - BE/Antwerp) <
fred.de_backer@nokia.com> wrote:

> > Indeed, performance traces are important for issues like this.
> See strace of both FC27 and FC29 attached
>

Looks like you traced only the main thread. All the I/O is done in other
threads.
These flags would be useful:

    strace -o log -f -T -tt

Nir
