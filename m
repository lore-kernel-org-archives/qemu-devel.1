Received: from eggs.gnu.org ([209.51.188.92]:53614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gzaTp-0004t9-I1
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gzaTo-0000ow-V0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:13:05 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:48652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gzaTo-0000nX-Nb
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:13:04 -0500
Date: Thu, 28 Feb 2019 21:12:58 -0800
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190301051258.ylba7d4zg5uobk3i@function>
References: <CACxphuFGAODB_=X1fVFqJa=U14E_YSJMreWJcOgzdsooke1wxg@mail.gmail.com>
	<20190228205109.hmldtldbnlw3pnqq@function>
	<CACxphuHr-Eo6JoPzZWvaZ_29GjxRzP=saWUKCKQxTuBa8qC9mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACxphuHr-Eo6JoPzZWvaZ_29GjxRzP=saWUKCKQxTuBa8qC9mg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] socket: fix blocking udp recvfrom.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: llyzs <llyzs.vic@gmail.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>

llyzs, le ven. 01 mars 2019 12:27:31 +0800, a ecrit:
> I believe this is because UDP packet can have 0 length payload.

Ah, right, that one makes sense indeed.

> I also found out that sometimes ioctlsocket() call can return error
> (probably caused by my unstable wifi linux driver), in which case we
> can also return immediately.

We should check for the value returned by ioctlsocket() then, otherwise
the value of n is undefined.

Samuel
